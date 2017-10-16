final int X = 0;
final int O = 1;

class Square {
  boolean bot, right;
  int state = -1;

  float x, y;
  float size;


  Square(float x, float y, float s, boolean b, boolean r) {
    this.x = x;
    this.y = y;
    this.size = s;
    this.bot = b;
    this.right = r;
  }

  void update() {
    pushMatrix();
    translate(this.x, this.y);
    stroke(255);
    noFill();
    strokeWeight(1);
    if (this.bot) {
      line(0, this.size, this.size, this.size);
    }  
    if (this.right) {
      line(this.size, 0, this.size, this.size);
    }
    if (this.state == X) {
      line(0, 0, this.size, this.size);
      line(this.size, 0, 0, this.size);
    } else if (this.state == O) {
      ellipse(this.size * .5, this.size * .5, this.size, this.size);
    }
    popMatrix();
  }
}