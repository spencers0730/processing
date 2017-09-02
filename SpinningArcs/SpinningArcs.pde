Arc[] arcs;

void setup() {
  fullScreen();

  arcs = new Arc[6];
  for (int i = 0; i < arcs.length; i++) {
    arcs[i] = new Arc(width / 2, height / 2, 250, 20, i * PI / 2, .06, .03, 3, PI / 6, PI / 6 * .4, 6, i * PI / 4, 0.01);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < arcs.length; i++) {
    arcs[i].update();
  }
}