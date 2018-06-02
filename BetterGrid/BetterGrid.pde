Grid g;

void setup() {
  fullScreen();
  g = new Grid(100, 50, 0, 0, 10, 5, .1);
}
void draw() {
  background(0);
  g.update();
  
}
