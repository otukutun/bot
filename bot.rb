require "chatroid"

Chatroid.new do
  set :service,         "Twitter"
  set :consumer_key,    ENV["CONSUMER_KEY"]
  set :consumer_secret, ENV["CONSUMER_SECRET"]
  set :access_key,      ENV["ACCESS_KEY"]
  set :access_secret,   ENV["ACCESS_SECRET"]

  on_reply do |event|
    reply "Hi, i am a chatroid", event
  end

  on_time hour: 7, min: 30, sec: 0 do
    tweet "@otukutun おはようございます"
  end

  on_time hour: 0, min: 30, sec: 0 do
    tweet "@otukutun おやすみなさい"
  end

  on_time day: [10, 20, 30], hour: 12, min: 0, sec: 0 do
    tweet "@otukutun 最近調子どう?"
  end
end.run!
