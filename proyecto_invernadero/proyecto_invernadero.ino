#include <LiquidCrystal.h>
#include "DHT.h"

//definicion sensor de temperatura
#define DHTPIN 52
#define DHTTYPE DHT11

//definicion pantalla liquida
#define RS 2
#define E 4
#define D4 6
#define D5 8
#define D6 10
#define D7 12

#define boton 53
#define ventilador 50
#define bomba 48

//llamada al sensor de temperatura
DHT dht(DHTPIN, DHTTYPE);
//llamada a pantalla liquida
LiquidCrystal lcd(RS, E, D4, D5, D6 , D7);

char arreglo[1];
int temperatura_limite = 50;
int contador = 0;

void setup() {
  pinMode(boton, INPUT);
  pinMode(ventilador, OUTPUT);
  pinMode(bomba, OUTPUT);
  //inicio de sensor de temperatura
  dht.begin();
  //inicio pantalla liquida
  lcd.begin(16,4); //dimensiones de la pantalla
  lcd.clear();
  accionar_bomba();
}

void loop() {
  float humedad = dht.readHumidity();
  float temperatura = dht.readTemperature();
  /*if (isnan(humedad) || isnan(temperatura)) {
    lcd.clear();
    lcd.setCursor(0,1);
    lcd.write("Falla al leer");
    lcd.setCursor(0,2);
    lcd.write("temperatura!");
    return;
  }else{
    lcd.clear();
  }*/
  lcd.setCursor(0,1);
  lcd.write("Hum:");
  lcd.setCursor(4,1);
  arreglo[0]=48+((int)(humedad/10)%10);
  arreglo[1]=48+((int)humedad%10);
  lcd.write(arreglo);
  lcd.setCursor(6,1);
  lcd.write("%");
  lcd.setCursor(10,1);
  lcd.write("Lim:");
  lcd.setCursor(14,1);
  arreglo[0]=48+((int)(temperatura_limite/10)%10);
  arreglo[1]=48+((int)temperatura_limite%10);
  lcd.write(arreglo);
  lcd.setCursor(0,2);
  lcd.write("Temp:");
  lcd.setCursor(5,2);
  arreglo[0]=48+((int)(temperatura/10)%10);
  arreglo[1]=48+((int)temperatura%10);
  lcd.write(arreglo);
  lcd.setCursor(7,2);
  lcd.write("C");
  if(temperatura >= temperatura_limite){
    digitalWrite(ventilador, HIGH);
    lcd.setCursor(0,3);
    lcd.write("AIRE");
  }else{
    digitalWrite(ventilador, LOW);
  }
  delay(2000);
  if (contador >= 30) {
    contador = 0;
    accionar_bomba();
  }else{
    contador++;
  }
  while(digitalRead(boton) == HIGH){
    control_teperatura();
  }
}
void control_teperatura(){
  lcd.clear();
  lcd.setCursor(0,1);
  lcd.write("Temperatura");
  lcd.setCursor(0,2);
  lcd.write("limite:");
  temperatura_limite = temperatura_limite - 1;
  if (temperatura_limite <= 20){
    temperatura_limite = 50;
  }
  arreglo[0]=48+((int)(temperatura_limite/10)%10);
  arreglo[1]=48+((int)temperatura_limite%10);
  lcd.setCursor(7,2);
  lcd.write(arreglo); 
  delay(800);
}

void accionar_bomba(){
  digitalWrite(bomba, HIGH);
  lcd.setCursor(12,3);
  lcd.write("AGUA");
  delay(5000);
  digitalWrite(bomba, LOW);
}

