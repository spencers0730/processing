class Particle
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  boolean stationary;
  
  float rad;
  float mass;
  float bounce;
    
  color col;
  
  Particle(PVector pos, PVector vel, float rad, float bounce, boolean stationary, color col)
  {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.rad = rad;
    this.mass = sq(this.rad) * DENSITY;
    this.bounce = bounce;
    this.stationary = stationary;
    this.col = col;
  }
  
  public void update()
  {
    this.show();
    
    if(!this.stationary)
      {
      this.vel.add(this.acc);
   
      this.acc = new PVector(0, 0);
      
      this.pos.add(this.vel);
      
      
      if(this.pos.x >= width - this.rad || this.pos.x <= this.rad)
      {
        this.vel.x *= -this.bounce;
      }
      
      if(this.pos.y >= height - this.rad || this.pos.y <= this.rad)
      {
        this.vel.y *= -this.bounce;
      }
    }
    this.pos.x = constrain(this.pos.x, this.rad, width - this.rad);
    this.pos.y = constrain(this.pos.y, this.rad, height - this.rad); 
  }
  
  private void show()
  {
    pushMatrix();
    noStroke();
    fill(this.col);
    translate(this.pos.x, this.pos.y);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    if(lines && !this.stationary)
    {
      strokeWeight(1);
      pushMatrix();
      rotate(this.vel.heading());
      stroke(0);
      line(0,0, map(this.vel.mag(), 0 , 100, 0, 1000), 0);
      popMatrix();
      pushMatrix();
      rotate(this.acc.heading());
      stroke(255);
      line(0, 0, map(this.acc.mag(), 0 , 5, 0, 1000), 0);
      popMatrix();
    }
    popMatrix();
  }
  
  public void gravitate(Particle other)
  {
    PVector dist = this.pos.copy().sub(other.pos);
    
    dist.setMag(max(dist.mag(), MAXRAD));
      
    this.acc.add(dist.copy().rotate(PI).setMag(GRAV * other.mass / sq(dist.mag())));
    other.acc.add(dist.copy().setMag(GRAV * this.mass / sq(dist.mag())));

  }
  
  public boolean collide(Particle other)
  {
    PVector dist = this.pos.copy().sub(other.pos);
    
    if(dist.mag() <= (this.rad + other.rad))
    {
      if(this.mass > other.mass && !other.stationary)
      {
        this.vel.mult(this.mass);
        this.mass += other.mass;
        this.rad = sqrt(this.mass / DENSITY);
        this.vel.add(other.vel.mult(other.mass)).div(this.mass);
        balls.remove(other);
      }
      else if(!this.stationary)
      {
        other.vel.mult(other.mass);
        other.mass += this.mass;
        other.rad = sqrt(other.mass / DENSITY);
        other.vel.add(this.vel.mult(this.mass)).div(other.mass);
        balls.remove(this);
      }
      else return false;
      
      return true;
    }
    return false;
  }
}