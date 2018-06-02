Set s;
void setup(){
  fullScreen();
  //colorMode(HSB);
  s = new Set(250, 0.0, 5.0, 100.0, new PVector(0.0,0.0), new PVector(width, height));
}

void draw(){
  background(48);
  s.update();
}
