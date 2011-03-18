// basic_robot_shield_sketch   version 1.0   J.Luke (RobotBits.co.uk)
//
// A simple sketch to help you get started with the Arduino Motor Shield
// in robotics applications
//
// This example has been written for any mobile robotics platform that uses
// two bi-directional motors controlled by an Arduino and a Robot Shield
//
// This sketch includes a series of functions that perform the different  
// types of movement for your robot including:
//
// forward, reverse, stop, rotate clock-wise, rotate counter clock-wise, 
// turn_left and turn_right 
//
// To program the movement of your robot simply call the functions as needed
// from the main loop
//
// This example loop below moves your robot in a "square" figure or eight
//
// For support, please contact support@robotbits.co.uk


// define the pins used by the Robot Shield
int lock = 5;            // lock is disable input - program will not run if lock is in place
                         // NOTE: DO NOT use pins 0 or 1 for the lock as this will stop
                         // you being able to program your robot!
                         
int speedA = 6;          // pin 6 sets the speed of motor A (this is a PWM output)
int speedB = 9;          // pin 9 sets the speed of motor B (this is a PWM output) 
int dirA = 8;            // pin 8 sets the direction of motor A
int dirB = 7;            // pin 7 sets the direction of motor B

// define the direction of motor rotation - this allows you change the  direction without effecting the hardware
int fwdA  =  LOW;         // this sketch assumes that motor A is the right-hand motor of your robot (looking from the back of your robot)
int revA  =  HIGH;        // (note this should ALWAYS be opposite the fwdA)
int fwdB  =  LOW;         //
int revB  =  HIGH;        // (note this should ALWAYS be opposite the fwdB)

// define variables used
int dist;
int angle;
int vel;

void setup() {                             // sets up the pinModes for the pins we are using
              pinMode (dirA, OUTPUT);         
              pinMode (dirB, OUTPUT); 
              pinMode (speedA, OUTPUT); 
              pinMode (speedB, OUTPUT); 
             }

void stop() {                              // stop: force both motor speeds to 0 (low)
              digitalWrite (speedA, LOW); 
              digitalWrite (speedB, LOW);
             }
             
void forward(int dist, int vel) {          // forward: both motors set to forward direction
              digitalWrite (dirA, fwdA); 
              digitalWrite (dirB, fwdB);
              analogWrite (speedA, vel);   // both motors set to same speed
              analogWrite (speedB, vel); 
              delay (dist);                // wait for a while (dist in mSeconds)
             }
             
void reverse(int dist, int vel) {          // reverse: both motors set to reverse direction
              digitalWrite (dirA, revA); 
              digitalWrite (dirB, revB);
              analogWrite (speedA, vel);   // both motors set to same speed
              analogWrite (speedB, vel); 
              delay (dist);                // wait for a while (dist in mSeconds)              
             }    

void rot_cw (int angle, int vel) {         // rotate clock-wise: right-hand motor reversed, left-hand motor forward
              digitalWrite (dirA, revA); 
              digitalWrite (dirB, fwdB);
              analogWrite (speedA, vel);   // both motors set to same speed
              analogWrite (speedB, vel); 
              delay (angle);               // wait for a while (angle in mSeconds)              
             }
             
void rot_ccw (int angle, int vel) {        // rotate counter-clock-wise: right-hand motor forward, left-hand motor reversed
              digitalWrite (dirA, fwdA); 
              digitalWrite (dirB, revB);
              analogWrite (speedA, vel);   // both motors set to same speed
              analogWrite (speedB, vel); 
              delay (angle);               // wait for a while (angle in mSeconds)              
             }
             
void turn_right (int angle, int vel) {     // turn right: right-hand motor stopped, left-hand motor forward
              digitalWrite (dirA, revA); 
              digitalWrite (dirB, fwdB);
              digitalWrite (speedA, LOW);  // right-hand motor speed set to zero
              analogWrite (speedB, vel); 
              delay (angle);               // wait for a while (angle in mSeconds)              
             }
             
void turn_left (int angle, int vel) {      // turn left: left-hand motor stopped, right-hand motor forward
              digitalWrite (dirA, fwdA); 
              digitalWrite (dirB, revB);
              analogWrite (speedA, vel);
              digitalWrite (speedB, LOW);  // left-hand motor speed set to zero
              delay (angle);               // wait for a while (angle in mSeconds)              
             }
             
void loop() { 
              
              forward (2000, 100);    // move forward for two seconds (2000 mS) at speed 100 (100/255ths of full speed)
              
              rot_cw (200, 100);      // rotate clock-wise for 200 mS (about 90 deg) at speed 100
              
              forward (2000, 100);    // move forward for 2000 mS at speed 100

              rot_cw (200, 100);      // rotate clock-wise for 200 mS at speed 100
              
              forward (2000, 100);    // move forward for 2000 mS at speed 100

              rot_cw (200, 100);      // rotate clock-wise for 200 mS at speed 100
                            
              forward (2000, 100);    // move forward for 2000 mS at speed 100
              
              rot_cw (200, 100);      // rotate clock-wise for 200 mS at speed 100
              
              forward (2000, 100);    // move forward for 2000 mS at speed 100

              rot_ccw (200, 100);     // rotate counter clock-wise for 200 mS at speed 100
  
              forward (2000, 100);    // move forward for 2000 mS at speed 100

              rot_ccw (200, 100);     // rotate counter clock-wise for 200 mS at speed 100
              
              forward (2000, 100);    // move forward for 2000 mS at speed 100

              rot_ccw (200, 100);     // rotate counter clock-wise for 200 mS at speed 100

              forward (2000, 100);    // move forward for 2000 mS at speed 100

              rot_ccw (200, 100);     // rotate counter clock-wise for 200 mS at speed 100              
              
              stop();                 // stop the robot

              delay(1000);            // wait one second (1000 mS) before restarting
            } 

