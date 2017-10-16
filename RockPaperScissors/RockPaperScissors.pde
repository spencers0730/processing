Cell[][] cells;

final float size = 1;
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
      cells[i][j] = new Cell(i * size, j * size, int(random(0) - 1), size);
    }
}

boolean decide(int i, int j) {
  return i * j % 7 == 0;
}

void iterate() {
  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      Cell current = cells[i][j];

      if (current.state != DEAD) {
        for (int i2 = -1; i2 <= 1; i2++)
          for (int j2 = -1; j2 <= 1; j2++) {
            if (i2 * j2 == 0) {
              Cell check = cells[mod(i + i2, cells.length)][mod(j + j2, cells[0].length)];
              int winner = winner(current.state, check.state);
              if (winner != 0) {
                if (winner == 1) check.next(current.state);
                else current.next(check.state);
              }
            }
          }
      }
    }


  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j].update();
    }
}

int winner(int p1, int p2) {
  if (p2 == DEAD) return 1;
  if (p1 == DEAD) return 2;
  if ((p1 + 2) % 3 == p2 || p1 - 1 == p2) return 1;
  if ((p2 + 2) % 3 == p1 || p2 - 1 == p1) return 2;
  return 0;
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