public class Point
{
  int xCoor;
  int yCoor;
  int order;
  int red;
  int green;
  int blue;
  
  public Point(int x, int y)
  {
    xCoor= x;
    yCoor = y;
    order = countPoints;
    if(countPoints==1)
    red=255;
    if(countPoints==2)
    green=255;
    if(countPoints==3)
    blue=255;
  }
  
   public Point(int x, int y, int ord)
  {
    xCoor= x;
    yCoor = y;
    order = ord;
    if(ord==1)
    red=255;
    if(ord==2)
    green=255;
    if(ord==3)
    blue=255;
  }
  
  public void draw()
  {
    fill(red,green,blue);
    noStroke();
    ellipse(xCoor, yCoor, 10,10);
  }
  
  public boolean newPoint()
  {
    for(Point element: points)
    {
      if(xCoor==element.xCoor&&yCoor==element.yCoor)
      return false;
    }
    return true;
  }
  
  public int getX()
  {
    return xCoor;
  }
  
  public int getY()
  {
    return yCoor;
  }
}