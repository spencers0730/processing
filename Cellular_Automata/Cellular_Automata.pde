Cell[][] cells;

final float size = 1;
int x;
int y;

boolean PAUSE;

void setup() {
  fullScreen();
  colorMode(HSB);

  PAUSE = false;

  x = int(width / size);
  y = int(height / size);

  cells = new Cell[x][y];

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j] = new Cell(i * size, j * size, j % 2, size, color(255));//color(random(255), 255, 255));
      cells[i][j].update();
    }
}

void draw() {
  if (!PAUSE) {
    //background(0);
    iterate();
  }
}

void iterate() {
  for (int j = 0; j < cells[0].length; j++)
    for (int i = 0; i < cells.length; i++) {
      Cell current = cells[i][j];
      int state = current.state;

      int neighbors = 0;

      for (int i2 = -1; i2 <= 1; i2++)
        for (int j2 = -1; j2 <= 1; j2++) {
          if (!(i2 == 0 & j2 == 0)) {
            int i3 = mod((i + i2), cells.length);
            int j3 = mod((j + j2), cells[0].length);
            if (cells[i3][j3].state == ALIVE)
              neighbors++;
          }
        }

      if (state == ALIVE) {
        if (neighbors > 3 || neighbors < 2)
          state = DEAD;
      } else {
        if (neighbors == 3)
          state = ALIVE;
      }

      cells[i][j].next(state);
    }

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j].update();
    }
}



void mousePressed() {
  int i = int(mouseX / size);
  int j = int(mouseY / size);
  Cell c = cells[i][j];
  if (c.state == ALIVE) {
    c.nextState = DEAD;
  } else {
    c.nextState = ALIVE;
  } 
  c.update();
  println("switched " + i, j);
}

void keyPressed() {
  switch(key) {
  case ' ':
    PAUSE = !PAUSE;
  }
}

int mod(int value, int mod) {
  return (value % mod + mod) % mod;
}