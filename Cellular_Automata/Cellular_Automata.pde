Cell[][] cells;

final float size = 4;
int x;
int y;

void setup() {
  fullScreen();
  colorMode(HSB);

  x = int(width / size);
  y = int(height / size);

  cells = new Cell[x][y];

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      int state = DEAD;
      if (random(1) < .4) state = ALIVE;
      cells[i][j] = new Cell(i * size, j * size, state, size, color(255));
    }
}

void draw() {
  background(0);

  for (int j = 0; j < cells[0].length; j++)
    for (int i = 0; i < cells.length; i++) {
      Cell current = cells[i][j];
      int state = current.state;

      //int neighbors = 0;

      //for (int i2 = i - 1; i2 <= i + 1; i2++)
      //  for (int j2 = j - 1; j2 <= j + 1; j2++) {
      //    if (!(i == 0 && j == 0)) {
      //      int i3 = mod((i2), cells.length);
      //      int j3 = mod((j2), cells[0].length);
      //      if (cells[i3][j3].state == ALIVE)
      //        neighbors++;
      //    }
      //  }
      int neighbors = -1;

      for (int i2 = i - 1; i2 <= i + 1; i2++)
        for (int j2 = j - 1; j2 <= j + 1; j2++) {
          int i3 = mod((i2), cells.length);
          int j3 = mod((j2), cells[0].length);
          if (cells[i3][j3].state == ALIVE)
            neighbors++;
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

int mod(int value, int mod) {
  return (value % mod + mod) % mod;
}