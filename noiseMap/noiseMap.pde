float zOff = 0;

final float s = 20;

void setup() {
  fullScreen();
}

void draw() {
  background(0);
  float xOff = 0;
  float yOff = 0;
  
  for (float x = 0; x < width; x += s) {
    for (float y = 0; y < height; y += s) {
      pushMatrix();
      translate(x, y);
      rotate(map(noise(xOff, yOff, zOff), 0, 1, 0, TWO_PI));
      stroke(255);
      line(-.5*s,0,.5*s,0);
      popMatrix();
      yOff += .01;
    }
    xOff += .02;
  }
  zOff += .05;
}