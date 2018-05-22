void drawQuad(ArrayList<Point> elements, int index)
{
  if(elements.size()==4)
  {
  int[] coords = new int[8];
  for(int i = 0;i<8;i++)
  {
    coords[i]=elements.get(i/2).getX();
    i++;
    coords[i]=elements.get(i/2).getY();
  }
  if(index==1)fill(0,0,255,50);
  else fill(255,255,0,50);
  quad(coords[0],coords[1],coords[2],coords[3],coords[4],coords[5],coords[6],coords[7]);
  }
}