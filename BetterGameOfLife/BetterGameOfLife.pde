boolean[][] cells, _cells;

final float size = 10;

final color on = color(255, 128, 0), off = color(0);

boolean run;
int speed;

PGraphics game;

void setup() {
  fullScreen();
  game = createGraphics(width, height);
  noStroke();
  textSize(10);
  reset();
}

void reset() {
  background(0);
  run = true;
  speed = 1;
  cells = new boolean[int(width / size)][int(height / size)];
  _cells = new boolean[cells.length][cells[0].length];
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      cells[i][j] = random(1) < .1;
    }
  }
}

void draw() {
  if (run) {
    for (int s = 0; s < speed; s++) {
      for (int i = 0; i < cells.length; i++) {
        for (int j = 0; j < cells[i].length; j++) {
          _cells[i][j] = cells[i][j];
        }
      }
      int[][] neighbors = new int[cells.length][cells[0].length];
      for (int i = 0; i < cells.length; i++) {
        for (int j = 0; j < cells[i].length; j++) {
          if (cells[i][j]) {
            int i1 = (i - 1 + cells.length) % cells.length;
            int i2 = (i + 1 + cells.length) % cells.length;
            int j1 = (j - 1 + cells[0].length) % cells[0].length;
            int j2 = (j + 1 + cells[0].length) % cells[0].length;

            neighbors[i1][j1]++;
            neighbors[i1][j]++;
            neighbors[i1][j2]++;

            neighbors[i][j1]++;
            neighbors[i][j2]++;

            neighbors[i2][j1]++;
            neighbors[i2][j]++;
            neighbors[i2][j2]++;
          }
        }
      }

      for (int i = 0; i < cells.length; i++) {
        for (int j = 0; j < cells[i].length; j++) {
          if (cells[i][j] && (neighbors[i][j] > 3 || neighbors[i][j] < 2)) {
            cells[i][j] = false;
          } else if (neighbors[i][j] == 3) {
            cells[i][j] = true;
          }
        }
      }

      for (int i = 0; i < cells.length; i++) {
        for (int j = 0; j < cells[i].length; j++) {
          if (cells[i][j] != _cells[i][j]) {
            if (cells[i][j])
              fill(on);
            else 
            fill(off);

            rect(size * i, size * j, size, size);
          }
        }
      }
    }
    fill(on);
    text(str(frameRate), 0, 10);
  }
}


void keyPressed() {
  switch(key) {
  case ' ':
    run = !run;
    break;
  case CODED:
    switch(keyCode) {
    case RIGHT:
      speed++;
      break;
    case LEFT:
      if (speed > 1)
        speed--;
      break;
    }
    break;
  }
}

void mousePressed() {
}
