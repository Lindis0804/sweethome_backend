#include <SPI.h>
#include <MFRC522.h>
#include <Servo.h>
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#define SS_PIN 15  //D8
#define RST_PIN 2  //D4
const int servo_pin = 5;
const int congrat_led_pin = 16;
const int led_pin = 4;
int servo_opening_degree = 90;

// wifi of mine
const char *ssid = "Dinh Hieu Le";
const char *pass = "84848484";

//MQTT broker
const char *mqtt_broker = "broker.hivemq.com";
const char *topic = "hieu_control_device_of_room_10";
const int mqtt_port = 1883;
Servo my_servo;
MFRC522 mfrc522(SS_PIN, RST_PIN);
String card_list[2] = { "0DEDB789", "457090AC" };
int total_card;
String card_num;

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
    case 14:
      digitalWrite(led_pin, is_active);
      break;
    case 15:
      if (is_active) {
        for (int i = servo_opening_degree; i <= 180; i++) {
          my_servo.write(i);
          delay(20);
        }
        servo_opening_degree = 180;
      } else {
        for (int i = servo_opening_degree; i >= 90; i--) {
          my_servo.write(i);
          delay(20);
        }
      }
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
  Serial.begin(115200);
  my_servo.attach(servo_pin);
  my_servo.write(servo_opening_degree);
  SPI.begin();
  mfrc522.PCD_Init();
  pinMode(congrat_led_pin, OUTPUT);
  pinMode(led_pin, OUTPUT);
  //set up wifi and mqtt
  connect_to_wifi();
  setup_mqtt();
  reconnect_to_mqtt();
}
void loop() {
  mqttClient.loop();
  if (!mqttClient.connected())
    reconnect_to_mqtt();
  if (!mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial()) {
    return;
  }
  card_num = getCardNumber();
  showData();
}

String getCardNumber() {
  String UID = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    UID += String(mfrc522.uid.uidByte[i] < 0x10 ? "0" : "");
    UID += String(mfrc522.uid.uidByte[i], HEX);
  }
  UID.toUpperCase();
  return UID;
}
void showData() {
  //String name, age, designation, location;
  boolean user_found = false;
  total_card = sizeof(card_list) / sizeof(card_list[0]);

  for (int i = 0; i < total_card; i++) {
    String check_num = card_list[i];
    if (card_num.equals(check_num)) {
      user_found = true;
      Serial.printf("Correct.\n");
      for (int i = servo_opening_degree; i <= 180; i++) {
        my_servo.write(i);
        delay(20);
      }
      servo_opening_degree = 180;
      run_congratulation_led();
    }
  }
  if (user_found == false) {
    Serial.print("Card ID : ");
    Serial.print(card_num);
    Serial.println(" have not registered.");
    Serial.println("------------");
  }
  delay(500);
}
void run_congratulation_led() {
  digitalWrite(congrat_led_pin, HIGH);
  delay(50);
  digitalWrite(congrat_led_pin, LOW);
  delay(50);
  digitalWrite(congrat_led_pin, HIGH);
  delay(50);
  digitalWrite(congrat_led_pin, LOW);
  delay(50);
  digitalWrite(congrat_led_pin, HIGH);
  delay(50);
  digitalWrite(congrat_led_pin, LOW);
}
