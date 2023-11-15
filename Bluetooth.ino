int trigPin= 13;
int echoPin= 12;
int pingTravelTime;
void setup() {
  // put your setup code here, to run once:
  pinMode(trigPin,OUTPUT);
  pinMode(echoPin,INPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  pingTravelTime = pulseIn(echoPin, HIGH);
  delay(25);
  digitalWrite(trigPin, LOW);
  Serial.println(pingTravelTime);
  
}
