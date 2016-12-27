require "rake"
require "redis"
require "sinatra"
require "shotgun"
require "redis-sinatra"
require "json"

URL_SHORT_BASE = "https://myshortenr.herokuapp.com/"

redis = Redis.new

def random_string(length)
    rand(36**length).to_s(36)
end

def check (shortcode)
  redis = Redis.new
  if redis.exists "short_id:#{shortcode}"
    shortcode = random_string 5
  else
    redis.hmset "short_id:#{shortcode}", "url", "#{params[:url]}", "visits", 0
  end
end

get '/' do
  content_type :json
  {"Name" => "Eric"}.to_json
end

post '/' do
  if params[:url] and not params[:url].empty?
    content_type :json
    shortcode = random_string 5
    check (shortcode)
    short_url = "#{URL_SHORT_BASE}#{shortcode}"
    short_url.to_json
  end
end

get '/:shortcode' do
  redis.hincrby "short_id:#{params[:shortcode]}", "visits", 1
  @url = redis.hget "short_id:#{params[:shortcode]}", "url"
  redirect @url || '/'
end

get '/tracking/:shortcode' do
  if params[:shortcode] and not params[:shortcode].empty?
    content_type :json
    click = redis.hget "short_id:#{params[:shortcode]}", "visits"
    click.to_json
  end
end

### ajouter les referers
