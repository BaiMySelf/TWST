void setup() {
  // put your setup code here, to run once:
  #define OUT_TR 12
  #define OUT_HR 11
  #define OUT_SR 10
  #define IN_SR 9
  #define IN_HR 8
  #define IN_TR 7

  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(IN_TR, INPUT);
  pinMode(OUT_TR, OUTPUT);

}

void loop() {
  
  digitalWrite(OUT_TR, IN_TR);
  digitalWrite(OUT_HR, IN_HR);
  digitalWrite(OUT_SR, IN_SR);

}