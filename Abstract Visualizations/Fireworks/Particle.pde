class Particle
{
  PVector pos;
  PVector vel;
  PVector acc;

  float rad;
  float mass;
  
  float bounce;
  int count;

  color col;

  Particle(PVector pos, PVector vel, float rad, float bounce, int count, color col)
  {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.rad = rad;
    this.mass = sq(this.rad) * DENSITY;
    this.bounce = bounce;
    this.count = count;
    this.col = col;
  }

  void update()
  {
    this.vel.add(this.acc);
    this.vel.add(grav);
    this.pos.add(this.vel);

    this.count--;
    this.show();
    //this.edge();
  }

  void edge() {
    if (this.pos.x <= this.rad || this.pos.x >= width - this.rad)
    {
      this.vel.x *= -this.bounce;
    }
    if (this.pos.y <= this.rad || this.pos.y >= height - this.rad)
    {
      this.vel.y *= -this.bounce;
    }

    this.pos.x = constrain(this.pos.x, this.rad, width - this.rad);
    this.pos.y = constrain(this.pos.y, this.rad, height - this.rad);
  }

  void show()
  {
    pushMatrix();
    noStroke();
    fill(this.col);
    translate(this.pos.x, this.pos.y);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    stroke(255);
    strokeWeight(1);
    fill(200);  
    if (lines)
    {
      rotate(this.vel.heading());
      line(0, 0, map(this.vel.mag(), 0, 25, 5, 70), 0);
    }
    popMatrix();
  }
}