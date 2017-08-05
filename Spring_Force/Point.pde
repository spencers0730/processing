class Point {
  PVector pos;
  PVector vel;
  PVector acc;

  float springConst;
  boolean move;

  Point(float x, float y, float k, boolean move) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.springConst = k;//random(.75*k, 1.25 * k);
    this.move = !move;
  }

  void update() {
    if (this.move)
    {
      this.vel.add(this.acc);
      if (mouse)
        this.vel.add(this.pos.copy().sub(mouseX, mouseY).div(max(MIN_GRAV_DIST, sq(dist(this.pos.x, this.pos.y, mouseX, mouseY)))).mult(PULL).rotate(PI));
      this.vel.add(0, GRAV);
      this.vel.mult(DRAG_CONST);
      this.pos.add(this.vel);
      this.acc.setMag(0);
    }
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    noStroke();
    fill(255);
    ellipse(0, 0, SIZE, SIZE);
    popMatrix();
  }

  void spring(Point other, float targetLength) {
    PVector diff = other.pos.copy().sub(this.pos);
    float distance = diff.mag() - targetLength;
    PVector force = diff/*.div(targetLength)*/.mult(distance * 0.5 * (this.springConst + other.springConst)).limit(MAX_FORCE);
    this.vel.add(force);
    other.vel.add(force.rotate(PI));
    stroke( map(abs(distance), 0, targetLength * .25, 64, 255));
    //strokeWeight( map(abs(distance), 0, targetLength * .25, 1, 3));
    //stroke(map((other.springConst + this.springConst) / 2, .75 * k, 1.25 * k, 0, 255), 255, map(abs(distance), 0, targetLength * .25, 120, 255));
    //stroke(map((other.springConst + this.springConst) / 2, .75 * k, 1.25 * k, 0, 255));
    line(this.pos.x, this.pos.y, other.pos.x, other.pos.y);
  }
}