class City
{
  float x, y;
  
  int index;
  int before = -1;
  int after = -1;
  
  City(float x, float y, int index)
  {
    this.x = x;
    this.y = y;
    this.index = index;
  }
  
  void addBefore(int before)
  {
    this.before = before; 
  }
  
  void addAfter(int after)
  {
    this.after = after;
  }
  
}