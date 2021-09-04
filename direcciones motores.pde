//Se usan pulsos ultrasonido para dirigir al robot en la dirección en la
//que es detectado el obstáculo
//Tarjeta Pingüino

#include <stdbool.h>
#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante

#define pingd 5
#define pingc 6
#define pingi 7
#define sharpi 20
#define sharpd 13
//señales de salida hacia el otro pinguino
#define s_pingd 23
#define s_pingc 24
#define s_pingi 25
#define s_sharpi 26
#define s_sharpd 27
#define estaba 28
//recomendado 150
#define lim_ultrasonido 50
//recomendado 250
#define lim_sharp 250
//para el servo
#define MAX 250
#define MIN 0
#define MED 125
#define led 0

//funcion para enviar el  pulso al Ultrasonido
void pulso(unsigned char pin){
	pinMode(pin,OUTPUT);
	digitalwrite(pin,LOW);
	delay(2);
	digitalwrite(pin,HIGH);
	delay(5);
	digitalwrite(pin,LOW);
}
//funcion para recibir el pulso del ultrasonido
//la variable limite es para dar un limite de espera, si amplitud pasa de ese limite el objeto esta fuera de rango
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

void setup(){
	pinMode(pingc,OUTPUT);
	pinMode(pingi,OUTPUT);
	pinMode(pingd,OUTPUT);
	pinMode(s_pingd,OUTPUT);
	pinMode(s_pingc,OUTPUT);
	pinMode(s_pingi,OUTPUT);
	pinMode(s_sharpi,OUTPUT);
	pinMode(s_sharpd,OUTPUT);
	pinMode(led,OUTPUT);
	//servo.attach(pservo); //para inicializar el pin del servo
}

unsigned int dur; //duracion
BOOL izqder;//0 izquierda, 1 derechha

void loop () {
	//senso de ultradonidos
	//ultra sonido central
	pulso(pingc);
  	dur = duracion(pingc,lim_ultrasonido);
  	if (dur != 0){
		digitalwrite(s_pingc,HIGH);
	}else{
		digitalwrite(s_pingc,LOW);
	}

	//ultra sonido derecho
	/*pulso(pingd);
  	dur = duracion(pingd,lim_ultrasonido);
  	if (dur != 0){
		digitalwrite(s_pingd,HIGH);
		izqder=1;
	}else{
		digitalwrite(s_pingd,LOW);
	}
	//ultra sonido izquierdo
	pulso(pingi);
  	dur = duracion(pingi,lim_ultrasonido);
  	if (dur != 0){
		digitalwrite(s_pingi,HIGH);
		izqder=0;
	}else{
		digitalwrite(s_pingi,LOW);
	}*/
	//senso de sharp
	//sharp izquierdo
	dur= analogRead(sharpi);
	if (dur > lim_sharp){
		digitalwrite(s_sharpi,HIGH);
		izqder=0;
	}else{
		digitalwrite(s_sharpi,LOW);
	}
	//sharp derecho
	dur= analogRead(sharpd);
	if (dur > lim_sharp){
		digitalwrite(s_sharpd,HIGH);
		izqder=1;
	}else{
		digitalwrite(s_sharpd,LOW);
	}
	if(izqder==1){
		digitalwrite(estaba,HIGH);
	}else{
		digitalwrite(estaba,LOW);
	}
}
