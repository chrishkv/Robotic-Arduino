//Ejemplo de sketch de prueba para sensor DHT11 humedad/temperatura

#include "DHT.h"

#define DHTPIN 2     // what digital pin we're connected to

#define DHTTYPE DHT11   // DHT 11

// Conectar el pin1 (el de la izquierda) del sensor a Vcc
// Conectar el pin2 del sensor en el Pin de entrada del arduino (pin2)
// Conectar el pin4 (el de la derecha) del sendor a TIERRA
// Conectar una resistencia de 10K desde el pin2 del sensor a Vcc

// Se declara el uso del sensor
DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  Serial.println("DHTxx test!");

  dht.begin();
}

void loop() {
  // espera 2 segundos antes de volver a verificar la informacion
  delay(2000);

  // La lectura de la temperatura y humedad toma cerca de 250 milisegundos   
  // Leyendo la Humedad
  float h = dht.readHumidity();
  // Leyendo la temperatura en Centigrados Celsius (por defecto)
  float t = dht.readTemperature();  

  // Revisa si alguna de las lecturas fallo cancela (para intentar de nuevo)
  if (isnan(h) || isnan(t)) {
    Serial.println("Falla al leer el sensor DHT!");
    return;
  }

  Serial.print("Humedad: ");
  Serial.print(h);
  Serial.print(" %\t");
  Serial.print("Temperatura: ");
  Serial.print(t);
  Serial.println("C°");
}

