class Dot {
  private PVector pos;
  private PVector vel;
  private Set parent;
  private color zone;
  Dot(Set s) {
    parent = s;
    pos = new PVector(random(s.min.x, s.max.x), random(s.min.y, s.max.y));
    vel = PVector.random2D().mult(random(s.dotSpeed));
    zone = color(random(255), random(255), random(255), 64);
  }

  void update() {
    pushMatrix();
    noStroke();
    fill(255);
    pos.add(vel);
    if (pos.x > parent.max.x || pos.x < parent.min.x) vel.x *= -1;
    if (pos.y > parent.max.y || pos.y < parent.min.y) vel.y *= -1;
    ellipse(pos.x, pos.y, parent.dotSize, parent.dotSize);
    fill(zone);
    //ellipse(pos.x, pos.y, parent.minConnect, parent.minConnect);
    popMatrix();
  }

  void connect(List<Dot> dots) {
    for (Dot d : dots)
      if (parent == d.parent) {
        float dist = pos.copy().sub(d.pos).magSq();
        if (dist < parent.minConnectSq) {
          pushMatrix();
          float w = 2* map(dist, 0, parent.minConnectSq, parent.maxWidth, parent.minWidth);
          float t = map(dist, 0, parent.minConnectSq, 255, 0);
          //stroke(255);
          noFill();
          strokeWeight(w);
          stroke(t, 255, 255);
          line(pos.x, pos.y, d.pos.x, d.pos.y);
          popMatrix();
        }
      }
  }
}
