class Node {
   PVector pos, vel;

  Node(float xP, float yP) {
    this.pos = new PVector(xP, yP);
    this.vel = new PVector(0, 0);
  }

  void spring(Node o, float k, float space) {
    PVector sub = PVector.sub(this.pos, o.pos);
    sub.setMag((sub.mag() - space));
    stroke(map(sub.magSq(), 0, sq(space), 128, 255));
    line(this.pos.x, this.pos.y, o.pos.x, o.pos.y);
    sub.mult(k);
    o.vel.add(sub);
    sub.mult(-1);
    this.vel.add(sub);
  }
  
  void gravitate(float x, float y, float g){
    PVector sub = (new PVector(x, y)).sub(this.pos);
    sub.setMag(g / max(.1, sub.magSq()));
    this.vel.add(sub);
  }

  void update(float size) {
    ellipse(this.pos.x, this.pos.y, size, size);
    this.pos.add(this.vel);
  }
}
