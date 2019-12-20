class Particle {
  PVector pos;
  PVector vel;
  PVector acc;

  boolean stationary;

  float rad;
  float mass;
  float bounce;

  color col;

  Particle(PVector pos, PVector vel, float rad, float bounce, boolean stationary, color col) {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.rad = rad;
    this.mass = sq(this.rad) * DENSITY;
    this.bounce = bounce;
    this.stationary = stationary;
    this.col = col;
  }

  void update() {
    this.vel.y += GRAV / accuracy;
    // this.show();

    if (!this.stationary) {
      this.vel.add(this.acc.copy().div(accuracy));

      this.acc = new PVector(0, 0);

      this.pos.add(this.vel.copy().div(accuracy));

      if (this.pos.x >= width - this.rad || this.pos.x <= this.rad) {
        this.vel.x *= -this.bounce;
      }

      if (this.pos.y >= height - this.rad || this.pos.y <= this.rad) {
        this.vel.y *= -this.bounce;
      }
    }
    this.pos.x = constrain(this.pos.x, this.rad, width - this.rad);
    this.pos.y = constrain(this.pos.y, this.rad, height - this.rad);
  }

  void show(PGraphics pg) {
    pg.pushMatrix();
    pg.noStroke();
    pg.fill(this.col);
    pg.translate(this.pos.x, this.pos.y);
    pg.ellipse(0, 0, this.rad * 2, this.rad * 2);
    if (lines && !this.stationary) {
      pg.strokeWeight(1);
      pg.pushMatrix();
      pg.rotate(this.vel.heading());
      pg.stroke(0);
      pg.line(0, 0, map(this.vel.mag(), 0, 100, 0, 1000), 0);
      pg.popMatrix();
      pg.pushMatrix();
      pg.rotate(this.acc.heading());
      pg.stroke(255);
      pg.line(0, 0, map(this.acc.mag(), 0, 5, 0, 1000), 0);
      pg.popMatrix();
    }
    pg.popMatrix();
  }

  void hit(Particle other) {
    PVector dist = this.pos.copy().sub(other.pos);

    if (dist.mag() <= this.rad + other.rad) {
      // dist.setMag(max(dist.mag(), MAXRAD));

      this.acc.add(dist.copy().setMag(PUSH * other.mass / sq(dist.mag())));
      other.acc.add(dist.copy().rotate(PI).setMag(PUSH * this.mass / sq(dist.mag())));
    }
  }

  void combine(Particle other) {
    this.vel.mult(this.mass);
    this.col = color((hue(this.col) * (this.mass) + hue(other.col) * other.mass) / (this.mass + other.mass), 255, 255);
    this.mass += other.mass;
    this.rad = sqrt(this.mass / DENSITY);
    this.vel.add(other.vel.mult(other.mass)).div(this.mass);
    balls.remove(other);
  }

  boolean collide(Particle other) {
    PVector dist = this.pos.copy().sub(other.pos);

    if (dist.mag() <= (this.rad + other.rad)) {
      if (this.mass > other.mass && !other.stationary) {
        this.combine(other);
      } else if (!this.stationary) {
        other.combine(this);
      } else
        return false;

      return true;
    }
    return false;
  }
}
