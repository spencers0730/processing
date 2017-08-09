class Point
{
  PVector pos;
  PVector vel;
  PVector acc;

  PVector wind;

  boolean stationary;

  float rad;
  float bounce;

  color col;

  Point(PVector pos, PVector vel, float rad, float bounce, boolean stationary, color col)
  {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.rad = rad;
    this.bounce = bounce;
    this.stationary = stationary;
    this.col = col;
  }

  public void update(int accuracy)
  {

    if (!this.stationary)
    {
      //this.vel.add(this.acc.copy().div(accuracy));
      this.vel.y += .31 / accuracy;
      this.wind = new PVector(map(noise(-this.pos.x, -this.pos.y), 0, 1, 0, .2), 0).rotate(angle(this.pos.x, this.pos.y));
      this.vel.add(wind.copy().div(accuracy));

      this.pos.add(this.vel.copy().div(accuracy));


      if (this.pos.x >= width - this.rad || this.pos.x <= this.rad)
      {
        this.vel.x *= -this.bounce;
      }

      if (this.pos.y >= height - this.rad || this.pos.y <= this.rad)
      {
        this.vel.y *= -this.bounce;
      }

      this.pos.x = constrain(this.pos.x, this.rad, width - this.rad);
      this.pos.y = constrain(this.pos.y, this.rad, height - this.rad);
    }
    this.show();
  }

  void show()
  {
    pushMatrix();
    noStroke();
    fill(this.col);
    translate(this.pos.x, this.pos.y);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    if (lines)
    {
      strokeWeight(1);
      pushMatrix();
      rotate(this.wind.heading());
      stroke(255);
      line(0, 0, map(this.wind.mag(), 0, 10, 0, 1000), 0);
      popMatrix();
      //pushMatrix();
      //rotate(this.acc.heading());
      //stroke(255);
      //line(0, 0, map(this.acc.mag(), 0 , 5, 0, 1000), 0);
      //popMatrix();
    }
    popMatrix();
  }
}