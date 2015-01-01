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
  #p status[:user][:screen_name]
  puts "#{status.text}"
  dispacher = Dispacher.new(status)
  if tweet = dispacher.to_me
    puts tweet
    docomo_client = Docomoru::Client.new(api_key: ENV['DOCOMO_API_KEY'])
    response = docomo_client.create_dialogue(tweet)

    client.update("@otukutun #{response.body['utt']}")
  end
end
