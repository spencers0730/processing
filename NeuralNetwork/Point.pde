class Point {
  float x, y;
  float val;
  float[] inputLines;
  int index;

  Point(float x, float y, int index) {
    this.x = x;
    this.y = y;
    this.index = index;
  }

  void update(float val, float[] inputLines) {
    this.val = val;
    this.inputLines = inputLines;
    pushMatrix();
    fill(255);
    noStroke();
    //fill(map(this.val, MINVAL, MAXVAL, 0, 255));
    ellipse(this.x, this.y, 50, 50);
    popMatrix();
    if (this.index != 0) {
      pushMatrix();
      for (int i = 0; i < this.inputLines.length; i++) {
        stroke(map(this.inputLines[i], -5, 5, 0, 255));
        line(this.x, this.y, this.x - X_STEP, Y_BUFF + Y_STEP * i);
      }
      popMatrix();
    }
  }
}