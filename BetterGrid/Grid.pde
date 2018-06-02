class Grid {
  private Node[][] nodes;
  private float k, size;
  private float space, diagSpace;

  public Grid(int w, int h, float x, float y, float space, float size, float k) {
    this.nodes = new Node[w][h];
    for (int i = 0; i < nodes.length; i++)
      for (int j = 0; j < nodes[i].length; j++) {
        nodes[i][j] = new Node(x + i * space, y + j * space);
      }    
    this.k = k;
    this.space = space;
    this.diagSpace = sqrt(2) * space;
  }

  public void update() {    
    //this.nodes[0][0].pos = new PVector(mouseX, mouseY);
    //this.nodes[this.nodes.length-1][this.nodes[0].length-1].pos = new PVector(mouseX +100, mouseY+100);

    pushMatrix();
    noFill();
    for (int i = 0; i < nodes.length; i++)
      for (int j = 0; j < nodes[i].length; j++) {
        if (i + 1 < nodes.length) {
          this.nodes[i][j].spring(this.nodes[i + 1][j], this.k, this.space);
          if (j + 1 < nodes[0].length)
            this.nodes[i][j].spring(this.nodes[i + 1][j + 1], this.k, this.diagSpace);
          if (j - 1 > 0)
            this.nodes[i][j].spring(this.nodes[i + 1][j - 1], this.k, this.diagSpace);
        }
        if (j + 1 < nodes[0].length)
          this.nodes[i][j].spring(this.nodes[i][j + 1], this.k, this.space);
      this.nodes[i][j].gravitate(mouseX, mouseY, 10);
    }
    popMatrix();


    pushMatrix();
    fill(255);
    noStroke();
    for (Node[] r : this.nodes)
      for (Node n : r)
        n.update(size);
    popMatrix();
  }
}
