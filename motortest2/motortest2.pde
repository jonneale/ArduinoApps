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
}

boolean done = false;
void loop()
{
  if(done == false) {
    forward();
    delay(1000);
    right();
    delay(1000);
    left();
    delay(1000);
    backward();
    delay(1000);
    done = true;
    stop();
  }
  
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
}
void backward() {
  digitalWrite (leftWheelDirectionPin, back); 
  digitalWrite (rightWheelDirectionPin, back);
  analogWrite (leftWheelSpeedPin, 255);
  analogWrite (rightWheelSpeedPin, 255);
}
void left() { 
  digitalWrite (leftWheelDirectionPin, back); 
  digitalWrite (rightWheelDirectionPin, fwd);
  analogWrite (leftWheelSpeedPin, 255);
  analogWrite (rightWheelSpeedPin, 255);
}
void right() {
  digitalWrite (leftWheelDirectionPin, fwd); 
  digitalWrite (rightWheelDirectionPin, back);
  analogWrite (leftWheelSpeedPin, 255);
  analogWrite (rightWheelSpeedPin, 255);
}
  
  

