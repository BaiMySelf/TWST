bool runningTR = false;
bool runningHR = false;
bool runningSR = false;

void setup() {

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

  //toggle for ToggleRelay
  if ((digitalRead(IN_TR) == HIGH) && (runningTR == false))
    {

      digitalWrite (OUT_TR, HIGH);

      runningTR = true;

        while ((digitalRead(IN_TR) == HIGH)){
          delay(100);
      }
      
    }
  else if ((digitalRead(IN_TR) == HIGH) && (runningTR == true))
    {

      digitalWrite (OUT_TR, LOW);

      runningTR = false;

        while ((digitalRead(IN_TR) == HIGH)){
          delay(100);
      }
    }


  //togle for HeatRelay
  if ((digitalRead(IN_HR) == HIGH) && (runningHR == false))
    {

      digitalWrite (OUT_HR, HIGH);

      runningHR = true;

        while ((digitalRead(IN_HR) == HIGH)){
          delay(100);
      }
      
    }
  else if ((digitalRead(IN_HR) == HIGH) && (runningHR == true))
    {

      digitalWrite (OUT_HR, LOW);

      runningHR = false;

        while ((digitalRead(IN_HR) == HIGH)){
          delay(100);
      }
    }
    

  //toggle for SpeedRelay
  if ((digitalRead(IN_SR) == HIGH) && (runningSR == false))
    {

      digitalWrite (OUT_SR, HIGH);

      runningSR = true;

        while ((digitalRead(IN_SR) == HIGH)){
          delay(100);
      }
      
    }
  else if ((digitalRead(IN_SR) == HIGH) && (runningSR == true))
    {

      digitalWrite (OUT_SR, LOW);

      runningSR = false;

        while ((digitalRead(IN_SR) == HIGH)){
          delay(100);
      }
    }

}