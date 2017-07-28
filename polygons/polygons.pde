PImage cat;

final float max = sqrt(sq(1080 / 2) + sq(1920 / 2));

void setup()
{
  cat = loadImage("cat.jpg");
    
  fullScreen();
  colorMode(HSB);
  strokeWeight(5);
  
  background(51);
}

void draw()
{
  background(0);  
  float num = map(dist(mouseX, mouseY, width / 2, height / 2), 10, max, 3, 100);
  num = constrain(num, 3, 100);
  if(num <= 3.5) background(0, 255, 255);
  else if(num >= 99.5) background(cat);
  
  float step = TWO_PI / num;
  
  stroke(255);
 
  beginShape();
  for(int i = 0; i < floor(num); i++)
  {
    float a = i * step;
    float x = width / 2 + 100 * cos(a);
    float y = height / 2 + 100 * sin(a);
    vertex(x, y);
  }
  endShape(CLOSE);
}