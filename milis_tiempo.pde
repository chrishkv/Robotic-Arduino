//Codigo para poder calcular el tiempo que tarda el ciclo while
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante
int maxcycles = 803; //1 milisegundo //8032; = 10 milisegundo //12048 / 2; //1 milisegundo
int lastreadtime = 0;
int currenttime;

void imprimir_numero(int numero){
	char arreglo[3];
	arreglo[0]=48+(numero/1000);
	arreglo[1]=48+((numero/100)%10);
	arreglo[2]=48+((numero/10)%10);
	arreglo[3]=48+(numero%10);
	CDC.print(arreglo,4);
}

void setup(){}
void loop(){
	int count = 0;
	currenttime = millis();
	while(count < maxcycles)
	{
		count++;
	}
	imprimir_numero(currenttime - lastreadtime);
	lastreadtime = currenttime;
}
