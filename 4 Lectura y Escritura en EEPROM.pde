#include <eepromlib.c>
int i;
int valor;
unsigned char answer;

void setup(){
	Serial.begin(9600);
}

void loop(){
	for(i=0; i<10; i=i+1) {
		valor = i=analogRead(15); //leemos la señal
		valor = valor/4; //la llevamos a una escala valida para el EEPROM
		ee_write(i,valor);
		delay(1000);
	}
	for(i=0; i<10; i=i+1) {
		answer=ee_read(i);
		delay(10);
		Serial.printf("Lectura%d = %d\n",i, answer);
		delay(10);
	}
}
