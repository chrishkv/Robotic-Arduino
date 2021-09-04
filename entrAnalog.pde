//Se hace el calculo para llevar la entrada analogica a un string de entre 0 a 1024
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante
#define en 15
#define v 10
char arreglo[3];

int numero;
void setup(){
pinMode(v,OUTPUT);
}
void loop() {
  digitalWrite(v,HIGH);
  numero = analogRead(en);
  arreglo[0]=48+(numero/1000);
  arreglo[1]=48+((numero/100)%10);
  arreglo[2]=48+((numero/10)%10);
  arreglo[3]=48+(numero%10);
  CDC.print(arreglo,4);
  delay(500);
 }
