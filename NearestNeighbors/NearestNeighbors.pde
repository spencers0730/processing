final int NUM_NODES = 100;
final int MIN_NEIGHBORS = 4;
final int MAX_NEIGHBORS = 5;

ArrayList<Node> nodes; 

boolean move;
boolean repulsive;

void setup()
{
  fullScreen();
  //colorMode(HSB);
  textSize(30);
  
  move = true;
  repulsive = false;
  
  reset();
}

void draw()
{
   background(51);
   for(Node n : nodes)
   {
     n.update();
     n.show();
   }
}


void reset()
{
  nodes = new ArrayList<Node>();
  nodes.clear();
  addNodes(NUM_NODES);
}

void addNodes(int n)
{
  for(int i = 0; i < n; i++)
  {
    float x = random(width);
    float y = random(height);
    int numNeighbors = int(random(MIN_NEIGHBORS, MAX_NEIGHBORS));

    Node n1 = new Node(x, y, numNeighbors);
    
    nodes.add(n1);
  }
}

void mousePressed()
{
  repulsive = !repulsive;
}

void keyPressed()
{
  switch(key)
  {
    case ' ':
    move = !move;
    break;
    default:
    reset();
    break;
  }
}