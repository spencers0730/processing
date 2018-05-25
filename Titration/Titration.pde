float acid;
float base;
float initAcid;
float initBase;

PImage flask;

color solution;
float alpha;

float step;
void setup() {
  fullScreen();
  imageMode(CENTER);
  rectMode(CENTER);
  noStroke();
  flask = loadImage("flask.png");
  initAcid = .1;
  initBase = 0;
  acid = initAcid;
  base = initBase;
  solution = color(255, 192, 192);
  alpha = 128;
  step = .001 * ((acid > base) ? 1 : -1);
}

void draw() {
  background(255);  
  translate(width / 2, height / 2);
  image(flask, 0, 0);
  fill(solution, alpha);
  rect(0, 50, 100, 20);
}

void keyPressed() {
  switch(key) {
  case CODED:
    switch(keyCode) {
    case LEFT:
      if (acid < initAcid)
        acid += step;
      break;
    case RIGHT:
      if (acid > 0)
        acid -= step;
      else 
        base += step;
      break;
    }
    break;
  }
}
