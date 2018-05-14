public class matrixElement
{
  int position;
  float value;
  
  public matrixElement(int pos, float val)
  {
    position = pos;
    value = val;
  }
  
  public int getPos()
  {
    return position;
  }
  
  public float getValue()
  {
    return value;
  }
  
  public void toggleValue()
  {
    if(value<4)
    value+=.5;
    else
    value = -4;
  }
}