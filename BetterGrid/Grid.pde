import java.util.*;
class Grid {
  private ArrayList<Node> nodes;
  private float springK;
  private float dist, distSq;
  private float mass, massSq;
  private float size;

  Grid(int w, int h, float dist, float mass, float springK, float size) {
    nodes = new ArrayList<Node>();
    this.mass = mass;
    this.massSq = sq(mass);
    this.springK = springK;
    this.dist = dist;
    this.distSq = sq(dist);
    this.size = size;
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        nodes.add(new Node(this, dist * i, dist * j));
      }
    }
  }

  float getSpringK() {
    return this.springK;
  }
  float getDistSq() {
    return this.distSq;
  }

  float getMass() {
    return this.mass;
  }

  float getMassSq() {
    return this.massSq;
  }
  float getSize() {
    return this.size;
  }

  List<Node> getNeighbors(Node n) {
    List<Node> neighbors = new ArrayList<Node>();
    PVector pos = n.getPos();
    for (Node o : nodes) {
      if (o.getPos().sub(pos).magSq() <= this.distSq) {
        neighbors.add(o);
      }
    }
    return neighbors;
  }

  void update(boolean g) {
    pushMatrix();
    fill(255);
    noStroke();
    for (Node n : nodes) {
      n.update();
    //  if(random(1) < .05)
    //  n.vel.add(.1, .5);
    }
    for (Node n : nodes) {
      n.spring();
    }
    if (g) {
      PVector mouse = new PVector(mouseX, mouseY);
      for (Node n : nodes) {
        n.gravitate(mouse);
      }
    }
    popMatrix();
  }
}
