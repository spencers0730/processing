final float target = 3;
final float corner = .5 *2* sqrt(2) * target;
final float k = .00005;
final float PULL = 1;
final float GRAV = .01;
final float WIND = .001;
final float MIN_GRAV_DIST = 2;
final float DRAG_CONST = .991;
final float SIZE = target * .2;
final float BUFFER = SIZE * 2;

Grid[] g;

boolean mouse = false;
boolean wind = false;
boolean grav = false;
boolean pause = false;

void setup() {
  fullScreen(P2D);

  g = new Grid[1];
  restart();
}

void draw() {
  if (!pause) {
    background(0);

    for (int i = 0; i < g.length; i++)
      g[i].update();
  }
}

void restart() {
  int x = int(width / target);
  int y = int(height / target); 
  for (int i = 0; i < g.length; i++)
    g[i] = new Grid(target / 2, target / 2, x, y, 
      target, k, PULL, WIND, GRAV, MIN_GRAV_DIST, BUFFER, target * .25, DRAG_CONST, .0025, .00025);
}

void reset() {
  for (int i = 0; i < g.length; i++)
    g[i].reset();
  mouse();
  wind();
  grav();
}
void mouse() {
  for (int i = 0; i < g.length; i++)
    g[i].toggleMouse(mouse);
}
void wind() {
  for (int i = 0; i < g.length; i++)
    g[i].toggleWind(wind);
}

void grav() {
  for (int i = 0; i < g.length; i++)
    g[i].toggleGrav(grav);
}

void pause() {
  pause = !pause;
}


void keyPressed() {
  switch(key) {
  case 'm':
    mouse = !mouse;
    mouse();
    break;
  case 'w':
    wind = !wind;
    wind();
    break;
  case 'g':
    grav = !grav;
    grav();
    break;
  case 'r':
    reset();
    break;
  case ' ':
    pause();
    break;
  case CODED:
    switch(keyCode) {
    }
  default:
    restart();
  }
}