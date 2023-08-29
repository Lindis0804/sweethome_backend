// this code is for esp32
#include <ESP32Servo.h>
#include <Arduino.h>
#include <WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
Servo myservo;
const int boundrate = 115200;
const int watersens_pin = 13;  // set water sensor port to 12
const int servo_pin = 14;
const int led1_pin = 27;
const int led2_pin = 26;
const int led3_pin = 25;
int pos = 0;
int servoOpeningDegree = 90;
const size_t capacity = 1024;

// wifi name and password of macova
// const char *ssid = "Macova";
// const char *pass = "1227TAhs@2302";

// wifi of mine
const char *ssid = "Dinh Hieu Le";
const char *pass = "84848484";

//MQTT broker
const char *mqtt_broker = "broker.hivemq.com";
const char *topic = "hieu_control_device_of_room_9";
const int mqtt_port = 1883;

//connect to wifi
WiFiClient wifiClient;
PubSubClient mqttClient(wifiClient);
void connect_to_wifi() {
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting to WiFi...");
  }
  Serial.printf("Connected to %s wifi\n", ssid);
}
void control_device_by_mqtt_data(String data) {
  DynamicJsonDocument jsonDoc(capacity);
  deserializeJson(jsonDoc, data);
  JsonObject jo = jsonDoc.as<JsonObject>();
  int device_id = jo[String("id")];
  int is_active = jo[String("is_active")];
  String param = jo[String("param")];
  Serial.printf("%d %d %s\n", device_id, is_active, param.c_str());
  switch (device_id) {
    case 10:
      if (is_active) {
        for (int i = servoOpeningDegree; i <= 180; i++) {
          myservo.write(i);
          delay(20);
        }
        servoOpeningDegree = 180;
      } else {
        for (int i = servoOpeningDegree; i >= 90; i--) {
          myservo.write(i);
          delay(20);
        }
        servoOpeningDegree = 90;
      }
      break;
    case 11:
      digitalWrite(led1_pin, is_active);
      break;
    case 12:
      digitalWrite(led2_pin, is_active);
      break;
    case 13:
      digitalWrite(led3_pin, is_active);
      break;
  }
}
void callback(char *topic, byte *payload, unsigned int length) {
  char *res = new char[length];
  for (int i = 0; i < length; i++) {
    res[i] = (char)payload[i];
  }
  res[length] = 0;
  control_device_by_mqtt_data(String(res));
}
void setup_mqtt() {
  //connect to a mqtt broker
  mqttClient.setServer(mqtt_broker, mqtt_port);
  mqttClient.setCallback(callback);
}
void reconnect_to_mqtt() {
  while (!mqttClient.connected()) {
    String client_id = "geats-client-";
    client_id += String(WiFi.macAddress());
    // Serial.printf("The client %s connects to the public MQTT broker\n", client_id.c_str());
    if (mqttClient.connect(client_id.c_str())) {
      mqttClient.subscribe(topic);
      Serial.println("Connected to broker.");
    } else {
      Serial.printf("Failed with state %d\n", mqttClient.state());
      Serial.printf("Try again in 2 seconds.");
      delay(2000);
    }
  }
}
void setup() {
  Serial.begin(boundrate);

  // initial setting for servo
  myservo.attach(servo_pin);  //set servo device to pin 9 on arduino board
  myservo.write(servoOpeningDegree);

  // set out put
  pinMode(led1_pin, OUTPUT);
  pinMode(led2_pin, OUTPUT);
  pinMode(led3_pin, OUTPUT);

  //set up wifi and mqtt
  connect_to_wifi();
  setup_mqtt();
  reconnect_to_mqtt();
}
void loop() {
  mqttClient.loop();
  if (!mqttClient.connected())
    reconnect_to_mqtt();

  // read value of water sensor
  int sensorValue = analogRead(watersens_pin);

  // map original value in range (0,1023) to target value in range (0,180)
  sensorValue = map(sensorValue, 0, 1023, 0, 180);

  //check sensor value to close door
  if (sensorValue > 100) {
    if (servoOpeningDegree > 0) {
      for (pos = servoOpeningDegree; pos >= 0; pos -= 1) {
        myservo.write(pos);
        delay(100);
      }
      servoOpeningDegree = 0;
      delay(15);
    }
  }
  // Serial.print("sensor value: ");
  // Serial.println(sensorValue);
}
// 