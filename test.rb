




JSON.load(`curl -X POST -d "url=http://coconut.co" http://localhost:9393/`)


redis.hincrby "short_id:u6qy9", "visits", 1


click = redis.exists "short_id:u6qy9", "visits"




JSON.load(`curl -X GET http://localhost:9393/tracking/u6qy9`)





redis.exists "short_id:u6qy9"


def check shortcode
  if redis.exists "short_id:#{shortcode}"
    puts "This shortcode already exists"
  else
    puts "Saved"
  end
end


u6qy9
