public void multiply()
{
  transformedPoints.clear();
  int count = 0;
  for(Point p: points)
  {
    int x =(int) reconvertX( convertX(p.getX())*elements.get(0).getValue()+convertY(p.getY())*elements.get(1).getValue());
    int y = (int)reconvertY(convertX(p.getX())*elements.get(2).getValue()+convertY(p.getY())*elements.get(3).getValue());
    transformedPoints.add(new Point(x,y,count));
    count++;
  }
}