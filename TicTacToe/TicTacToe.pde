final float size = 250;


int player;
boolean done;
Square[][] boxes;

void setup() {
  fullScreen();
  reset();
}

void draw() {
  if (!done) {
    background(0);
    updateSquares();
    key();
  } 
}

void updateSquares() {
  for (int i = 0; i < boxes.length; i++)
    for (int j = 0; j < boxes[0].length; j++) {
      boxes[i][j].update();
    }
}

void key() {
  pushMatrix();
  fill(255);
  stroke(255);
  String s = "Current Player: " + ((player == 0) ? 1 : 0);
  float location = size / 10;
  float x = location;
  float y = location;
  textSize(location);
  text(s, x, y);
  x += textWidth(s) + location;
  y -= location;
  if (player == 1) {
    float center = location / 2;
    x += center;
    y += center;
    noFill();
    ellipse(x, y, location, location);
  } else {
    line(x, y, x + location, y + location);
    line(x + location, y, x, y + location);
  }  
  popMatrix();
}

void mousePressed() {
  if (!done) {

    boolean found = false;
    Square current = null;
    for (int i = 0; i < boxes.length; i++)
      for (int j = 0; j < boxes[0].length && !found; j++) {
        current = boxes[i][j];
        found =  (mouseX > current.x && mouseX < current.x + current.size &&
          mouseY > current.y && mouseY < current.y + current.size);
      }
    if (current != null) {
      if (current.state == -1) {
        current.state = player;
        player = (player + 1) % 2;

        int win = -1;

        for (int i = 0; i < boxes[0].length && win == -1; i++) {
          if (boxes[i][0].state == boxes[i][1].state && boxes[i][0].state == boxes[i][2].state) {
            win = boxes[i][0].state;
          }
        }
        for (int j = 0; j < boxes[0].length && win == -1; j++) {
          if (boxes[0][j].state == boxes[1][j].state && boxes[0][j].state == boxes[2][j].state) {
            win = boxes[0][j].state;
          }
        }
        if (win == -1) {
          if (boxes[0][0].state == boxes[1][1].state && boxes[0][0].state == boxes[2][2].state) {
            win = boxes[0][0].state;
          } else if (boxes[2][0].state == boxes[1][1].state && boxes[2][0].state == boxes[0][2].state) {
            win = boxes[2][0].state;
          }
        }
        if (win != -1) {
          endGame(win + 1);
        }
      }
    }
  }
}

void reset() {
  float x = (width - 3 * size) / 2;
  float y = (height - 3 * size) / 2;

  done = false;

  player = 1;
  boxes = new Square[3][3];
  for (int i = 0; i < boxes.length; i++)
    for (int j = 0; j < boxes[0].length; j++) {
      boxes[i][j] = new Square(x + size * i, y + size * j, size, j != 2, i != 2);
    }
}

void endGame(int winner) {
  updateSquares();
  done = true;
  pushMatrix();
  fill(255);
  float textHeight = size * .5;
  textSize(textHeight);
  String s = "Player " + winner + " won!";
  text(s, (width - textWidth(s)) / 2, (height - textHeight) / 2);
  popMatrix();
}

void keyPressed() {
  switch(key) {
  case 'r':
    reset();
  }
}