//Código para poder calcular la distancia del obstáculo e ignorar la señal del
//obstáculo si esta fuera del rango determinado
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante

#define senal 28
#define v5 10

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
	while(digitalread(pin) == LOW);
	//comienza a contar centimetros hasta que pin echo sea cero
	while(digitalread(pin) == HIGH){
	  amplitud++;
	  if (amplitud >= limite)
		return 0;
	}
	return amplitud;
}

void setup(){
	pinMode(senal,OUTPUT);
	pinMode(v5,OUTPUT);
}

unsigned int dur;

void loop () {
	digitalwrite(v5,HIGH);
	pulso(senal);
  	dur = duracion(senal,1024);
  	if (dur != 0){
		CDC.print("ult1",4);
	}
}
