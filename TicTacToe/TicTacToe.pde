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
    updateSquares();
  }
}

void updateSquares() {
  background(0);

  for (int i = 0; i < boxes.length; i++)
    for (int j = 0; j < boxes[0].length; j++) {
      boxes[i][j].update();
    }
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
  float x = width / 2 - 1.5 * size;
  float y = height / 2 - 1.5 * size;

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
  fill(128);
  float textHeight = size * .5;
  textSize(textHeight);
  String s = "Player " + winner + " won!";
  text(s, (width - textWidth(s)) / 2, height / 2 - 5 * textHeight);
}

void keyPressed() {
  switch(key) {
  case 'r':
    reset();
  }
}