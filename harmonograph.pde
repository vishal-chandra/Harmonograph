/* CONTROLS: R - Reset (canvas, constants, color) */

PFont font; 

//graph data
float t; //time
int x, y, prevX, prevY;
int r, g, b; //color values
int[] consts = new int[6]; //equation coefficients
boolean initFrame;

//constants
final int scalar = 60; //enlarges graph
final float time_increment = 0.01f;
final int FR = 60; //frame rate

void setup() {
  size(600, 600);
  background(255);
  frameRate(FR);
  font = createFont("Arial", 12, true);
  
  //we are on the first frame of this drawing
  initFrame = true;
  
  /*
  since parametric, t=0 will be drastically different than t=0.01
  to prevent a large line from (0, 0) to the first point, we start
  at the first point
  */
  t = time_increment;
  
  //random coefficients
  for(int i = 0; i < consts.length; i++) {
    consts[i] = (int)(random(1, 5));
  }
  
  //adjustments
  //prevent rectangular drawings
  if(consts[0] % consts[3] == 0 || consts[3] % consts[0] == 0) consts[0] += 1;
  //prevent line drawings
  if(consts[1] == consts[4]) consts[4] += 1;
  
  //random color
  r = (int)(random(200));
  g = (int)(random(200));
  b = (int)(random(200));
}

void draw() {
  drawMath();
  translate(width/2, height/2); //to center
  stroke(r, g, b);
  pushTable(time_increment);
  if(keyPressed && (key == 'r' || key == 'R')) setup(); //reset
  //print("(" + prevX + ", " + prevY + ")\n");
}

//Main method - draws harmonographic image
void pushTable(float time_increment) {
  
    //next line will start from this point
    prevX = x;
    prevY = y;
    
    //get point coords for this value of t
    parametricFunc(t);
    
    //draws this point and line connecting to last point
    point(x, y);
    
    //only draw the line if prevX and prevY aren't 0! (they will be on first draw)
    if(!initFrame) {
      line(prevX, prevY, x, y);
    } 
    else {
      initFrame = false;
    }
    
    t += time_increment; //increment time
}

//System of equation describing the harmonograph's motion
void parametricFunc(float t) {
  //decay caused by friction
  x = ceil( consts[0] * sin(consts[1]*t + consts[2]) * exp(-0.01 * t) * scalar );
  y = ceil( consts[3] * sin(consts[4]*t + consts[5]) * exp(-0.01 * t) * scalar );
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
    
