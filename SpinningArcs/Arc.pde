class Arc {
  float centerX;
  float centerY;

  float angle;
  float angSize;

  float arcRad;
  float arcWidth;

  float t;
  float tStep;
  float tOffset;

  float minVel;
  float velRange;
  float velPeriod;

  float minWidth;
  float widthRange;
  float widthPeriod;

  Arc(float centerX, float centerY, float arcRad, float arcWidth, float startAng, float minVel, float velRange, float velPeriod, float minWidth, float widthRange, float widthPeriod, float tOffset, float tStep) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.arcRad = arcRad;
    this.arcWidth = arcWidth;
    this.angle = startAng;
    this.t = 0;
    this.tOffset = tOffset;
    this.tStep = tStep;
    this.minVel = minVel;
    this.velRange = velRange;
    this.velPeriod = velPeriod;
    this.minWidth = minWidth;
    this.widthRange = widthRange;
    this.widthPeriod = widthPeriod;
  }

  void update() {
    this.angle += this.minVel + velRange * sin(this.tOffset + TWO_PI * this.t / this.velPeriod);
    this.angle %= TWO_PI;
    this.angSize = this.angle + this.minWidth + widthRange * sin(this.tOffset + TWO_PI * this.t / this.widthPeriod);
    this.t += this.tStep;

    pushMatrix();
    translate(this.centerX, this.centerY);
    rotate(PI / 4);
    noFill();
    stroke(255);
    strokeWeight(2);
    arc(0, 0, 2 * this.arcRad, 2 * this.arcRad, this.angle, this.angSize);
    popMatrix();
  }
}