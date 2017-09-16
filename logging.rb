require 'dotenv'
require 'json'
require 'net/http'

Dotenv.load

URL = URI.parse("#{ENV['URL']}/#{ENV['KEY']}")
HTTPS = Net::HTTP.new(URL.host, URL.port)
HTTPS.use_ssl = true

def post(temp, humid, time)
  postdata = { value1: temp, value2: humid, value3: time }.to_json
  req = Net::HTTP::Post.new(URL.request_uri)
  req["Content-Type"] = "application/json"
  req.body = postdata
  HTTPS.request(req)
end

temp, humid = `usbrh`.split.map(&:to_f)
p post(temp, humid, Time.now)
