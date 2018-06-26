int[][] cells, _cells;
final color LIVE = color(0), DYING = color(128), DEAD = color(255);
final color[] STATES = {LIVE, DYING, DEAD};
PGraphics game;

void setup() {
  fullScreen();
  game =  createGraphics(width, height);
  cells = new int[width][height];
  _cells = new int[cells.length][cells[0].length];
  game.beginDraw();
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      cells[i][j] = int(random(3));
    }
  }
  game.endDraw();
}
void draw() {
  background(DEAD);  
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      _cells[i][j] = cells[i][j];
    }
  }

  int[][] neighbors = new int[cells.length][cells[0].length];
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      if (cells[i][j] == 0) {
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

  game.beginDraw();
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      if (cells[i][j] == 2) {
        if (neighbors[i][j] == 2) { 
          cells[i][j] = 0;
        }
      } else {
        cells[i][j]++;
      }


      if (cells[i][j] != _cells[i][j]) {
        colorCell(i, j);
      }
    }
  }
  game.endDraw();
  image(game, 0, 0);
}

void colorCell(int i, int j) {
  float currentSize = 1;
  game.fill(STATES[cells[i][j]]);
  game.rect(currentSize * i, currentSize * j, currentSize, currentSize);
}
