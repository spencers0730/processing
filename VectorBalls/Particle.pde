class Particle
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float rad;
  float bounce;
    
  color col;
  
  Particle(PVector pos, PVector vel, float rad, float bounce, color col)
  {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.rad = rad;
    this.bounce = bounce;
    this.col = col;
  }
  
  public void update()
  {
    this.vel.add(this.acc);
    this.vel.add(grav);
    
    this.acc.setMag(0);
    
    this.pos.add(this.vel);
    
    
    if(this.pos.x >= width - this.rad || this.pos.x <= this.rad)
    {
      this.vel.x *= -this.bounce;
    }
    
    if(this.pos.y >= height - this.rad || this.pos.y <= this.rad)
    {
      this.vel.y *= -this.bounce;
    }
    
    this.pos.x = constrain(this.pos.x, this.rad, width - this.rad);
    this.pos.y = constrain(this.pos.y, this.rad, height - this.rad);
    
    this.show();
  }
  
  private void show()
  {
    pushMatrix();
    noStroke();
    fill(this.col);
    translate(this.pos.x, this.pos.y);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    rotate(this.vel.heading());
    if(lines)
    {
      stroke(255);
      strokeWeight(1);
      line(0,0, map(vel.mag(), MINVEL, MAXVEL, 0, 70), 0);
    }
    popMatrix();
  }
  
  public void gravitate(Particle other)
  {
    float dist = (this.pos.sub(other.pos)).mag();
    if(dist < 500) 
    {
      this.acc = grav.mag() * other.rad / sq(dist);
      other.acc = grav.mag() * this.rad / sq(dist);
    }
  }
}