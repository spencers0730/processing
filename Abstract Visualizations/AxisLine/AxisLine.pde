float hu;

void setup()
{
  fullScreen();
  colorMode(HSB);
  strokeWeight(2);
  hu = random(255);
  
  background(0);
}

void draw()
{
  
  stroke(hu, 255, 255); 
  line(mouseX, mouseY, width - mouseX, height - mouseY);
  hu = (hu + 1) % 255;
}