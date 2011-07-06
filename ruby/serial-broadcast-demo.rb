require 'rubygems'  
require 'serialport' 
require "twitter"


class Robot
  
  @port_str = "/dev/tty.usbmodemfa141"
  @baud_rate = 9600  
  @data_bits = 8  
  @stop_bits = 1
  @parity = SerialPort::NONE  
  @moved = false
  @client = Twitter::Client.new

  @sp = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity)  
  FORWARD = 'f'
  BACKWARD = 'b'
  LEFT = 'l'
  RIGHT = 'r'
  HARDLEFT = 'a'
  HARDRIGHT = 'c'
  
  Twitter.configure do |config|
    config.consumer_key = "0BQRizAxkCDAzrGFBepQ"
    config.consumer_secret = "9RZSrkzbeU09ycGaX8KZI3sO9EXXiKkxkLVso7T5Ec"
    config.oauth_token = "268439250-oqQWJ43kNvjOxWGxFEUMHNFtytftKsSMVBM8M0my"
    config.oauth_token_secret = "DavoHU5N8YgV2gMlt08WAE6RLCAwp0bFXiwApCuNQ"
  end

  @client = Twitter::Client.new
  def self.forward(from)
    @sp.write(FORWARD)
    if moved
      @client.update("Moving forwards as commanded by #{from}")
    else
      @client.update("Moving forwards as commanded by #{from}")
    end
    

  end

  def self.backward(from)
    @sp.write(BACKWARD)
    @client.update("Puny human #{from} commands me to move backward! Complying!")
  end

  def self.left(from)
    @sp.write(LEFT)
    @client.update("Message receieved, #{from}. Turning left as ordered")
  end

  def self.right(from)
    @sp.write(RIGHT)
    @client.update("Roger, #{from}. Right turn underway!")
  end

  def self.hard_right(from)
    @sp.write(HARDRIGHT)  
    @client.update("#{from} commands I spin right. Doing as ordered")
  end

  def self.hard_left(from)
    @sp.write(HARDLEFT)
    @client.update("Understood, #{from}. Spinning left by your command")
  end
end

Twitter.configure do |config|
  config.consumer_key = "0BQRizAxkCDAzrGFBepQ"
  config.consumer_secret = "9RZSrkzbeU09ycGaX8KZI3sO9EXXiKkxkLVso7T5Ec"
  config.oauth_token = "268439250-oqQWJ43kNvjOxWGxFEUMHNFtytftKsSMVBM8M0my"
  config.oauth_token_secret = "DavoHU5N8YgV2gMlt08WAE6RLCAwp0bFXiwApCuNQ"
end

client = Twitter::Client.new

while true do
  search = Twitter::Search.new
  tweets = search.to("fwdbot")
  tweets.each do |tweet|
    Robot.forward(tweet.from_user) if tweet.text.downcase.include?("forward")
    Robot.backward(tweet.from_user) if tweet.text.downcase.include?("backward")
    Robot.left(tweet.from_user) if tweet.text.downcase.include?("turn left")
    Robot.hard_left(tweet.from_user) if tweet.text.downcase.include?("spin left")
    Robot.right(tweet.from_user) if tweet.text.downcase.include?("right")
    Robot.hard_left(tweet.from_user) if tweet.text.downcase.include?("spin left")
  end
  search.clear
  puts client.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"
  sleep 5
end

