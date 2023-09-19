// a simple Line class


class Line {
  float t;
  //static final int NUM_LINES = 10;
  float a;
  float b;
  float c;
  float d;
  
  float r;
  float g;
  float bl;
  
  Line(float x, float y, float x1, float y1, float red, float gre, float blu){
    t = 0;
    a = x;
    b = y;
    c = x1;
    d = y1;
    r = red;
    g = gre;
    bl = blu;
   // line(0, 1, 2, 3);
  }
  
  void display(){
    stroke(r, g, bl);
    strokeWeight(5);
    line(a, b, c, d);
  }

}
