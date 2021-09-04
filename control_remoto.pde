//Se controla un el robot a control remoto según la orden que recibe
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante
//blancos
#define in1 13 //derecha
#define in2 14 //retro
//verdes
#define in3 19 //delante
#define in4 20 //izquierda

#define ou1 24
#define ou2 8
#define ou3 3
#define ou4 2

void resetear()
{
	digitalWrite(ou1,LOW);
	digitalWrite(ou2,LOW);
	digitalWrite(ou3,LOW);
	digitalWrite(ou4,LOW);
}

void derecha(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,LOW);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,LOW);
}

void izquierda(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,HIGH);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,HIGH);
}

void retro(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,LOW);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,HIGH);
}

void delante(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,HIGH);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,LOW);
}

void setup()
{
pinMode(ou1,OUTPUT);
pinMode(ou2,OUTPUT);
pinMode(ou3,OUTPUT);
pinMode(ou4,OUTPUT);
}

void loop()
{
resetear();
while(analogRead(in1)>1000){
	derecha();
}
while(analogRead(in2)>1000){
	izquierda();
}
while(analogRead(in3)>1000){
	delante();
}
while(analogRead(in4)>1000){
	retro();
}
}
