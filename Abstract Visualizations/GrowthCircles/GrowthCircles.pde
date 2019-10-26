final int num = 10;

final float SPEED = 1; 
final float MIN_RAD = 1;

final float SPACING = SPEED;

final float MAX_TRIES = 50;
final int MAX_FAILS = 200;

int fails;
ArrayList<Circle> circles;

void setup()
{
  fullScreen();
  colorMode(HSB);
  
  circles = new ArrayList<Circle>();
  circles.clear();
  fails = 0;

  addCircles(num);
}

void draw()
{
  background(51);
  
  fails = 0;
  int add = 0;
  
  for(Circle c : circles)
  {
    c.update();
    for(Circle other : circles)
    {
      if(c != other)
      {
        if(c.collide(other))
        {
          add += 2;
        }
      }
      
    }
  }
    
  addCircles(add);

  if(fails >= MAX_FAILS)
  {
    textSize(30);
    fill(0);
    noStroke();
    translate(width / 2, height / 2);
    String str = "DONE";
    text(str, -textWidth(str) * 0.5, 0);
    str = circles.size() + " circles";
    text(str, -textWidth(str) * 0.5, 30);
    
    int now = millis();
    while(millis() - now < 10000)
    {}
    setup();
  }
}

void addCircles(int n)
{
  for(int i = 0; i < n; i++)
  {
    float x = 0;
    float y = 0;
    float r = MIN_RAD;
    float s = SPEED;

    boolean colliding = true;
    for(int j = 0; j < MAX_TRIES && colliding; j++)
    {
      x = random(width);
      y = random(height);
      colliding = collide(x, y, r);
    }
    if(!colliding)
    {
      Circle c = new Circle(x, y, r, s);
      circles.add(c);
    }
    else
    {
      fails++;
    }
  }
}

boolean collide(float x, float y, float r)
{
  if(circles.size() == 0)
    return false;
  
  for(Circle c : circles)
  {
    float d = dist(x, y, c.x, c.y);
    if(d <= r + c.r + SPACING)
      return true;
  }
  return false;
}