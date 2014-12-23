require 'chatroid'
require './weather.rb'

Chatroid.new do
  set :service,         "Twitter"
  set :consumer_key,    ENV["CONSUMER_KEY"]
  set :consumer_secret, ENV["CONSUMER_SECRET"]
  set :access_key,      ENV["ACCESS_KEY"]
  set :access_secret,   ENV["ACCESS_SECRET"]

  on_reply do |event|
    puts 'recieve reply'
    if event['user']['screen_name'] == 'otukutun'
      reply "Hi, i am a chatroid", event
      puts 'reply to @otukutun'
    else
      reply "who are your?", event
      puts 'reply to @other'
    end
  end

  on_time hour: 7, min: 00, sec: 0 do
    weather = Weather.new('jp','Tokyo')
    tweet "@otukutun 今日の東京の天気は#{weather.cond}。最高気温は#{weather.temp_max}。最低気温は#{weather.temp_min}です。"
  end

  on_time hour: 0, min: 30, sec: 0 do
    tweet "@otukutun おやすみなさい"
  end

  on_time day: [10, 20, 30], hour: 12, min: 0, sec: 0 do
    tweet "@otukutun 最近調子どう?"
  end
end.run!
