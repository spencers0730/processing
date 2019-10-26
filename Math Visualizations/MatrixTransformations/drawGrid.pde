public void drawGrid()
{
  stroke(0,0,0);
  line(0,300,800,300);
   line(400,0,400,600);
   for(int i = 1; i<13;i++)
   {
     line(395,i*50,405,i*50);
   }
   for(int i = 1; i<17;i++)
   {
     line(i*50, 295, i*50, 305);
   }
}