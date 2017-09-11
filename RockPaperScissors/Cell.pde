final int DEAD = 0;
final int ROCK = 1;
final int PAPER = 2;
final int SCISSORS = 3;

class Cell {
  float x, y;
  float size;
  int state;
  int nextState;
  
  Cell(float x, float y, int state, float size) {
    this.x = x;
    this.y = y;
    this.nextState = state;
    this.size = size;
    this.update();
  }

  void next(int state) {
    this.nextState = state;
  }

  void update() {
    if (this.state != this.nextState) {
      this.state = this.nextState;
      color c;
      switch(this.state){
        case ROCK:
        c = color(255, 0, 0);
        break;
        case PAPER:
        c = color(0, 255, 0);
        break;
        case SCISSORS:
        c = color(0, 0, 255);
        break;
        default:
        c = color(0);
      }
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