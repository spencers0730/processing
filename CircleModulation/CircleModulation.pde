float r = 300;
int n = 500;
float mult = 1.5;
float t = 0;

void setup() {
  fullScreen();
}
void draw() {
  //noLoop();
  background(255);
  stroke(0);
  translate(width/2, height/2);

  mult = map(sin(t), -1, 1, 0, 5);
  t+=.01;
    //mult = 5;

  for (int i = 0; i < n; i++) {
    float a = map(i, 0, n, 0, TWO_PI);
    float x = r * cos(a);
    float y = r * sin(a);
    float a2 = map((i * mult) % n, 0, n, 0, TWO_PI);
    float x2 = r * cos(a2);
    float y2 = r * sin(a2);
    line(x, y, x2, y2);
  }
}
