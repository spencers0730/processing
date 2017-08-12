float offset = 0;

void setup()
{
  fullScreen(P2D);
  colorMode(HSB);
}

void draw()
{
  background(0);
  offset += 3;

  for (float i = 0; i <= width; i += 2) {
    float x = (i + offset) % width;
    for (float j = 0; j <= height; j+= 2) {
      float y = (j ) % height;
      stroke(map(i, 0, width, 0, 255), 255, 255, map(j, 0, height, 0, 255));
      set(int(x), int(y), color(map(i, 0, width, 0, 255), 255, 255, map(j, 0, height, 128, 255)));
    }
  }

  //for (int i = 0; i <= width; i+=5) {
  //  println(i, width);
  //  float x = (i + offset) % width;
  //  if (i < width / 6)
  //    stroke(255, map(i, 0, width / 6, 0, 255), 0);

  //  else if (i < 2 * width / 6)
  //    stroke(map(i, width / 6, 2 * width / 6, 255, 0), 255, 0);

  //  else if (i < 3 * width / 6)
  //    stroke(0, 255, map(i, 2 * width / 6, 3 * width / 6, 0, 255));

  //  else if (i < 4 * width / 6)
  //    stroke(0, map(i, 3 * width / 6, 4 * width / 6, 255, 0), 255);

  //  else if (i < 5 * width / 6)
  //    stroke(map(i, 4 * width / 6, 5 * width / 6, 0, 255), 0, 255);

  //  else
  //    stroke(255, 0, map(i, 5 * width / 6, width, 255, 0));
  //  rect(x, 0, sqrt(x+1), height);
  //}
}