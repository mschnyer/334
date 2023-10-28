
#include <WiFi.h>
#include <WiFiUdp.h>

#define S2 0 /*Define S2 Pin Number of ESP32*/
#define S3 17 /*Define S3 Pin Number of ESP32*/
#define sensorOut 16 /*Define Sensor Output Pin Number of ESP32*/

/*Define int variables*/
int Red = 0;
int Green = 0;
int Blue = 0;
int Frequency = 0;


const int pin = 34; // Change this to the desired analog pin


const char* ssid = "yale wireless";


const char* udpServerIP = "172.27.160.56"; // Change to the target IP address
// const int udpServerPort = 12345; // Change to the target port number

//const char* udpServerIP = "127.0.0.1"; // Change to the target IP address
const int udpServerPort = 12345; // Change to the target port number

WiFiUDP udp;


void setup() {
  pinMode(pin, INPUT); // Set the pin as an analog input
  pinMode(S2, OUTPUT); /*Define S2 Pin as a OUTPUT*/
  pinMode(S3, OUTPUT); /*Define S3 Pin as a OUTPUT*/
  pinMode(sensorOut, INPUT); /*Define Sensor Output Pin as a INPUT*/
  Serial.begin(115200); // Initialize serial communication


// Connect to Wi-Fi
WiFi.begin(ssid);
while (WiFi.status() != WL_CONNECTED) {
Serial.println("Connecting to WiFi...");
}
Serial.println("Connected to WiFi");


// Begin the UDP connection
udp.begin(udpServerPort);
}


void loop() {
//int sensorValue = analogRead(pin); // Read the analog input
//Serial.println(sensorValue);
// Data to be sent
//String message = "Hello, UDP Server!";

  Red = getRed();
  delay(200); /*wait a 200mS*/
  Green = getGreen();
  delay(200); /*wait a 200mS*/
  Blue = getBlue();
  delay(200); /*wait a 200mS*/
  Serial.print("Red Freq = ");
  Serial.print(Red); /*Print Red Color Value on Serial Monitor*/
  Serial.print("   ");
  Serial.print("Green Freq = ");
  Serial.print(Green); /*Print Green Color Value on Serial Monitor*/
  Serial.print("   ");
  Serial.print("Blue Freq = ");
  Serial.println(Blue); /*Print Blue Color Value on Serial Monitor*/

  // DIY TOUCH SENSOR
  Serial.print("Touch: ");
  Serial.println(touchRead(T0)); // GPIO pin 4
  delay(200);


// Send the UDP packet
udp.beginPacket(udpServerIP, udpServerPort);
//udp.print("Red: ");
//udp.print(Red);
//udp.print("  ");
//udp.print("Green: ");
//udp.print(Green);
//udp.print("  ");
//udp.print("Blue: ");
//udp.println(Blue);
int touch = touchRead(T0);

//udp.print(touch, "i");
udp.print(touch);
udp.print(",");
udp.print(Red);
udp.print(",");
udp.print(Green);
udp.print(",");
udp.print(Blue);
udp.endPacket();


//Serial.print("Allegedly sent: ");
//Serial.println(message);

//delay(3000);

}


int getRed() {
  digitalWrite(S2,LOW);
  digitalWrite(S3,LOW);
  Frequency = pulseIn(sensorOut, LOW); /*Get the Red Color Frequency*/
  return Frequency;
}

int getGreen() {
  digitalWrite(S2,HIGH);
  digitalWrite(S3,HIGH);
  Frequency = pulseIn(sensorOut, LOW); /*Get the Green Color Frequency*/
  return Frequency;
}

int getBlue() {
  digitalWrite(S2,LOW);
  digitalWrite(S3,HIGH);
  Frequency = pulseIn(sensorOut, LOW); /*Get the Blue Color Frequency*/
  return Frequency;
}
