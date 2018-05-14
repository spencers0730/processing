public void connectDots(ArrayList<Point> list)
{
  if(list.size()>1)
  {
  stroke(127,127,127);
  for(int i = 0; i<list.size()-1;i++)
  {
    strokeWeight(3);
    line(list.get(i).getX(), list.get(i).getY(), list.get(i+1).getX(),list.get(i+1).getY());
  }
  }
  
}

public void connectDots2(ArrayList<Point> list)
{
  stroke(127,127,127);
  strokeWeight(3);
  line(list.get(points.size()-1).getX(), list.get(points.size()-1).getY(), list.get(0).getX(),list.get(0).getY());
}