//LeftWheel pins are 6 and 8
int leftWheelSpeedPin = 6;
int leftWheelDirectionPin = 8;
//RightWheel pins are 7 and 9
int rightWheelSpeedPin = 9;
int rightWheelDirectionPin = 7;

int fwd = LOW;
int back = HIGH;

void setup()
{
  pinMode(leftWheelSpeedPin, OUTPUT);
  pinMode(leftWheelDirectionPin, OUTPUT);
  pinMode(rightWheelSpeedPin, OUTPUT);
  pinMode(rightWheelDirectionPin, OUTPUT);
  Serial.begin(9600);
}

boolean done = false;
int val;

void loop()
{
  val = Serial.read();
  if (val == 'f') {
    forward();
  }
  if (val == 'b') {
    backward();
  } 
  if (val == 'ls') {
    left(45);
  }
  if (val == 'rs') {
    right(45);
  }   
  if (val == 'lb') {
    left(90);
  }   
    if (val == 'rb') {
    right(90);
  }   
  stop();
}

void stop(){
  digitalWrite(leftWheelSpeedPin, LOW);
  digitalWrite(rightWheelSpeedPin, LOW);
}

void forward() {
  digitalWrite (leftWheelDirectionPin, fwd); 
  digitalWrite (rightWheelDirectionPin, fwd);
  analogWrite (leftWheelSpeedPin, 255);
  analogWrite (rightWheelSpeedPin, 255);
  delay(200);
}
void backward() {
  digitalWrite (leftWheelDirectionPin, back); 
  digitalWrite (rightWheelDirectionPin, back);
  analogWrite (leftWheelSpeedPin, 255);
  analogWrite (rightWheelSpeedPin, 255);
  delay(200);
}

void left(int degree) {
  digitalWrite (leftWheelDirectionPin, back); 
  digitalWrite (rightWheelDirectionPin, fwd);
  analogWrite (leftWheelSpeedPin, 255);
  analogWrite (rightWheelSpeedPin, 255);
  delay(200);
} 

void right(int degree) {
   digitalWrite (leftWheelDirectionPin, fwd); 
  digitalWrite (rightWheelDirectionPin, back);
  analogWrite (leftWheelSpeedPin, 255);
  analogWrite (rightWheelSpeedPin, 255);
}
void turn(int backSpeed, int backDirection, int fwdSpeed, int fwdDirection, int degree) {
 // analogWrite (backSpeed, 0);
  //if (degree == 90) {
    digitalWrite (backDirection, back);
    analogWrite (backSpeed, 255);
 // }
  digitalWrite (fwdDirection, fwd);
  analogWrite (fwdSpeed, 255);
  delay(200);
} 
  
  

