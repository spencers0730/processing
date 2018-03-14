Cell[][] cells;

final float size = 1;
int x; 
int y;

boolean PAUSE;

void setup() {
  fullScreen();
  //colorMode(HSB);
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

  x = int(width / size);
  y = int(height / size);

  cells = new Cell[x][y];

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j] = new Cell(i * size, j * size, decide(i, j), size);// color(255));//color(random(255), 255, 255));
      cells[i][j].update();
    }
}

boolean decide(int i, int j) {

  return i * j % 7 == 0;
}

void iterate() {
  for (int j = 0; j < cells[0].length; j++)
    for (int i = 0; i < cells.length; i++) {
      Cell current = cells[i][j];
      boolean state = current.state;

      int neighbors = 0;

      for (int i2 = -1; i2 <= 1; i2++)
        for (int j2 = -1; j2 <= 1; j2++) {
          if (!(i2 == 0 & j2 == 0)) {
            int i3 = mod((i + i2), cells.length);
            int j3 = mod((j + j2), cells[0].length);
            if (cells[i3][j3].state)
              neighbors++;
          }
        }
      //if (neighbors != current.lastNeighbors) {
      if (state) {
        if (neighbors > 3 || neighbors < 2)
          state = false;
      } else {
        if (neighbors == 3)
          state = true;
      }

      cells[i][j].next(state, neighbors);
    }
  //}

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j].update();
    }
}

void killAll() {
  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j].nextState = false;
      cells[i][j].update();
    }
}



void mousePressed() {
  int i = int(mouseX / size);
  int j = int(mouseY / size);
  Cell c = cells[i][j];
  if (c.state) {
    c.nextState = false;
  } else {
    c.nextState = true;
  } 
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
  }
}

int mod(int value, int mod) {
  return (value % mod + mod) % mod;
}