
/**
Hi there! Welcome to a Line System.
Inspired by a combo of 2010 era Windows screen savers
and 1960s digital artworks of John Whitney

*/

LineSystem ls; // new LineSystem

void setup() {
  
   float r1;
   float r2;
   float r3;
   float r4;
  
   size(1000,1000);
   surface.setResizable(true);
   fullScreen();
   
   // parameters used in equations depends on window size
   if (height > 800) {
     r1 = random(10,20);
     r3 = random(250, 500);
   }
   r1 = random(0,10);
   r3 = random(0, 250);
   
   if (width > 800) {
     r2 = random(10,20);
     r4 = random(250, 500);
   }
   r2 = random(0,10);
   r4 = random(0, 250);
   
   
   ls = new LineSystem(r1, r2, r3, r4);
   background(5);
   
}

void draw() {
     background(5);
     translate(width/2, height/2); // center artwork in display window

     ls.run();
}
