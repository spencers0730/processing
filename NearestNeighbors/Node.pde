  float distSq(float x1, float y1, float x2, float y2)
{
  return sq(x1 - x2) + sq(y1 - y2);
}

class Node
{
  PVector pos;
  PVector vel;
  ArrayList<Node> neighbors;
  ArrayList<Node> nextNeighbors;
  int n;
  
  Node(float x, float y, int n)
  {
    this.pos = new PVector(x, y);
    this.vel = PVector.random2D().mult(2);
    this.neighbors = new ArrayList<Node>();
    this.n = n;
  }
  
  boolean update()
  {
    this.nextNeighbors = this.neighbors;
    addNeighbors();
    Collections.sort(new ArrayList<Node>(this.neighbors));
  }
  
  void show()
  {
    if(move)
      this.move();
    pushMatrix();
    stroke(255);
    text(this.neighbors.size(), this.pos.x, this.pos.y);
    for(Node n : this.neighbors)
    {
      //strokeWeight(map(this.n, MIN_NEIGHBORS, MAX_NEIGHBORS, 1, 2.25));
      //float hu = map(dist(this.pos.x, this.pos.y, n.pos.x, n.pos.y),0, 2000., 0, 255.);
      //stroke(255,hu, hu);
      line(this.pos.x, this.pos.y, n.pos.x, n.pos.y);
    }
    popMatrix();
  }
  
  void move()
  {
    this.pos.add(this.vel);
    
    PVector acc = new PVector(this.pos.x, this.pos.y).sub(new PVector(mouseX, mouseY)).mult(50 / (sq(this.pos.x - mouseX) +sq(this.pos.y - mouseY)));
    if(!repulsive)        
    {
      acc.rotate(PI);      
    }
    
    this.vel.add(acc);
    
    if(this.pos.x >= width || this.pos.x <= 0)
    {
      this.vel.x *= -1;
    }
    if(this.pos.y >= height || this.pos.y <= 0)
    {
      this.vel.y *= -1;
    }
    
    this.pos.x = constrain(this.pos.x, 0, width);
    this.pos.y = constrain(this.pos.y, 0, height);
  }
  

  
  void addNeighbors()
  {
    int size = this.neighbors.size();
    if(size == 0)
    {
      for(int i = 0; i < this.n; i++)
      {
        for(Node other : nodes)
        {
          if(this.neighbors.size() < this.n && other.neighbors.size() < other.n && this != other && !this.neighbors.contains(other))// && !other.neighbors.contains(this))
          {
              this.neighbors.add(other);
          }
        }
      }
    }
    else
    {
    for(int i = 0; i < size; i++)
    {
      Node neighbor = this.neighbors.get(i);
      float neighborDist = distSq(this.pos.x, this.pos.y, neighbor.pos.x, neighbor.pos.y);
      for(Node other : nodes)
      {
      if(neighbor != other && other != this && !this.neighbors.contains(other))
        {
          float dist = distSq(this.pos.x, this.pos.y, other.pos.x, other.pos.y);
          if(dist < neighborDist)
          {
            this.neighbors.remove(neighbor);
            this.neighbors.add(other);
            other.removeNeighbor();
            other.neighbors.add(this);
            break;
          }
        }
      }
    }
    }
  }
  void removeNeighbor()
  {
    int index = 0;
    float maxDist = 0;
    for(Node neighbor : this.neighbors)
    {
      float dist = distSq(this.pos.x, this.pos.y, neighbor.pos.x, neighbor.pos.y);
      if(dist > maxDist)
      {
        maxDist = dist;
        index = this.neighbors.indexOf(neighbor);
      }
    }
    this.neighbors.remove(this.neighbors.get(index));
  }
}