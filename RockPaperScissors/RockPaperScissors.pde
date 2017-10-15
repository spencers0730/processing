Cell[][] cells;

final float size = 10;
int x;
int y;

int drawState;

boolean PAUSE;

void setup() {
  fullScreen();
  reset();
}

void draw() {
  if (!PAUSE) {
    iterate();
  }
}

void reset() {
  background(0);

  PAUSE = true;
  drawState = SCISSORS;

  x = int(width / size);
  y = int(height / size);

  cells = new Cell[x][y];

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j] = new Cell(i * size, j * size, int(random(4)), size);
    }
}

boolean decide(int i, int j) {
  return i * j % 7 == 0;
}

void iterate() {
  for (int j = 0; j < cells[0].length; j++)
    for (int i = 0; i < cells.length; i++) {
      Cell current = cells[i][j];

      if (current.state != DEAD) {
        for (int i2 = -1; i2 <= 1; i2++)
          for (int j2 = -1; j2 <= 1; j2++) {
            Cell check = cells[mod(i + i2, cells.length)][mod(j + j2, cells[0].length)];
           switch(check.state){
               case DEAD:
               switch(check.nextState)
           }
            //if ((check.state - 1) % 3 <= current.state
            //      && (check.state - 1) % 3 <= current.nextState) {
            //  check.next(current.state);
            //}
          }
      }
    }

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j].update();
    }
}

void killAll() {
  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j].next(DEAD);
      cells[i][j].update();
    }
}



void mousePressed() {
  int i = int(mouseX / size);
  int j = int(mouseY / size);
  Cell c = cells[i][j];
  c.next(drawState);
  c.update();
}

void mouseDragged() {
  mousePressed();
}

void keyPressed() {
  switch(key) {
  case ' ':
    PAUSE = !PAUSE;
    break;
  case 's':
    PAUSE = true;
    iterate();
    break;
  case 'r':
    reset();
    break;
  case 'k':
    killAll();
    break;
  case 't':
    drawState++;
    drawState %= 4;
    //case CODED:
    //  switch(keyCode) {
    //  case TAB:
    //    drawState++;
    //    drawState %= 4;
    //  }
  }
}

int mod(int value, int mod) {
  return (value % mod + mod) % mod;
}