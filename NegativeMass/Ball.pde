public class Ball {
  private final static float accuracy = 1;
  private final static float multVecDraw = 10;
  private final static float gravityMult = .15;

  private PVector pos;
  private PVector vel;
  private PVector acc;

  private float rad;
  private float d;
  private float mass;

  private color c;


  public Ball(PVector pos, PVector vel, float rad, float d) {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.rad = rad;
    this.d = d;
    this.mass = this.d * pow(this.rad, 3);
    colorMode(HSB);
    this.c = color(random(255), 255, 255);
    if (this.d < 0) {
      colorMode(RGB);
      this.c = color(255);
    }
  }
  
  public PVector getPos() {
    return this.pos.copy();
  }

  public float getVelMag() {
    return this.vel.mag();
  }

  public float getMass() {
    return this.mass;
  }

  public float getRad() {
    return this.rad;
  }

  public void addAcc(PVector add) {
    this.acc.add(add);
  }

  public void update(ArrayList<Ball> others, boolean edges, boolean lines, boolean collide, boolean gravity) {
    this.acc = new PVector(0, 0);
    for (int i = 0; i < Ball.accuracy; i++) {
      this.forces(others, collide, gravity); 
      this.vel.add(this.acc.copy().mult(1/Ball.accuracy));
      this.pos.add(this.vel.copy().mult(1/Ball.accuracy)); 
      this.edges(edges);
    }
    this.show();
    if (lines)
      this.showLines();
  }

  private void forces(ArrayList<Ball> others, boolean collide, boolean gravity) {
    for (Ball b : others) {
      if (b != this) {
        PVector diff = b.getPos().sub(this.pos); 
        float min = (this.rad + b.getRad()); 
        boolean colliding = diff.mag() < min;
        if (gravity || (collide && colliding)) {
          if (colliding)
            diff.mult(-1);
          float mag = Ball.gravityMult * this.mass * b.getMass() / diff.magSq(); 
          diff.setMag(mag); 
          PVector force = diff.mult(1/accuracy);
          this.acc.add(force.mult(1/this.mass));
        }
      }
    }
  }


  private void drawLine(PVector l, float m, color c) {
    pushMatrix(); 
    translate(this.pos.x, this.pos.y); 
    stroke(c); 
    //strokeWeight(3);
    line(0, 0, l.x * m, l.y * m); 
    popMatrix();
  }

  private void edges(boolean edges) {
    if (this.pos.x > width || this.pos.x < 0) {
      if (edges) {
        this.pos.x -= width; 
        this.pos.x *= -1;
      } else {
        this.vel.x *= -1;
      }
    }
    if (this.pos.y > height || this.pos.y < 0) {
      if (edges) {
        this.pos.y -= height; 
        this.pos.y *= -1;
      } else {
        this.vel.y *= -1;
      }
    }
  }

  private void show() {
    noStroke();
    fill(this.c);
    ellipse(this.pos.x, this.pos.y, 2 * this.rad, 2 * this.rad);
  }

  private void showLines() {
    this.drawLine(this.vel, multVecDraw, color(255));
    this.drawLine(this.acc, multVecDraw * Ball.accuracy, color(128));
  }
}