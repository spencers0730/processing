final static int DEAD = 0;
final static int ALIVE = 1;


class Cell {
  float x, y;
  float size;
  int state;
  int nextState;

  color col;

  Cell(float x, float y, int state, float size, color col) {
    this.x = x;
    this.y = y;
    this.state = -1;
    this.nextState = state;
    this.size = size;
    this.col = col;
  }

  void next(int state) {
    this.nextState = state;
  }

  void update() {
    if (this.state != this.nextState) {
      this.state = this.nextState;
      this.show();
    }
  }
  void show() {
    pushMatrix();
    noStroke();
    //stroke(128);
    fill(0);
    if (this.state == ALIVE) {
      fill(this.col);
      noStroke();
    }
    rect(this.x, this.y, this.size, this.size);
    popMatrix();
  }
}