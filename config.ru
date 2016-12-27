require './url-shortener'
run Sinatra::Application

configure do
    . . .
    require 'redis'
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    . . .
end
