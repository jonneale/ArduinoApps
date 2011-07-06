
//  Copyright (C) 2010 Georg Kaindl
//  http://gkaindl.com
//
//  This file is part of Arduino EthernetDHCP.
//
//  EthernetDHCP is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as
//  published by the Free Software Foundation, either version 3 of
//  the License, or (at your option) any later version.
//
//  EthernetDHCP is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public
//  License along with EthernetDHCP. If not, see
//  <http://www.gnu.org/licenses/>.
//

//  Illustrates how to use EthernetDHCP in polling (non-blocking)
//  mode.

#if defined(ARDUINO) && ARDUINO > 18
#include <SPI.h>
#endif
#include <Ethernet.h>
#include <EthernetDHCP.h>
#include <EthernetDNS.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x53, 0xC4 };

const char* ip_to_str(const uint8_t*);
char hostName[] = "tariffeditor.uswitchinternal.com";
byte resolvedIp[4];

char inString[32]; // string for incoming serial data
int stringPos = 0; // string index counter

void setup()
{
  Serial.begin(9600);
  EthernetDHCP.begin(mac, 1);
}

void loop()
{
  static DhcpState prevState = DhcpStateNone;
  static unsigned long prevTime = 0;
  
  // poll() queries the DHCP library for its current state (all possible values
  // are shown in the switch statement below). This way, you can find out if a
  // lease has been obtained or is in the process of being renewed, without
  // blocking your sketch. Therefore, you could display an error message or
  // something if a lease cannot be obtained within reasonable time.
  // Also, poll() will actually run the DHCP module, just like maintain(), so
  // you should call either of these two methods at least once within your
  // loop() section, or you risk losing your DHCP lease when it expires!
  DhcpState state = EthernetDHCP.poll();

  if (prevState != state) {
    Serial.println();

    switch (state) {
      case DhcpStateDiscovering:
        Serial.print("Discovering servers.");
        break;
      case DhcpStateRequesting:
        Serial.print("Requesting lease.");
        break;
      case DhcpStateRenewing:
        Serial.print("Renewing lease.");
        break;
      case DhcpStateLeased: {
        Serial.println("Obtained lease!");
        
        const byte* ipAddr = EthernetDHCP.ipAddress();
        const byte* gatewayAddr = EthernetDHCP.gatewayIpAddress();
        const byte* dnsAddr = EthernetDHCP.dnsIpAddress();

        Serial.print("My IP address is ");
        Serial.println(ip_to_str(ipAddr));

        Serial.print("Gateway IP address is ");
        Serial.println(ip_to_str(gatewayAddr));

        Serial.print("DNS IP address is ");
        Serial.println(ip_to_str(dnsAddr));

        Serial.println();
        
        Serial.println("connecting...");
    
        EthernetDNS.setDNSServer(dnsAddr);
       
        DNSError err = EthernetDNS.sendDNSQuery(hostName);
        if (err == DNSSuccess) {
          do {
            err = EthernetDNS.pollDNSReply(resolvedIp);
            if (DNSTryLater == err) {
              delay(20);
              Serial.print(".");
            }
          } while(err == DNSTryLater);
        }
        
        Serial.println("Ip address of server: ");
        Serial.println(ip_to_str(resolvedIp));  
        Client client(resolvedIp, 80);

        
        if (client.connect()) {
          Serial.println("connected");
          client.println("GET /reporting/switches/count.json HTTP/1.0");
          client.println();

          //Connected - Read the page
          Serial.println(readPage(client)); //go and read the output
          Serial.println("disconnecting.");
          Serial.println("all done");          
        } else {
          Serial.println("connection failed");
        }
       delay(1000); 
       break;
      }
    } 
  }
   else if (state != DhcpStateLeased && millis() - prevTime > 300) {
     prevTime = millis();
     Serial.print('.'); 
  }

  prevState = state;
}

String readPage(Client client){
  stringPos = 0;
  memset( &inString, 0, 32 ); //clear inString memory
  while(true){
    if (client.available()) {
      char c = client.read();
      inString[stringPos] = c;
      stringPos ++;
     
      if (stringPos > 100) {
       
         client.stop();
        client.flush();

         return inString;
      }
    }
    
  }
}


// Just a utility function to nicely format an IP address.
const char* ip_to_str(const uint8_t* ipAddr)
{
  static char buf[16];
  sprintf(buf, "%d.%d.%d.%d\0", ipAddr[0], ipAddr[1], ipAddr[2], ipAddr[3]);
  return buf;
}
