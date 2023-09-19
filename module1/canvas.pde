

LineSystem ls;

void setup() {
   background(5);
   size(500,500);
   surface.setResizable(true);
   fullScreen();
   ls = new LineSystem();
   
}

void draw() {
     background(5);
     translate(width/2, height/2);

     ls.run();
}
