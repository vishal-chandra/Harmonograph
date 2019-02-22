int x, y = 0;
int prevX, prevY = 300; 

float t; //time
int scalar; //enlarges graph

void setup(){
  size(600, 600);
  background(255);
  scalar = 50;
}

void draw(){
  translate(300, 300); //to center
  pushTable(2, 0.01f);
}

void pushTable(int speed, float time_delta){
  for(int i = 0; i < speed; i++){ //num increments multiplies executions per call of draw()
    
    //get point for this value of t
    parametricFunc(t);
    
    //draws this point and line connecting to last point
    point(x, y);
    line(prevX, prevY, x, y);
    
    //next line will start from this point
    prevX = x;
    prevY = y;
    
    if(mousePressed) t += time_delta; //continues drawing when mouse held
  }
}

//parametric equation describing the harmonograph's motion
void parametricFunc(float t){
  //decay caused by friction
  x = (int)(5 * sin(3*t + 2) * exp(-0.01 * t) * scalar);
  y = (int)(4 * sin(5*t + 3) * exp(-0.01 * t) * scalar);
}
    
