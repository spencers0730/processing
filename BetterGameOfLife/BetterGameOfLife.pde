boolean[][] cells, _cells;

final float maxSize = 20, minSize = 1;

float size, currentSize;

final int maxSpeed = 20, minSpeed = 1;
int speed;

final color on = color(255), off = color(0);
final float textSize = 10;

boolean run;

boolean record;
int frame;

PGraphics game;

void setup() {
  fullScreen();
  game = createGraphics(width, height);
  textSize(textSize);
  size = 5;
  speed = 1;
  frame = 0;
  record = false;
  reset();
}

void reset() {    
  game.beginDraw(); 
  game.background(off);
  game.endDraw();

  run = true;
  currentSize = size;
  cells = new boolean[int(width / size)][int(height / size)];
  _cells = new boolean[cells.length][cells[0].length];
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      cells[i][j] = random(1) < .5;
    }
  }
}

void draw() {
  background(0);
  game.beginDraw();
  game.noStroke();
  if (mousePressed) {
    int i = max(0, floor((mouseX-1) / size));
    int j = max(0, floor((mouseY-1) / size));
    cells[i][j] = !cells[i][j];
    colorCell(i, j);
  }

  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      _cells[i][j] = cells[i][j];
    }
  }

  if (run) {
    int[][] neighbors = new int[cells.length][cells[0].length];
    for (int s = 0; s < speed; s++) {
      neighbors = new int[cells.length][cells[0].length];
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
    }
  }


  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      if (cells[i][j]!=_cells[i][j])
        colorCell(i, j);
    }
  }
  game.endDraw();

  image(game, 0, 0);
  fill(255);
  text(str(frameRate), 0, textSize);
  text("Speed: " + speed, 0, 2 * textSize);
  text("Current Size: " + currentSize, 0, 3 * textSize);
  text("Size: " + size, 0, 4 * textSize);


  if (record) {
    String f = ("0000" + frame).substring((""+frame).length());
    saveFrame("frames/" + f + ".png");
    frame++;
  }
}


void keyPressed() {
  switch(key) {
  case ' ':
    run = !run;
    break;
  case 'r':
    reset();
    break;
  case 'e':
    record = !record;
    break;
  case CODED:
    switch(keyCode) {
    case UP:
      if (size < maxSize)
        size++;
      break;
    case DOWN:
      if (size > minSize)
        size--;
      break;
    case RIGHT:
      if (speed < maxSpeed)
        speed++;
      break;
    case LEFT:
      if (speed > minSpeed)
        speed--;
      break;
    }
    break;
  }
}

void colorCell(int i, int j) {
  if (cells[i][j]) {
    game.fill(on);
  } else {
    game.fill(off);
  }
  game.rect(currentSize * i, currentSize * j, currentSize, currentSize);
}
