class Node {
  private PVector pos, vel, force;
  private Grid parent;
  private List<Node> neighbors;

  Node(Grid parent, float xP, float yP) {
    this.parent = parent;
    this.pos = new PVector(xP, yP);
    this.vel = new PVector(0, 0);    
    this.force = new PVector(0, 0);
  }

  PVector getPos() {
    return this.pos.copy();
  }

  void spring() {
    if (this.neighbors == null)
      this.neighbors = this.parent.getNeighbors(this);
    for (Node o : this.neighbors) {
      PVector f = PVector.sub(this.pos, o.pos);
      stroke(map(f.magSq(), 0, this.parent.getDistSq(), 128, 255));
      line(this.pos.x, this.pos.y, o.pos.x, o.pos.y);
      f.setMag(sqrt((f.magSq() - this.parent.getDistSq()) * this.parent.getSpringK()));
      this.force.add(f);
    }
  }
  
  void gravitate(PVector point){
    PVector f = PVector.sub(point, this.pos);
    f = f.copy().setMag(this.parent.getMassSq()).div(f.magSq());
    this.force.add(f);
  }

  void update() {
    this.vel.add(this.force.div(this.parent.getMass()));
    this.pos.add(this.vel);
    float size = this.parent.getSize();
    ellipse(this.pos.x, this.pos.y, size, size);
    this.force = new PVector(0, 0);
  }
}
