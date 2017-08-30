 final float MAG = .05;
final int MINLIFE = 30;
final int MAXLIFE = 60;

ArrayList<Point> points;

float alpha = 4;
color bg = color(0,alpha);
float hu;

float maxDist;

boolean update = true;

void setup()
{
  fullScreen();
  //size(1000, 1000);
  colorMode(HSB);
  
  maxDist = sqrt(sq(width) + sq(height));
  hu = random(255);
  points = new ArrayList<Point>(); 
  
  for(int i = 0; i < 5; i++)
  {
    Point p1 = new Point(floor(random(MINLIFE, MAXLIFE)));
    Point p2 = new Point(floor(random(MINLIFE, MAXLIFE)));
    
    points.add(p1);
    points.add(p2);
  }
  background(0);
}

void draw()
{
  if(update){
  //background(0);
  noStroke();
  fill(bg);
  rect(0, 0, width, height);
  
  hu = (hu + 1) % 255;
  
  for(int i = 0; i < points.size(); i+=2)
  {
    Point p1 = points.get(i);
    Point p2 = points.get(i + 1);
    
    p1.update();
    p2.update();
    
    //stroke(hu, 255, 255);
    //stroke(map(dist(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y), 0, maxDist, 0, 255), 255, 255);
    stroke(map(p1.count, 0, p1.lifetime, 0, 255), 255, 255);
    line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
    
  }
}}

void keyPressed(){
  switch(key){
    case ' ':
    update = !update;
    break;
  }
}