//Código para un invernadero automático en el cual lee un sensor de temperatura
//y un sensor de humedad para proceder a encender un ventilador si hay mucha humedad
//o abrir un rociador si esta muy seco y muestra toda la informacion necesaria en
//una pantalla LCD
//Tarjeta Pingüino

//definicion sensor de temperatura
#define dht_success 0
#define dht_notconnected 1
#define dht_checksumfailed 2
#define dhtPin 15 // pin de dato

typedef struct dht_data { // define dht register structure
  int int_humidity;
  int dec_humidity;
  int int_temperature;
  int dec_temperature;
  int checksum;
  int status; // 0=success, 1=not connected, 2=chksum error, 3=other
};

//definicion de pantalla
#define RS 12
#define E 11
#define D4 5
#define D5 4
#define D6 3
#define D7 2
//definicion otros
#define boton 53
#define ventilador 50
#define bomba 48
//variable del sensor de temperatura
struct dht_data dht_register;        // Declare dht_register of type dht_data
float fahrenheit = 0;
char arreglo[1];
int temperatura_limite;
int DHT_Array[5]; // local array to hold the 5 DHT_ bytes.
int contador = 0;

int dhtReadByte(){
  int i,rbyte = 0;
  pinMode(dhtPin,INPUT);  // Set the DHT_ pin as input
  for (i=0 ; i < 8 ; i++) {
    while(digitalRead(dhtPin) == LOW); // Wait for input to switch to HIGH
    delayMicroseconds(35); // Wait for digital 1 mid-point.
    if (digitalRead(dhtPin) == HIGH) {  //  We have a digital 1
      rbyte |= 1 << (7 - i); // Save the bit.
      while(digitalRead(dhtPin) == HIGH); // wait for HIGH to LOW switch (~ 35us).
    } // end if
  } // end for
  return rbyte;
}

void dhtRead() {
	int c,chk1,chk2 = 0;
    int DHT_Array[5]; // local array to hold the 5 DHT_ bytes.
    pinMode(dhtPin, OUTPUT); // Set DHT_ pin as output.
    digitalWrite(dhtPin, LOW); // Drive DHT_ pin LOW to commence start signal
    delay(20); // Wait for 20 miliseconds
    digitalWrite(dhtPin,HIGH); // Drive DHT_ pin HIGH
    delayMicroseconds(30); // Wait 30 microseconds
    pinMode(dhtPin, INPUT); // Start signal sent, now change DHT_ pin to input.

    delayMicroseconds(40); // Wait 40us for mid-point of first response bit.
    chk1 = digitalRead(dhtPin); // Read bit.  Should be a zero.
    delayMicroseconds(80); // Wait 80us for the mid-point of the second bit.
    chk2 = digitalRead(dhtPin); // Read bit.  Should be a one.
    delayMicroseconds(40); // Wait 40us for end of response signal.
    if ((chk1 == 0) && (chk2 == 1)) { // If the response code is valid....
      for (c = 0 ; c < 5 ; c++) {
        DHT_Array[c] = dhtReadByte(); // Read five bytes from DHT_
      }
      //  checksum is the sum of the lower 8 bits of bytes 1-4.
      if (DHT_Array[4] == ((DHT_Array[0] + DHT_Array[1] + DHT_Array[2] + DHT_Array[3]) & 0xFF)) {

        // Checksum passed, so place data into the DHT_register structure
        dht_register.int_humidity = DHT_Array[0];    // integer humidity
        dht_register.dec_humidity = DHT_Array[1];    // decimal humidity (0 on DHT11)
        dht_register.int_temperature = DHT_Array[2]; // integer temperature
        dht_register.dec_temperature = DHT_Array[3]; // decimal temperature (0 on DHT11)
        dht_register.checksum = DHT_Array[4];        // checksum result
        dht_register.status =  dht_success;          // success status
        return;                          // return success code.
      }else {
         dht_register.status = dht_notconnected;          // success status
        return;                     //  Sensor data corrupted.
      } // end if
	} else {
		dht_register.status = dht_checksumfailed;          // success status
		return;                     // No DHT detected.
    } // end if
}

void control_teperatura(){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Temperatura");
  lcd.setCursor(0,1);
  lcd.print("limite:");
  temperatura_limite = temperatura_limite - 1;
  if (temperatura_limite <= 20){
    temperatura_limite = 50;
  }
  arreglo[0]=48+((int)(temperatura_limite/10)%10);
  arreglo[1]=48+((int)temperatura_limite%10);
  lcd.setCursor(7,1);
  lcd.print(arreglo);
  delay(800);
}

void accionar_bomba(){
  digitalWrite(bomba, HIGH);
  lcd.setCursor(12,2);
  lcd.print("AGUA");
  delay(5000);
  digitalWrite(bomba, LOW);
}

void setup(){
//Declaracion de los pines de pantalla LCD
   lcd(RS, E, D4, D5, D6, D7, 0, 0, 0, 0);
//Declaracion del formato del LCD
    lcd.begin(4, 0);
    lcd.clear();
//Coloca el cursor en posicion inicial
	lcd.home();
//colocarl el cursor en la primera fila primera columna
	lcd.setCursor(0,0);
//Mandar a escribir
	lcd.print("Leyendo el sensor en el pin.");
}
void loop(){
	dhtRead();
	switch(dht_register.status){
		case dht_notconnected:
			lcd.clear();
			lcd.setCursor(0,0);
			lcd.print("No se encuentra el sensor en el pin");
			break;
		case dht_checksumfailed:
			lcd.clear();
			lcd.setCursor(0,0);
			lcd.print("Mala comprobacion, colocar resistencia 10K en el Vcc dato");
			break;
		case dht_success:
			lcd.clear();
//colocarl el cursor en la primera fila primera columna
			lcd.setCursor(0,0);
			lcd.print("Hum:");
  			lcd.setCursor(4,0);
//			lcd.print("humedad: %d.",dht_register.int_humidity);
			arreglo[0]=48+((int)(dht_register.int_humidity/10)%10);
  			arreglo[1]=48+((int)dht_register.dec_humidity%10);
			lcd.print(arreglo);
  			lcd.setCursor(6,0);
			lcd.print("%");
//			lcd.print("%d",dht_register.dec_humidity);
 			lcd.setCursor(10,0);
			lcd.print("Lim:");
			lcd.setCursor(14,0);
			arreglo[0]=48+((int)(temperatura_limite/10)%10);
  			arreglo[1]=48+((int)temperatura_limite%10);
			lcd.print(arreglo);
			lcd.setCursor(0,1);
			lcd.print("Temp:");
			lcd.setCursor(5,1);
			arreglo[0]=48+((int)(dht_register.int_temperature/10)%10);
  			arreglo[1]=48+((int)dht_register.dec_temperature%10);
			lcd.print(arreglo);
			lcd.setCursor(7,1);
			lcd.print("C");
			if(dht_register.int_temperature >= temperatura_limite){
    				digitalWrite(ventilador, HIGH);
    				lcd.setCursor(0,2);
    				lcd.print("AIRE");
			}else{
				digitalWrite(ventilador, LOW);
  			}
  			if (contador >= 30) {
    				contador = 0;
    				accionar_bomba();
  			}else{
    				contador++;
  			}
			while(digitalRead(boton) == HIGH){
    				control_teperatura();
  			}
			break;
		default:
			lcd.clear();
			lcd.setCursor(0,0);
			lcd.print("Error desconocido del sensor DHT");
	}
}
