
class LineSystem{

static final int NUM_LINES = 10;

Line l;
Line m;

float x;
float y;
float x1;
float y1;
float t;

float r1;
float r2;
float r3;
float r4;


float h = height;
float w = width;

  float r = random(0, 255);
  float g = random(0, 255);
  float bl = random(0, 255);
  
  float re = random(0, 255);
  float g2 = random(0, 255);
  float bl2 = random(0, 255);

LineSystem(float rand1, float rand2, float rand3, float rand4){
  r1 = rand1;
  r2 = rand2;
  r3 = rand3;
  r4 = rand4;
}

// using parametric equations, 2 line systems are generated as
// the inverses of each other
void run() {

  for (int i = 0; i < NUM_LINES; i++) {
    l = new Line(x(t + i), y(t + i), x1(t + i), x1(t + i), r, g, bl);
    t -= 0.025;
    l.display();
  }
  
  for (int i = 0; i < NUM_LINES; i++) {
    m = new Line(x2(t + i), y2(t + i), x3(t + i), x3(t + i), re, g2, bl2);
    m.display();
  }

}

   
float x(float t){
 return sin(t/r1) * r3 + sin(t /r1) * r4; 
}

float y(float t){
 return cos(t / r1) * r3; 
}

float x1(float t){
 return sin(t/r2) * r3 + sin(t/r2) * r4; 
}

float y1(float t){
 return cos(t / r2) * r3 + cos(t/r2) *r4; 
}
  
  
  
float x2(float t){
 return sin(t/r2) * r4 + sin(t /r2) * r3; 
}

float y2(float t){
 return cos(t / r2) * r4; 
}

float x3(float t){
 return sin(t/r1) * r4 + sin(t/r2) * r3; 
}

float y3(float t){
 return cos(t / r1) * r4 + cos(t/r2) *r3; 
}
  
  


}
