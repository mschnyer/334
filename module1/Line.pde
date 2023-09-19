// a simple Line class


class Line {
  float t;
  //static final int NUM_LINES = 10;
  float a;
  float b;
  float c;
  float d;
  
  
  Line(float x, float y, float x1, float y1){
    t = 0;
    a = x;
    b = y;
    c = x1;
    d = y1;
   // line(0, 1, 2, 3);
  }
  
  void display(){
    stroke(40, 70, 255);
    strokeWeight(5);
    translate(width/2, height/2);
    line(a, b, c, d);
  }

}
