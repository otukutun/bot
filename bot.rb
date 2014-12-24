require 'tweetstream'
require 'twitter'
require './weather.rb'

TweetStream.configure do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['ACCESS_KEY']
  config.oauth_token_secret = ENV['ACCESS_SECRET']
  #config.auth_method        = :oauth
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_KEY']
  config.access_token_secret = ENV['ACCESS_SECRET']
end

puts 'Configuration Success'

#streamclient = TweetStream::Client.new

TweetStream::Client.new.sample do |status|
  # The status object is a special Hash with
  #   # method access to its keys.
  client.update("test#{Time.now}")
  puts "#{status.text}"
end

#client.update("test#{Time.now}")

#streamclient.on_timeline_status  do |status|
#    puts status.text
#end

#streamclient.userstream

#puts 'Tweet success'


#streamclient.userstream do |status|
#  username = status[:user][:screen_name]
#  contents = status[:text]
#  id = status[:id]
#  str = username + ":" + contents
#  puts str
#  #if username == 'otukutun'
#  #  client.update("test#{Time.now}")
#  #  puts str
#  #end
#end
