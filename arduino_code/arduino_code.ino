/*
 * {
 *  2023.07.26 이지석
 *  코드 개발
 * }
 */
#include<ESP32_Servo.h>
#include <WiFi.h> //ESP32


const char* ssid = "jiseok";
const char* password = "jiseokji";

const char* host = "192.168.1.193"; //서버의 주소
const int Port = 8090;

WiFiClient client;
Servo servo;
int value = 0;

#define TRIG 25 //TRIG 핀 설정 (초음파 보내는 핀)
#define ECHO 26 //ECHO 핀 설정 (초음파 받는 핀)
int pin1 = 4;
int pin2 = 2;

void setup() {
  Serial.begin(115200); 
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password); //블록킹, 언블록킹
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  //인터넷공유기와 접속에 성공함!
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP()); //ESP32의 IP주소
  
  pinMode(TRIG, OUTPUT);
  pinMode(ECHO, INPUT);
  pinMode(pin1, OUTPUT);
  pinMode(pin2, OUTPUT);
  digitalWrite(pin1,0);
  digitalWrite(pin2,0);
  servo.attach(15);
}
void loop(){
  if (!client.connect(host, Port)) {
    Serial.println("connection failed");
    return;
  }
  long duration, distance;
  digitalWrite(TRIG, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG, LOW);

  duration = pulseIn (ECHO, HIGH); //물체에 반사되어돌아온 초음파의 시간을 변수에 저장합니다.

  distance = duration * 17 / 1000; 
  int value_sum = 9-distance;
  if(value_sum == 10){
    value_sum=0;
  }
  if(value_sum>0){
    digitalWrite(pin1,0);
    digitalWrite(pin2,1);
    servo.write(90);
  }
  else{
    digitalWrite(pin1,0);
    digitalWrite(pin2,0);
    servo.write(5);
  }
  Serial.print(value_sum*10); //측정된 물체로부터 거리값(cm값)을 보여줍니다.
  Serial.println(" Cm");
  
  String url = "/yuchan/data.jsp?sensor="+String(value_sum*10);
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" +
               "Connection: close\r\n\r\n");
  //3.서버가 클라이언트로 전송한 response를 수신한다
  unsigned long t = millis(); //생존시간
  while(true){
    if(client.available()) break;
    if(millis() - t > 10000) break;
  }
  //서버가 응답을 보냈다
  while(client.available()){
    Serial.write(client.read());
    if(client.read()==0){
      servo.write(90);
      delay(4000);
    }
  }
  Serial.println("연결이 해재되었습니다");
  delay(2000);
}
