float size = 2;
float t = 0;

ArrayList<Point> points;

void setup()
{
  fullScreen();
  colorMode(HSB);
  noStroke();
  
  points = new ArrayList<Point>();
  for(int i = 0; i < 10; i++){
    Point p = new Point(random(width), random(height), 15);
    points.add(p);
  }
  
}
void draw()
{  
  background(0);
 
   for(Point p : points){
     p.update();
   }
 
  for(float y = 0; y < height; y+=size)
  {
    for(float x = 0; x < width; x+=size)
    {
      float min = 0;
      for(int i = 0; i < points.size(); i++)
      {
        float d = (sq(abs(x-points.get(i).pos.x)) + sq(abs(y-points.get(i).pos.y)));
        
        if(i == 0)
          min = d;
        else
        min = min(d, min);
      }
      
      //min = sqrt(min);
      fill(min % 255, 255, 255);
      rect(x,y,size, size);
    }
  }
}