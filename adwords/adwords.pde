#include <SPI.h>
#include <Ethernet.h>
#include <EthernetDHCP.h>

byte mac[] = { 0x00, 0x1F, 0x16, 0x58, 0xEB, 0xA3 };
byte server[] = { 192, 168, 1, 3 };

Client client(server, 9292);
boolean started_parsing;
void setup()
{
   EthernetDHCP.begin(mac);
   Serial.begin(9600);
   
   if (client.connect()) {
      client.println("GET /api.json HTTP/1.0");
      client.println();
   } else {
      Serial.println("connection failed");
   }
}

void loop()
{
  
   if (client.available()) {
      char c = client.read();
      if (started_parsing) {
        Serial.print(c);
      }
      else {
        if (c == '<') {
          started_parsing = true;
        }        
      }
   }

   if (!client.connected()) {
      Serial.println();
      Serial.println("disconnecting.");
      client.stop();
      if (client.connect()){
        Serial.println ("connected");
        client.println("GET /api.json HTTP/1.0");
        client.println();
      }
      else {
        Serial.println("problem reconnecting");
      }
      delay(2000);
   }
}