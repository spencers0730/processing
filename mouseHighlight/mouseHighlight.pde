PVector oldMouse;
PVector newMouse;

float speed;

void setup()
{
  fullScreen();
  oldMouse = new PVector(mouseX, mouseY);
  newMouse = new PVector();
}

void draw()
{
  newMouse = new PVector(mouseX, mouseY);
  PVector delta = newMouse.sub(oldMouse);
  oldMouse = new PVector(mouseX, mouseY);
  speed = (speed + delta.mag()) / 2;
  background(map(speed, 0, 250, 0, 255));
}