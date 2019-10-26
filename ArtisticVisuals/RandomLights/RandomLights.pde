final int n = 100;
PVector[] dots = new PVector[n];
PVector[] vel = new PVector[n];
color[] c = new color[n]; 

void setup() {
  fullScreen();
  colorMode(HSB);
  for(int i = 0; i < dots.length; i++){
    dots[i] = new PVector(random(width), random(height));
    vel[i] = PVector.random2D().mult(5);
    c[i] = color(random(255), 255, 255);
  }
}

void draw() {
  background(0);
   for(int i = 0; i < dots.length; i++){
     dots[i].add(vel[i]);
     if(dots[i].x > width || dots[i].x < 0){
       vel[i].x *= -1;
     }
     if(dots[i].y > height || dots[i].y < 0){
       vel[i].y *= -1;
     }
     fill(c[i]);
     ellipse(dots[i].x, dots[i].y, 20,20);
   }
}
