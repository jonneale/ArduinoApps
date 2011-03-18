//LeftWheel

leftWheelSpeedPin = 6;
leftWheelDirectionPin = 8;

rightWheelSpeedPin = 7;
rightWheelDirectionPin = 9;
int ledPin = 13; // LED connected to digital pin 13
int val = 0;
void setup()
{
  pinMode(ledPin, OUTPUT); // sets the digital pin as output
  Serial.begin(9600);
}

void loop()
{
  val = Serial.read();
  if (val == 'A') 
  {
    digitalWrite(ledPin, HIGH); // sets the LED on
  }
  if (val == 'a') 
  {
    digitalWrite(ledPin, LOW); // sets the LED off
  }
}
