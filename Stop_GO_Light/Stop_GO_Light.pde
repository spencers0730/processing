float offset = 0;

void setup()
{
  fullScreen(P2D);
  colorMode(HSB);
}

void draw()
{
  background(255);
  offset += 3;

  for (float i = 0; i <= width; i += 1) {
    float x = (i + offset) % width;
    for (float j = 0; j <= height; j+= 1) {
      float y = (j ) % height;
      stroke(map(i, 0, width, 0, 255), 255, 255, map(j, 0, height, 0, 255));
      set(int(x), int(y), color(map(i, 0, width, 0, 255), 255, 255, map(dist(i, j, mouseX, mouseY), 0, width, 255, 0)));
    }
  }
}