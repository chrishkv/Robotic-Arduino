//Código con el que se compitió en 2015 en categoría sumo
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante

//recomendado 700
#define lim_ultrasonido 750

//sensores ultrasonido
#define pingd 21
#define pingc 12
#define pingi 22

//cny de derecha
#define pisod1 9
#define pisod2 25
//cny de izquierda
#define pisoi1 27
#define pisoi2 26

//motor derecho
//verde-principal
#define ou1 24
//amarillo
#define ou2 8
//motor izquierdo
//azul-principal
#define ou3 3
//naranja
#define ou4 2

void pulso(unsigned char pin){
	pinMode(pin,OUTPUT);
	digitalwrite(pin,LOW);
	delay(2);
	digitalwrite(pin,HIGH);
	delay(5);
	digitalwrite(pin,LOW);
}
unsigned int duracion(unsigned char pin,unsigned int limite){
	unsigned int amplitud = 0;
	pinMode(pin,INPUT);
	//espera flanco de subida por el pin echo
	while(digitalread(pin) == LOW){
		amplitud++;
		if(amplitud>64)
			break;
	}
	amplitud = 0;
	//comienza a contar centimetros hasta que pin echo sea cero
	while(digitalread(pin) == HIGH){
	  amplitud++;
	  if (amplitud >= limite)
		return 0;
	}
	return amplitud;
}
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
	resetear();
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

int activado(){
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
resetear();
delay(1000);
izquierda();
}

unsigned int dur; //duracion
void loop()
{
do{
	pulso(pingc);
  	dur = duracion(pingc,lim_ultrasonido);
	if (dur != 0){delante();}
	if (activado()==1){retro(); delay(150);}
}while(dur != 0);

	pulso(pingd);
  	dur = duracion(pingd,lim_ultrasonido);
  	if (dur != 0){izquierda();}

	pulso(pingi);
  	dur = duracion(pingi,lim_ultrasonido);
  	if (dur != 0){derecha();}
}
