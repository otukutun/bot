require 'tweetstream'
require 'twitter'
require './weather.rb'

streamclient = TweetStream.configure do |config|
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

client.update("test#{Time.now}")

puts 'Tweet success'

streamclient.userstream do |status|
  username = status[:user][:screen_name]
  contents = status[:text]
  id = status[:id]
  str = username + ":" + contents
  puts str
end
