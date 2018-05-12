Set s;
void setup(){
  fullScreen();
  s = new Set(2500, 0.0, 5.0, 10.0, new PVector(0.0,0.0), new PVector(width, height));
}

void draw(){
  background(48);
  s.update();
}
