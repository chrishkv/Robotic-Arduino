// Dependiendo de cual sensor es detectado se enciende el led correspondiente
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante
#define CNY1 7
#define CNY2 4
#define CNY3 23
#define CNY4 0
#define led 0
void setup() {
	pinMode(CNY1, INPUT);
	pinMode(CNY2, INPUT);
	pinMode(CNY3, INPUT);
	pinMode(CNY4, INPUT);
	//pinMode(0,OUTPUT);
	//pinMode(1,OUTPUT);
	pinMode(2,OUTPUT);
	pinMode(3,OUTPUT);
}

void loop() {
	if(!digitalRead(CNY1)) {
		digitalwrite(led,HIGH);
		CDC.print("CNY1",4);
	}else{
		digitalwrite(led,LOW);
	}
	if(!digitalRead(CNY2)) {
		digitalwrite(led+1,HIGH);

		CDC.print("CNY2",4);
	}else{
	digitalwrite(led+1,LOW);
	}
	if(!digitalRead(CNY3)) {
		digitalwrite(led+2,HIGH);
		CDC.print("CNY3",4);
	}else{
	digitalwrite(led+2,LOW);
	}
	if(!digitalRead(CNY4)) {
		digitalwrite(led+2,HIGH);
		CDC.print("CNY4",4);
	}else{
		digitalwrite(led+2,LOW);
	}
}
