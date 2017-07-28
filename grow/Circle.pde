class Circle
{
  float x;
  float y;
  float r;
  float s;
  
  boolean grow;
  
  color col;
  
  int n;
  
  Circle(float x, float y, float r, float s)
  {
    this.x = x;
    this.y = y;
    this.r = r;
    this.s = s;
    
    //this.col = color(0,0,255);
    this.grow = true;
    
    n = circles.size();
  }
  
  void update()
  {
    pushMatrix();
    noFill();
    stroke(map(this.n, 0, circles.size(), 0, 255), 255, 255);
    strokeWeight(1);
    ellipse(this.x, this.y, 2 * this.r, 2 * this.r);
    popMatrix();
   
   
    if(this.grow)
    {
      this.col = color(0,0,255);
      this.r += this.s;
    }
    else
    {
      this.col = color(255,0,0);
    }
  }
  
  boolean collide(Circle other)
  {
    if(this.grow)
    {
      float d = dist(this.x, this.y, other.x, other.y);
      if(d <= this.r + other.r + SPACING)
      {
        this.grow = false;
        other.grow = false;
        return true;
      }
    }
    return false;
  }
  
}