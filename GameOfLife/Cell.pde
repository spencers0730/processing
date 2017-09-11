class Cell {
  float x, y;
  float size;
  boolean state;
  boolean nextState;
  int lastNeighbors;

  Cell(float x, float y, boolean state, float size) {
    this.x = x;
    this.y = y;
    this.nextState = state;
    this.size = size;
  }

  void next(boolean state, int neighbors) {
    this.nextState = state;
    this.lastNeighbors = neighbors;
  }

  void update() {
    if (this.state != this.nextState) {
      color c = (this.state) ? color(0) : color(255);
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