int x, y = 0;
int prevX, prevY = 300; 

float t; //time
int scalar; //enlarges graph
int[] consts = new int[6]; //equation coefficients

void setup() {
  size(600, 600);
  background(255);
  t = 0; //set time
  scalar = 50;
  setConsts(); //get random coefficients
}

void draw() {
  translate(300, 300); //to center
  pushTable(2, 0.01f);
  
  if(keyPressed) { //reset
    if(key == 'r' || key == 'R') {
      setup();
    }
  }
  
}

void pushTable(int speed, float time_delta) {
  for(int i = 0; i < speed; i++) { //num increments multiplies executions per call of draw()
    
    //get point for this value of t
    parametricFunc(t);
    
    //draws this point and line connecting to last point
    point(x, y);
    line(prevX, prevY, x, y);
    
    //next line will start from this point
    prevX = x;
    prevY = y;
    
    /*if(mousePressed)*/ t += time_delta; //continues drawing when mouse held
  }
}

//parametric equation describing the harmonograph's motion
void parametricFunc(float t) {
  //decay caused by friction
  x = (int)(consts[0] * sin(consts[1]*t + consts[2]) * exp(-0.01 * t) * scalar);
  y = (int)(consts[3] * sin(consts[4]*t + consts[5]) * exp(-0.01 * t) * scalar);
}

void setConsts() {
  for(int i = 0; i < consts.length; i++) {
    consts[i] = (int)(random(1, 5));
  }
}
    
