require "arduino"
#Arduino.new(port, baudrate)
board = Arduino.new("/dev/cu.usbmodemfa141")

board.output(13)

    #perform operations
    10.times do
        board.setHigh(13)
        sleep(1)
        board.setLow(13)
        sleep(1)
    end