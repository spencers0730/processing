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
    this.state = state;
    this.size = size;
    this.col = col;
  }

void next(int state){
  this.nextState = state;
}

  void update() {
    this.state = this.nextState;
    if (this.state == 1) {
      pushMatrix();
      noStroke();
      fill(this.col);
      rect(this.x, this.y, this.size, this.size);
      popMatrix();
    }
  }
}