class bubble
{
  float x, y, r;
  int level;
  color c;
    
  bubble(float x, float y, int level, PImage img)
  {
    this.x = x;
    this.y = y;
    this.r = MAXRAD * pow(2, -level);
    this.level = level;
    this.c = getColor(this.x, this.y, img);
  }
  
  void setCol(color c)
  {
    this.c = c;
  }
  
 void show()
 {
   pushMatrix();
   noStroke();
   fill(this.c);
   ellipse(this.x, this.y, this.r*2, this.r*2);
   popMatrix();
 }
 
 boolean delete(float x, float y)
 {
   return (dist(this.x, this.y, x, y) <= this.r) && this.large();
 }
 
 boolean large()
 {
   return this.r >= MINRAD;
 }
}