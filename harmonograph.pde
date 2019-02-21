int x, y = 300;
int prevX, prevY = 300; 

//amplitude, frequency, phase; 1 of each for 4 equations
float[] consts = new float[6];

float t; //time

void setup(){
  size(600, 600);
  background(255);
  for(int i = 0; i < 6; i++){
    consts[i] = random(1, 5);
    print(consts[i]);
  }
}

void draw(){
  pushTable(2, 0.01f);
}

void pushTable(int speed, float time_delta){
  for(int i = 0; i < speed; i++){ //num increments multiplies executions per call of draw()
    
    //print(x);
    //print(", ");
    //print(y);
    //print("\n");
    
    //get point
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
  int x = (int)(300 + consts[0] * sin(consts[1]*t + consts[2]) * exp(-0.01 * t) * 50);
  int y = (int)(300 + consts[3] * sin(consts[4]*t + consts[5]) * exp(-0.01 * t) * 50);
}
    
