require 'tweetstream'
require 'twitter'
require 'docomoru'
require 'open_weather_map'
require './weather.rb'
require './dispacher.rb'

TweetStream.configure do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['ACCESS_KEY']
  config.oauth_token_secret = ENV['ACCESS_SECRET']
  config.auth_method        = :oauth
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_KEY']
  config.access_token_secret = ENV['ACCESS_SECRET']
end

puts 'Configuration Success'

streamclient = TweetStream::Client.new
streamclient.userstream do |status|
  # The status object is a special Hash with
  #   # method access to its keys.
  p status.id
  dispacher = Dispacher.new(status)
  if dispacher.to_me?
    response = ''
    case dispacher.tweet_type
    when 'weather'
      if Weather.present? dispacher.get_tweet
        weather = Weather.new(dispacher.get_tweet)
        o_weather = OpenWeatherMap::City.new('Jp', weather.place)
        response = "#{weather.jp_place}の天気は#{o_weather.cond}で、最高気温は#{o_weather.temp_max - 273.15}、最低気温は#{o_weather.temp_min - 273.15}です。"

      end
    else 
      #when 'talk'
      docomo_client = Docomoru::Client.new(api_key: ENV['DOCOMO_API_KEY'])
      response = docomo_client.create_dialogue(dispacher.get_tweet).body['utt']
    end
    p response

    client.update("@otukutun #{response}", in_reply_to_status_id: status.id)
  end
end
