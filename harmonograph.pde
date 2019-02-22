/*
CONTROLS:
R - Reset (canvas, constants, color)
*/

PFont font; 

int x, y, prevX, prevY; 
float t; //time

int r, g, b; //color values
int scalar; //enlarges graph
int[] consts = new int[6]; //equation coefficients

void setup() {
  size(600, 600);
  background(255);
  
  font = createFont("Arial", 12, true);
 
  x = 0;
  y = 0;
  prevX = 0;
  prevY = 0;
  t = 0; //set time
  scalar = 60;
  
  for(int i = 0; i < consts.length; i++) {//random coefficients
    consts[i] = (int)(random(1, 5));
  }
  //prevent rectangular drawings
  if(consts[0] % consts[3] == 0 || consts[3] % consts[0] == 0) consts[0] += 1;
  //prevent line drawings
  if(consts[1] == consts[4]) consts[4] = (int)(random(1, 5));
  
  //random color
  r = (int)(random(255));
  g = (int)(random(255));
  b = (int)(random(255));
}

void draw() {
  drawMath();
  translate(300, 300); //to center
  stroke(r, g, b);
  pushTable(2, 0.01f);
  
  if(keyPressed && (key == 'r' || key == 'R')) setup(); //reset
}
//Shows equation box in upper left
void drawMath() {
  stroke(0);
  fill(255);
  rect(0, 0, 150, 50);
  textFont(font);
  fill(0);
  text("x = " + consts[0] + "sin(" + consts[1] + "t + " + consts[2] + ")e^0.01t"
       , 10, 20);
  text("y = " + consts[3] + "sin(" + consts[4] + "t + " + consts[5] + ")e^0.01t"
       , 10, 40);
}

//Main method - draws harmonographic image
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

//System of equation describing the harmonograph's motion
void parametricFunc(float t) {
  //decay caused by friction
  x = (int)(consts[0] * sin(consts[1]*t + consts[2]) * exp(-0.01 * t) * scalar);
  y = (int)(consts[3] * sin(consts[4]*t + consts[5]) * exp(-0.01 * t) * scalar);
}
    
