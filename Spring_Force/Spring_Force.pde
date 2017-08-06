Point[][] grid;

boolean mouse;
boolean wind;

final float target = 20;
final float corner = sqrt(2) * target;
final float k = .004;
final float PULL = 15;
final float GRAV = 0.05;
final float WIND = .125;
final float MIN_GRAV_DIST = 2;
final float DRAG_CONST = .95;
final float SIZE = target * .2;
final float MAX_FORCE = 1000;

int maxX;
int maxY;

void setup() {
  fullScreen(P2D);
  smooth(8);
  colorMode(HSB);

  maxX = int(width / target / 2) - 1;
  maxY = int(height / target / 4 * 3) - 1;

  setPoints();
}

void setPoints() {
  grid = new Point[maxX][maxY];
  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid[0].length; j++) {
      grid[i][j] = new Point((i + 1) * target, (j + 1) * target, k, i == 0);
    }
  mouse = false;
  wind = true;
  background(0);
}

void draw() {
  //background(0, 10);
  pushMatrix();
  noStroke();
  fill(0, 64);
  rect(0, 0, width, height);
  popMatrix();
  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid[0].length; j++) {
      grid[i][j].update();
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

//void mousePressed() {
//  float dist = -1;
//  int x = 0, y = 0;
//  for (int i = 0; i < grid.length; i++)
//    for (int j = 0; j < grid[0].length; j++) {
//      float d = dist(mouseX, mouseY, grid[i][j].pos.x, grid[i][j].pos.y);
//      if (d < dist || dist < 0)
//      {
//        dist = d;
//        x = i;
//        y = j;
//      }
//    }
//  if (dist < 200) {
//    grid[x][y].move = !grid[x][y].move;
//    //grid[x][y].pos.x = mouseX;
//    //grid[x][y].pos.y = mouseY;
//  }
//}

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
  default:
    background(0);
    break;
  }
}