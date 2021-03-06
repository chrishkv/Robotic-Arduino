//Código para poder calcular la distancia en la que se encuentra el obtaculo
//con ultrasonido (sharp)
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante
#define pingPin 22

unsigned int pulseIn(unsigned char pin,unsigned int limite){
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

long microsecondsToInches(long microseconds)
{
  // According to Parallax's datasheet for the PING))), there are
  // 73.746 microseconds per inch (i.e. sound travels at 1130 feet per
  // second).  This gives the distance travelled by the ping, outbound
  // and return, so we divide by 2 to get the distance of the obstacle.
  // See: http://www.parallax.com/dl/docs/prod/acc/28015-PING-v1.3.pdf
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds)
{
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance travelled.
  return microseconds / 29 / 2;
}

void setup() {
pinMode(10,OUTPUT);
digitalwrite(10,HIGH);
}
char arreglo[3];
void loop()
{
  // establish variables for duration of the ping,
  // and the distance result in inches and centimeters:
  long duration, inches, cm;

  // The PING))) is triggered by a HIGH pulse of 2 or more microseconds.
  // Give a short LOW pulse beforehand to ensure a clean HIGH pulse:
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  // The same pin is used to read the signal from the PING))): a HIGH
  // pulse whose duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, 900);

  // convert the time into a distance
  inches = microsecondsToInches(duration);
  cm = microsecondsToCentimeters(duration);
  arreglo[0]=48+(inches/1000);
  arreglo[1]=48+((inches/100)%10);
  arreglo[2]=48+((inches/10)%10);
  arreglo[3]=48+(inches%10);
  //CDC.print("in",2);
  //CDC.print("\n",2);
  CDC.print(arreglo,4);
  /*arreglo[0]=48+(cm/1000);
  arreglo[1]=48+((cm/100)%10);
  arreglo[2]=48+((cm/10)%10);
  arreglo[3]=48+(cm%10);
  CDC.print("cm",2);
  CDC.print("\n",2);
  CDC.print(arreglo,4);*/
  CDC.print("\n",2);
  delay(100);
}
