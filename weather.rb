require 'rest_client'

class Weather
  URL = 'http://api.openweathermap.org/data/2.5/weather'
  def initialize(country, city)
    @country = country
    @city = city
    @result = req
  end

  def cond
    @result['weather'][0]['main']
  end

  def temp_min
    @result['main']['temp_min']
  end

  def temp_max
    @result['main']['temp_max']
  end

  private
  def req
    response = RestClient.get URL, {:params => {q: "#{@city},#{@country}"}}
    @result = JSON.parse(response)
  end

end
