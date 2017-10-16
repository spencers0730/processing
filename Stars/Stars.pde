float oldX, oldY;
float min, max;
float r = 200;
float oldD, oldAngles;

void setup() {
  fullScreen();
  //noLoop();
  oldX = mouseX;
  oldY = mouseY;
  oldD = map(mouseX, 0, width, min, max);
  oldAngles = 2 * (int)(map(mouseY, 0, height, 2, 10)) + 1;
  max = min(height, width) / 2 / r;
  min = 1 / max;
}

void draw() {
  //if (oldX != mouseX || oldY != mouseY ) { 
  float d = map(mouseX, 0, width, min, max);
  int angles = 2 * (int)(map(mouseY, 0, height, 2, 10)) + 1;
  if (d != oldD || angles != oldAngles) {
    background(0);
    translate(width * .5, height * .5);
    stroke(255);
    fill(0,0,128);
    beginShape();
    for (int i = 0; i < angles; i++) {
      float angle = map(i, 0, angles - 1, 0, TWO_PI);
      float rad = r;
      if (i % 2 == 0) rad *= d;
      else rad /= d;
      float x = rad * cos(angle);
      float y = rad * sin(angle);
      vertex(x, y);
    }
    endShape(CLOSE);
  } 
  //else {
  //  background(255, 0, 0);
  //}
  oldD = d;
  oldAngles = angles;
  oldX = mouseX;
  oldY = mouseY;
}