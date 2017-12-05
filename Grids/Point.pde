float distSq(float x1, float y1, float x2, float y2) {
  return sq(x1 - x2) + sq(y1 - y2);
}

class Point {
  PVector pos;
  PVector vel;

  Grid parent;

  boolean anchor;

  Point(float x, float y, boolean anchor, Grid parent) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
    this.parent = parent;
    this.anchor = anchor;
  }

  void update() {
    if (!this.anchor) {
      if (this.parent.mouse)
        this.mouseForce();
      if (this.parent.wind)
        this.windForce();
      if (this.parent.grav)
        this.gravForce();

      //this.vel.mult(pow(this.parent.dragConst, this.parent.accuracy));
      this.pos.add(this.vel.copy().div(this.parent.accuracy));

      if (this.pos.x >= width - this.parent.bufferLength|| this.pos.x <= this.parent.bufferLength)
      {
        this.vel.x *= -1;
      }

      if (this.pos.y >= height - this.parent.bufferLength || this.pos.y <= this.parent.bufferLength)
      {
        this.vel.y *= -1;
      }

      this.pos.x = constrain(this.pos.x, -this.parent.bufferLength, 
        width + this.parent.bufferLength);
      this.pos.y = constrain(this.pos.y, -this.parent.bufferLength, 
        height + this.parent.bufferLength);
    }
  }

  void show() {
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    noStroke();
    fill(255);
    ellipse(0, 0, this.parent.pointSize, this.parent.pointSize);
    popMatrix();
  }

  void mouseForce() {
    PVector mouseGrav = this.pos.copy().sub(mouseX, mouseY)
      .div(max(this.parent.minGravDist, (distSq(this.pos.x, this.pos.y, mouseX, mouseY))))
      .mult(-this.parent.pullForce);
    this.vel.add(mouseGrav);
  }

  void windForce() {
    float a = parent.windAngle(this.pos.x, this.pos.y);
    PVector wind = new PVector(this.parent.windForce, 0).rotate(a);
    this.vel.add(wind);
  }

  void gravForce() {
    PVector grav = new PVector(0, this.parent.gravityForce);
    this.vel.add(grav);
  }

  void springForce(Point other, float target) {
    PVector diff = other.pos.copy().sub(this.pos);
    float distance = diff.mag() - target;
    PVector force = diff.mult(distance * 0.5 * (this.parent.kForce + other.parent.kForce));
    PVector repel =  other.pos.copy().sub(this.pos).setMag(.0001 / sq(diff.mag()));
    this.vel.add(force);
    other.vel.add(force.mult(-1));
    //this.vel.add(repel);
    //other.vel.add(repel.mult(-1));
    pushMatrix();
    stroke( map(abs(distance), 0, target * .25, 64, 255));
    line(this.pos.x, this.pos.y, other.pos.x, other.pos.y);
    popMatrix();
    this.gravitate(other);
  }
  
   public void gravitate(Point other)
  {
    float g = GRAV / 10;
    PVector dist = this.pos.copy().sub(other.pos);
    
    dist.setMag(max(dist.mag(), 5));
      
    this.vel.add(dist.copy().setMag(g / sq(dist.mag())));
    other.vel.add(dist.copy().mult(-1).setMag(g  / sq(dist.mag())));

  }
}