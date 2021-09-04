//Codigo para controlar una pantalla LCD
//Tarjeta Pingüino

#define RS 12
#define E 11
#define D4 2
#define D5 3
#define D6 4
#define D7 5

void setup() {
//Declaracion de los pines de pantalla LCD
   lcd(RS, E, D4, D5, D6, D7, 0, 0, 0, 0);
//Declaracion del formato del LCD
    lcd.begin(2, 0);
    }
void loop() {
//Coloca el cursor en posicion inicial
  lcd.home();
//colocarl el cursor en la primera fila primera columna
  lcd.setCursor(0,0);
//Mandar a escribir
  lcd.print("Hola");
//colocarl el cursor en la segunda fila primera columna
  lcd.setCursor(0,1);
//Mandar a escribir
  lcd.print("Pinguino");
  }
