//Código para poder calcular la distancia del obstáculo e ignorar la señal del
//obstáculo si esta fuera del rango determinado con 3 sensores ultrasonido

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante

#define alcance 50
#define pingd 5
#define pingc 6
#define pingi 7
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
}

unsigned int dur;

void loop () {
	pulso(pingc);
  	dur = duracion(pingc,alcance);
  	if (dur != 0){
		CDC.print("cent",4);
	}
	pulso(pingd);
  	dur = duracion(pingd,alcance);
  	if (dur != 0){
		CDC.print("dere",4);
	}
	pulso(pingi);
  	dur = duracion(pingi,alcance);
  	if (dur != 0){
		CDC.print("izqu",4);
	}
}
