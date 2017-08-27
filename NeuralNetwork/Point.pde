class Point {
  float x, y;
  float s;
  float val;
  float[] inputLines;
  int index;

  Point(float x, float y, float s, int index) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.index = index;
  }

  void update(float val, float[] inputLines) {
    this.inputLines = inputLines;
    pushMatrix();
    for (int i = 0; i < this.inputLines.length; i++) {
      if (map) {
        //stroke(map(this.inputLines[i], minWeight, maxWeight, 0, 255));
        stroke(map(this.inputLines[i], -1, 2, 0, 255), 255, 255);
      } else {
        stroke(0);
      }
      line(this.x, this.y, this.x - X_STEP, Y_BUFF + Y_STEP * i);
    }
    popMatrix();
    this.circle(val);
  }


  void circle(float val) {
    this.val = val;
    pushMatrix();
    translate(this.x, this.y);
    fill(255);
    noStroke();
    ellipse(0, 0, this.s, this.s);
    fill(0);
    textSize(10);
    text(this.val, 0, 0);
    popMatrix();
  }
}