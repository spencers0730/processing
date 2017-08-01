float hu = 0;
float size;
float t = 0;

void setup()
{
  fullScreen();
  colorMode(HSB);
  noStroke();
  background(0);
  frameRate(10);
}

void draw()
{
  t += 0.5;
  hu = (t % 255);
  size = 25  + 5 * sin(t * .1);

  if (!(keyCode == ' '))
  {
    fill(hu, 255, 255);
    ellipse(mouseX, mouseY, size, size);
    ellipse(width - mouseX, height - mouseY, size, size);
  }
}