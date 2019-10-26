final float increment = .005;
final float timeStep = .000001;
float z = 0;

float angle(float x, float y) {
  z += timeStep;
  return map(noise(x * increment, y * increment, z), 0, 1, -TWO_PI, TWO_PI);
}

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
    this.springConst = k;
    this.move = !move;
  }

  void update() {
    if (this.move)
    {
      this.vel.add(this.acc);
      if (mouse)
        this.vel.add(this.pos.copy().sub(mouseX, mouseY).div(max(MIN_GRAV_DIST, sq(dist(this.pos.x, this.pos.y, mouseX, mouseY)))).mult(PULL).rotate(PI));
      this.vel.add(0, GRAV);
      if (wind) {
        float a = angle(this.pos.x, this.pos.y);
        PVector wind = new PVector(WIND, 0).rotate(a).mult(map(noise(this.pos.x, this.pos.y, -z), 0, 1, 0, 5));
        this.vel.add(wind);
        pushMatrix();
        translate(this.pos.x, this.pos.y);
        rotate(a);
        stroke(128, 128, 255);
        line(0, 0, wind.mag() * 400, 0);
        popMatrix();
      }
      this.vel.mult(DRAG_CONST);
      this.pos.add(this.vel);
      this.acc.setMag(0);

      if (this.pos.x >= width|| this.pos.x <= 0)
      {
        this.vel.x *= -1;
      }

      if (this.pos.y >= height || this.pos.y <= 0)
      {
        this.vel.y *= -1;
      }

      this.pos.x = constrain(this.pos.x, -BUFFER, width + BUFFER);
      this.pos.y = constrain(this.pos.y, -BUFFER, height + BUFFER);
    }
    if (show) {
      pushMatrix();
      translate(this.pos.x, this.pos.y);
      noStroke();
      fill(255);
      ellipse(0, 0, SIZE, SIZE);
      popMatrix();
    }
  }

  void spring(Point other, float targetLength) {
    PVector diff = other.pos.copy().sub(this.pos);
    float distance = diff.mag() - targetLength;
    PVector force = diff/*.div(targetLength)*/.mult(distance * 0.5 * (this.springConst + other.springConst)).limit(MAX_FORCE);
    this.vel.add(force);
    other.vel.add(force.rotate(PI));
    if (show) {
      stroke( map(abs(distance), 0, targetLength * .25, 64, 255));
      //strokeWeight( map(abs(distance), 0, targetLength * .25, 1, 3));
      //stroke(map((other.springConst + this.springConst) / 2, .75 * k, 1.25 * k, 0, 255), 255, map(abs(distance), 0, targetLength * .25, 120, 255));
      //stroke(map((other.springConst + this.springConst) / 2, .75 * k, 1.25 * k, 0, 255));
      line(this.pos.x, this.pos.y, other.pos.x, other.pos.y);
    }
  }
}
