class Square
{
  long size;
  long corner;
  long x, y;
  
  float start, end;
  
  long cornerX, cornerY;
  
  Square(long size, int corner, long x, long y)
  {
    this.size = size;
    this.corner = corner;
    this.x = x;
    this.y = y;
    this.start = -(corner + 1) * HALF_PI;
    this.end = -(corner) * HALF_PI; 
    
    this.cornerX = this.x;
    this.cornerY = this.y;
    
    switch(corner)
    {
      case 0:
      this.cornerY -= this.size;
      break;
      case 1:
      this.cornerY -= this.size;
      this.cornerX -= this.size;
      break;
      case 2:
      this.cornerX -= this.size;
    }
    
  }
  
  void update()
  {
    
    if(this.size * scale > 5 && (this.x * scale >= -width/2 && this.x * scale <= width/2 && this.y * scale >= -height/2 && this.y * scale <= height/2))
    {
      pushMatrix();
      noFill();
      if(rainbow)
        stroke(map(squares.indexOf(this), 0, squares.size() - 1, 0, 255), 255, 255);
      else
        stroke(255);
      strokeWeight(1);
      translate(width / 2, height / 2);
      if(rect)
        rect(scale * this.cornerX, scale * this.cornerY, scale * this.size, scale * this.size);
      if(num)
      {
        textSize(this.size * scale * TEXT_SCALE);
        String s = (this.size) + "";
        text(s, (this.cornerX + this.size * 0.5) * scale - textWidth(s) * 0.5, (this.cornerY + this.size * 0.5) * scale);
      }
      arc(this.x * scale, this.y * scale, this.size * 2 * scale, this.size * 2 * scale, this.start, this.end);
      popMatrix();
    }
  }
  
  
}