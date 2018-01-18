 class Cell {
  float x, y;
  float size;
  boolean state;
  boolean nextState;
  int lastNeighbors;
  color a, b;

  Cell(float x, float y, boolean state, float size, color on, color off) {
    this.x = x;
    this.y = y;
    this.state = !state;
    this.nextState = state;
    this.size = size;
    this.a = on;
    this.b = off;
  }

  void next(boolean state, int neighbors) {
    this.nextState = state;
    this.lastNeighbors = neighbors;
  }

  void update() {
    if (this.state != this.nextState) {
      color c = (this.state) ? color(a) : color(b);
      this.state = this.nextState;
      this.show(c);
    }
  }
  void show(color c) {
    pushMatrix();
    noStroke();
    fill(c);
    rect(this.x, this.y, this.size, this.size);
    popMatrix();
  }
}