Cell[][] cells;

final float size = 3;
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
    iterate() ;
  }
}

void reset() {
  background(0);
  colorMode(HSB);
  PAUSE = true;

  x = int(width / size);
  y = int(height / size);

  cells = new Cell[x][y];
  
  color a = color(random(255), 255, 255);
  color b = color(255 - hue(a), 255, 255);

  for (int i = 0; i < cells.length; i++)
    for (int j = 0; j < cells[0].length; j++) {
      cells[i][j] = new Cell(i * size, j * size, decide(i, j), size,a, b) ;// color(255));//color(random(255), 255, 255));
      cells[i][j].update();
    }
}

boolean decide(int i, int j) {
  //return random(1) < .5;
  return i < cells.length / 2;
  //return (i * j) % 6 == 0;
  //return i % 2 == 0;
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
      int n = 5;
      int m = 8;
      boolean b = random(1) < .025;
      if (state) {
        if ((neighbors < n && neighbors > 0 ) && b) state = false;
        else  if ((neighbors > m - n && neighbors < 8) && b) state = false;
      } else {
        if ((neighbors > m - n && neighbors < 8) && b) state = true;
        else  if ((neighbors < n && neighbors > 0 ) && b) state = true;
      }
      //if(!state){ 
      //  n = m - n;
      //  m = 0;
      //}
      
      //if(neighbors < n && neighbors != m && b) state = !state;


      cells[i][j].next(state, neighbors);
    }

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
  int i = int((mouseX - 1)/ size);
  int j = int((mouseY - 1)/ size);
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