float x;
float y;
float xVel;
float yVel;
float t;
void setup() {
  fullScreen(P2D);
  fill(128, 128, 255);
  noStroke();
  t = 0;
  x = random(width);
  y = random(height);
  xVel = random(2, 10);
  yVel = random(2, 10);
}

void draw() {
  background(0, 64, 128);
  float s = map(sin(t), -1, 1, 30, 100);
  if (x > width - s || x < 0) xVel *= -1;
  if (y > height - s || y < 0) yVel *= -1;
  rect(x, y, s, s);
  x += xVel;
  y += yVel;
  t += 0.05;
 
   yVel += 0.5;
  PVector g = new PVector(mouseX - x, mouseY - y);
  
}