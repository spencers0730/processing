void setup()
{
  size(500, 500);
  pixelDensity(displayDensity());
}

void draw()
{
  float x = mouseX;
  noStroke();
  if (x < 128)
    fill(map(x, 0, 250, 0, 255), 255, 0);
  else
    fill(255, map(x, 250, 500, 255, 0), 0);
  //line(mouseX, 0, mouseX, height);'
  
  rect(x, 0, x, height);
}