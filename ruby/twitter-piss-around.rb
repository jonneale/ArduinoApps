require "rubygems"
require "twitter"

Twitter.configure do |config|
  config.consumer_key = "XmhtnJC78Zbloa77tn1gw"
  config.consumer_secret = "bYAY5LDnM1OqBrxXL4UPYufguUdaQTsA9PoeNcT8"
  config.oauth_token = "268435078-2qaHTOLZE8Ttg75q5UldEbXpzRw35vBvEC0BaRPt"
  config.oauth_token_secret = "y4Dnvbm38EUmjuHKHrDXmQKymbANifFXAKOjcjNd8OU"
end
client = Twitter::Client.new
puts client.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"
client.update("@fwdbot I think you should move forwards")
puts client.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"
sleep 1
client.update("@fwdbot I think you should turn left")
puts client.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"
sleep 1
client.update("Try to spin left, @fwdbot")