require "arduino"
board = Arduino.new("/dev/tty.usbmodemfa141")  # baudrate is optional
puts board.to_s
board.output(13)
board.close
  
puts "set output"