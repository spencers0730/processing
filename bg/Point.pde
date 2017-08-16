class Point
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  int lifetime;
  int count;
  
  Point(int lifetime)
  {
    this.pos = new PVector(random(width), random(height));
    this.vel = new PVector(0, 0);
    this.lifetime = lifetime;
    this.reset();
  }
  
  void reset()
  {
    this.count = 0;
    this.acc = PVector.random2D().mult(MAG);
  }
  
  void update()
  {
    this.pos.add(this.vel);
    this.vel.add(this.acc);
    this.count++;
    if(this.count >= this.lifetime)
    {
      this.reset();
    }
    if(this.pos.x <= 0 || this.pos.x >= width)
    {
      this.pos.x = constrain(this.pos.x, 0, width);
      this.vel.x *= -1;
    }
    if(this.pos.y <= 0 || this.pos.y >= height)
    {
      this.pos.y = constrain(this.pos.y, 0, height);
      this.vel.y *= -1;
    }
    
    //pushMatrix();
    //translate(this.pos.x, this.pos.y);
    //stroke(255);
    ////line(0,0,5*this.vel.x, 5*this.vel.y);
    //line(0,0,50*this.acc.x, 50*this.acc.y);
    //popMatrix();
  }
  
  
}