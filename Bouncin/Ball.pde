class Ball {
  PVector pos;
  PVector vel;
  PVector acc;

  float rad;
  float drag;
  color col;

  Ball(PVector pos, PVector vel, PVector acc, float rad, float drag, color col) {
    this.pos = pos;
    this.vel = vel;
    this.acc = acc;
    this.rad = rad;
    this.drag = drag;
    this.col = col;
  }

  void update(int accuracy)
  {
    for (int i = 0; i < accuracy; i++) {
      this.vel.add(this.acc.copy().div(accuracy));
      this.pos.add(this.vel.copy().div(accuracy));

      if (this.pos.x + this.rad > width || this.pos.x < this.rad) {
        this.vel.x *= - this.drag;
      }

      if (this.pos.y + this.rad > height || this.pos.y < this.rad) {
        this.vel.y *= - this.drag;
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
    ellipse(0, 0, 2 * this.rad, 2 * this.rad);
    popMatrix();
  }
}