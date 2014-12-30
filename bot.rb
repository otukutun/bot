require 'tweetstream'
require 'twitter'
require 'docomoru'
require './weather.rb'

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
  username = status[:user][:screen_name]
  if username == 'otukutun' && status.text.match(/(^@otukutun_bot\s)(.*)/)
    puts "#{status.text}"
    docomo_client = Docomoru::Client.new(api_key: ENV['DOCOMO_API_KEY'])
    response = docomo_client.create_dialogue($1)
    
    client.update("@otukutun #{response.body['utt']}")
  end
end
