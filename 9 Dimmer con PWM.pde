// dimmer ( ejemplo con PWM )
//Tarjeta Pingüino
#define PIC18F4550


#define LED 11 // pin donde el led esá conectado; Los PWM solo pueden hacerse con los pines 11 y 12.


void setup()
{

}

void loop()
{
  unsigned int a;

  for (a=0;a<1023;a++) { // este es un ciclo FOR para ir incrementando el brillo del LED
    analogWrite(LED,a);
    delay(1);
  }

  for (a=1023;a>0;a--) { // este es un ciclo FOR para ir decrementando el brillo del LED
    analogWrite(LED,a);
    delay(1);
  }
}
