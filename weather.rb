require 'rest_client'
module OpenWeatherMap
  class Coordinate
    URL = 'http://api.openweathermap.org/data/2.5/weather'
    def initialize(lat, lon, mode = 'json')
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
    def request
      response = RestClient.get URL, {:params => {q: "#{@city},#{@country}"}}
      @result = JSON.parse(response)
    end

  end
end
