ArrayList<Ball> balls;
boolean update, edges, lines, background, collide, gravity;

void setup() {
  fullScreen();
  pushMatrix();
  colorMode(HSB);
  textSize(10);
  popMatrix();
  update = true;
  edges = false;
  lines = false;
  background = true;
  collide = false;
  gravity = true;
  noStroke();

  balls = new ArrayList<Ball>();
  for (int i = 0; i < 5; i++) {
    float x = random(width);
    float y = random(height);
    float r = random(1, 1); 
    addBall(x, y, r);
  }
}

void draw() {
  if (update) {
    if (background)
      background(0); 
    float totalMass = 0;
    float totalMomentum = 0;
    for (Ball b : balls)
      b.reset();
    for (Ball b : balls) {
      b.update(balls, edges, lines, collide, gravity);
      float m = b.getMass();
      totalMass += m;
      totalMomentum += b.getVelMag() * m;
    }
    String tM = totalMass + " mass units";
    String tP = totalMomentum + " moementum units";
    fill(255);
    text(tM, 0, 10);
    text(tP, 0, 20);
  }
}

void keyPressed() {
  switch(key) {
  case ' ' : 
    update = !update; 
    break; 
  case 'e' : 
    edges = !edges; 
    break; 
  case TAB : 
    lines = !lines; 
    break; 
  case 'b' : 
    background = !background; 
    break; 
  case 'c' : 
    collide = !collide; 
    break; 
  case 'g' : 
    gravity = !gravity; 
    break;
  }
  //if(keyCode == ' ') update = !update;
}

void mousePressed() {
  float x = mouseX;
  float y = mouseY;
  float r = random(10, 20); 
  addBall(x, y, r);
}

void addBall(float x, float y, float r) {
  PVector pos = new PVector(min(max(r, x), width - r), min(max(r, y), height - r));
  float angle = random(2 * PI);
  PVector vel = PVector.fromAngle(angle).setMag(2);
  float d = 1; 
  //if (random(1) < .5) {
  //  d *= -1;
  //}
  Ball b = new Ball(pos, vel, r, d); 
  balls.add(b);
}