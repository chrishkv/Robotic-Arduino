void setup() {
  Serial.begin(9600);
}
 
void loop() {
  int sensorValue = analogRead(13);
  Serial.println(sensorValue, DEC);
}
