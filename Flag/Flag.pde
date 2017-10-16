oPImage flag;

Point[][] grid;

boolean mouse;
boolean wind;
boolean show;

final float target = 20;
final float corner = .5 *2* sqrt(2) * target;
final float k = .01;
final float PULL = 5;
final float GRAV = .005;
final float WIND = .01;
final float BUFFER = 1;
final float MIN_GRAV_DIST = 2;
final float DRAG_CONST = .95;
final float SIZE = target * .2;
final float MAX_FORCE = 100;

int maxX;
int maxY;

void setup() {
  fullScreen(P2D);
  smooth(8);
  flag = loadImage("flag.png");

  maxX = int(width / target * .5) - 1;
  maxY = int(width / target * .3) - 1;

  setPoints();
}

void setPoints() {
  grid = new Point[maxX][maxY];
  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid[0].length; j++) {
      grid[i][j] = new Point((i + 1) * target, (j + 1) * target, k, i == 0 && j % ((grid[0].length - 1)) == 0);
    }
  mouse = false;
  wind = false;
  show = true;
  background(0);
}

void draw() {
  background(0);
  //pushMatrix();
  //noStroke();
  //fill(0, 64);
  //rect(0, 0, width, height);
  //popMatrix();

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid[0].length; j++) {
      grid[i][j].update();
    }

  if (!show) {
    pushMatrix();
    //fill(128);
    noStroke();
    //rect(target-5, target, target, height);
    textureMode(NORMAL);
    for (int j = 0; j < grid[0].length - 1; j++) {
      beginShape(TRIANGLE_STRIP);
      texture(flag);
      for (int i = 0; i < grid.length; i++)
      {
        vertex(grid[i][j].pos.x, grid[i][j].pos.y, map(i, 0, grid.length - 1, 0, 1), map(j, 0, grid[0].length - 1, 0, 1));
        vertex(grid[i][j+1].pos.x, grid[i][j+1].pos.y, map(i, 0, grid.length - 1, 0, 1), map(j+1, 0, grid[0].length - 1, 0, 1));
      }
      endShape();
    }
    popMatrix();
  }

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid[0].length; j++) {
      boolean right = i + 1 < grid.length;
      boolean down = j + 1 < grid[0].length;
      boolean up = j - 1 >= 0;

      if (right)
        grid[i][j].spring(grid[i + 1][j], target);
      if (down)
        grid[i][j].spring(grid[i][j + 1], target);
      if (right && down)
        grid[i][j].spring(grid[i + 1][j + 1], corner);
      if (right && up)
        grid[i][j].spring(grid[i + 1][j - 1], corner);
    }
}

void keyPressed() {

  switch(key) {
  case ' ':
    setPoints();
    break;
  case 'm':
    mouse = !mouse;
    break;
  case 'w':
    wind = !wind;
    break;
  case 's':
    show = !show;
    break;
  default:
    background(0);
    break;
  }
}