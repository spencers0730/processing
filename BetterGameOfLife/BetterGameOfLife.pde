/*
  Project: Conway's Game of Life
  For: AP Computer Science 2017-18 
  Author: Spencer Schoenberg

*/

//declare gameboard that will house dead/living cells and what the last cells (_cells)
boolean[][] cells, _cells;

//set constants for min, max, and current speed (times to repeat per draw call) and size of cells
final float maxSize = 20, minSize = 1;

float size, currentSize;

final int maxSpeed = 20, minSpeed = 1;
int speed;

//define aesthetic constants
final color on = color(255), off = color(0);
final float textSize = 10;

//to run determined by pressing space to pause
boolean run;

//used for saving frames to make video
boolean record;
int frame;

//creates separation from canvas, so that even though not all cells are updated, the canvas that is shown to user does have updated frame and size
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
  //initilize game canvas with 'off' color
  game.beginDraw(); 
  game.background(off);
  game.endDraw();

  //unpause when reset, also set currentSize to size, so that size can be changed between resets of game, but not to affect current game
  run = true;
  currentSize = size;
  
  //fill screen with cells
  cells = new boolean[int(width / size)][int(height / size)];
  _cells = new boolean[cells.length][cells[0].length];
  
  //randomize beginning seed of board 
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      cells[i][j] = random(1) < .5;
    }
  }
}

void draw() {
  //clear everything on main canvas from previous draw call
  background(off);
  
  //begin draw for game canvas
  game.beginDraw();
  game.noStroke();
  
  //toggle cell at mouse
  if (mousePressed) {
    int i = max(0, floor((mouseX-1) / size));
    int j = max(0, floor((mouseY-1) / size));
    cells[i][j] = !cells[i][j];
    colorCell(i, j);
  }
  
  //copy current cell to old cells to signify changes, so that only changed cells are drawn
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      _cells[i][j] = cells[i][j];
    }
  }
  
  if (run) {
    
    //create 2D array of neighbors to determine what to do with cells based on rules
    int[][] neighbors = new int[cells.length][cells[0].length];
    
    //run speed number of times before drawing
    for (int s = 0; s < speed; s++) {
      //reset neighbors
      neighbors = new int[cells.length][cells[0].length];
      for (int i = 0; i < cells.length; i++) {
        for (int j = 0; j < cells[i].length; j++) {
          //add to neighbors of live cells
          if (cells[i][j]) {
            //allows cells to wrap around, so that the left of 0 is the right of the screen, etc
            int i1 = (i - 1 + cells.length) % cells.length;
            int i2 = (i + 1 + cells.length) % cells.length;
            int j1 = (j - 1 + cells[0].length) % cells[0].length;
            int j2 = (j + 1 + cells[0].length) % cells[0].length;

            //update neighbors 1st row respectively
            neighbors[i1][j1]++;
            neighbors[i1][j]++;
            neighbors[i1][j2]++;

            //2nd row, but not itself (not your own neighbor)
            neighbors[i][j1]++;
            neighbors[i][j2]++;

            //3rd row
            neighbors[i2][j1]++;
            neighbors[i2][j]++;
            neighbors[i2][j2]++;
          }
        }
      }

      //implement changes based on rules (https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
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
  
  //look for changes to determine whether or not to draw over old cells
  for (int i = 0; i < cells.length; i++) {
    for (int j = 0; j < cells[i].length; j++) {
      if (cells[i][j]!=_cells[i][j])
        colorCell(i, j);
    }
  }
  game.endDraw();

  //put game canvas on main canvas
  image(game, 0, 0);
  //overlay info about current game (run speed, current rect size, and size of rects if reset)
  fill(on);
  text(str(frameRate), 0, textSize);
  text("Speed: " + speed, 0, 2 * textSize);
  text("Current Size: " + currentSize, 0, 3 * textSize);
  text("Size: " + size, 0, 4 * textSize);
  
  //for recording, save frames and increment frame to make movie
  if (record) {
    String f = nf(frame, 4);
    saveFrame("frames/" + f + ".png");
    frame++;
  }
}


void keyPressed() {
  //toggle or change running, reset, record, size, and speed based on space, r, e, Up/Down, and Left/Right respectively
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
 
//makes rectangle over ith and jth cell of cells
void colorCell(int i, int j) {
  if (cells[i][j]) {
    game.fill(on);
  } else {
    game.fill(off);
  }
  game.rect(currentSize * i, currentSize * j, currentSize, currentSize);
}
