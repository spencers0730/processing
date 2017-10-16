ArrayList<Ball> balls;

final float GRAV = 0;//.15;

boolean pause;

void setup() {
  fullScreen(P2D);
  
  pause = false;
  //colorMode(HSB);
  balls = new ArrayList<Ball>();
}

void draw() {
  if (!pause) {
    background(0);

    float avgY = 0;

    for (Ball b : balls) {
      b.update(25);
      avgY += b.pos.y;
    }

    avgY /= balls.size();
    stroke(255);
    fill(255);
    text(balls.size(), 10, 10);
    line(0, avgY, width, avgY);
  }
}

void mousePressed() {
  spawnBall(1000);
}

void spawnBall(int num) {
  for (int i = 0; i < num; i++) {
    PVector pos = new PVector(mouseX, mouseY);
    PVector vel = PVector.random2D().mult(5);
    PVector acc = new PVector(0, GRAV);
    float rad = random(2, 2);
    float drag = random(.975, .975);
    color col = color(random(255), random(255), random(255));
    Ball b = new Ball(pos, vel, acc, rad, drag, col);
    balls.add(b);
  }
}

void keyPressed(){
pause = !pause;
}