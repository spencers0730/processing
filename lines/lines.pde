
void setup()
{
  //size(1000, 1000);
  fullScreen();
  colorMode(HSB);
}

void draw()
{
  background(51);
  int j = 6;
  for(int i = 0; i <= j; i++)
  {
    float hu = random(255);
    stroke(hu, 255, 255);
    float x = map(i, 0, j, 0, width);
    line(x, 0, width - x, height);
    float y = map(i, 0, j, 0, height);
    line(0, y, width, height - y);
  }
}