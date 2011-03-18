require 'rubygems'  
require 'serialport' 
 
port_str = "/dev/tty.usbmodemfa141"
baud_rate = 9600  
data_bits = 8  
stop_bits = 1
parity = SerialPort::NONE  

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)  
forward = 'f'
backward = 'b'
left = 'l'
right = 'r'
hard_left = 'a'
hard_right = 'c'

sp.write(forward)
sleep 1
sp.write(backward)
sleep 1
sp.write(left)
sleep 1
sp.write(right)
sleep 1
sp.write(hard_left)
sleep 1
sp.write(hard_right)
sleep 1