final int r = 300;
final int n = 200;

final float maxMult = 100, minMult = 2, modMult = maxMult - minMult;

float tStep = 0.001;

float mult;
float t;

PVector[] dots;

PGraphics circle;

boolean update, step;

void setup() {
  fullScreen();
  imageMode(CENTER);

  mult = 2;
  t = 0;
  update = true;

  circle = createGraphics(2 * r, 2 * r);
  circle.beginDraw();    
  circle.colorMode(HSB);
  circle.endDraw();

  dots = new PVector[n];
  for (int i = 0; i < dots.length; i++) {
    float a = map(i, 0, n, PI, -PI);
    float x = r * cos(a);
    float y = r * sin(a);
    dots[i] = new PVector(x, y);
  }
}
void draw() {
  background(50);

  if (update || step) {
    circle.beginDraw();
    circle.clear();
    circle.stroke(map(mult % modMult, 0, modMult, 0, 255), 255, 255);
    circle.translate(r, r);
    if (int(mult) == mult) {
      for (int i = 0; i < dots.length; i++) {
        int j = (i * int(mult)) % dots.length;
        circle.line(dots[i].x, dots[i].y, dots[j].x, dots[j].y);
      }
    } else {
      for (int i = 0; i < dots.length; i++) {
        float j = (i * mult) % dots.length;
        int j1 = int(j);
        int j2 = (j1 + 1) % dots.length;
        float x = map(j, j1, j2, dots[j1].x, dots[j2].x);
        float y = map(j, j1, j2, dots[j1].y, dots[j2].y);

        //float a = map(j, 0, n, PI, -PI);
        //float x = r * cos(a);
        //float y = r * sin(a);
        circle.line(dots[i].x, dots[i].y, x, y);
      }
    }
    circle.endDraw();

    t += tStep;
    mult = map(-cos(t), -1, 1, minMult, maxMult);
    step = false;
  }
  
  image(circle, width / 2, height / 2);
  textAlign(CENTER, TOP);
  text(mult, width / 2, height / 2 + r);
  textAlign(LEFT, TOP);
  text(frameRate, 0, 0);
}

void keyPressed() {
  switch(key) {
  case ' ':
    update = !update;
    break;
    case 'k':
    step = true;
    break;
  }
}
