  Grid g;
boolean gravity;
void setup() {
  fullScreen();
  g = new Grid(10, 10, 20, .00001, .001, 3);
  gravity = false;
}
void draw() {
  background(0);
  g.update(gravity);
}

void mousePressed(){
  gravity = !gravity;
}
