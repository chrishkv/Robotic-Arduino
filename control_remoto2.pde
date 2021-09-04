//Se controla un el robot a control remoto según la orden que recibe
//Con sensores cny (infrarojo) en la parte de abajo para detectar marcas de finalización
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante

//cny de derecha
#define pisod1 9
#define pisod2 25
//cny de izquierda
#define pisoi1 27
#define pisoi2 26

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

//control remoto
void control_remoto(){
while(analogRead(in1)>1000){derecha();}
while(analogRead(in2)>1000){izquierda();}
while(analogRead(in3)>1000){delante();}
while(analogRead(in4)>1000){retro();}
}

int activado(){
if(analogRead(in1)>1000){return 1;}
if(analogRead(in2)>1000){return 1;}
if(analogRead(in3)>1000){return 1;}
if(analogRead(in4)>1000){return 1;}
return 0;
}

int activadop(){
if ((digitalRead(pisod1)==LOW) && (digitalRead(pisod2)==LOW)){return 1;}
if ((digitalRead(pisoi1)==LOW) && (digitalRead(pisoi2)==LOW)){return 1;}
return 0;
}

void setup()
{
pinMode(pisod1,INPUT);
pinMode(pisod2,INPUT);
pinMode(pisoi1,INPUT);
pinMode(pisoi2,INPUT);
pinMode(ou1,OUTPUT);
pinMode(ou2,OUTPUT);
pinMode(ou3,OUTPUT);
pinMode(ou4,OUTPUT);
}

void loop()
{
resetear();
if (activado()!=0){control_remoto();}
if (activadop()==1){retro(); delay(100);}
}
