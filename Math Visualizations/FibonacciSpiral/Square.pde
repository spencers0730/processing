class Square
{
  BigInteger size;
  int corner;
  BigInteger x, y;
  
  float start, end;
  
  BigInteger cornerX, cornerY;
  
  Square(BigInteger size, int corner, BigInteger x, BigInteger y)
  {
    this.size = new BigInteger(size.toString());
    this.corner = corner;
    this.x = new BigInteger(x.toString());
    this.y = new BigInteger(y.toString());
    this.start = -(corner + 1) * HALF_PI;
    this.end = -(corner) * HALF_PI; 
    
    this.cornerX = new BigInteger(this.x.toString());
    this.cornerY = new BigInteger(this.y.toString());
    
    switch(corner)
    {
      case 0:
      this.cornerY =  this.cornerY.subtract(this.size);
      break;
      case 1:
      this.cornerY =  this.cornerY.subtract(this.size);
      this.cornerX =  this.cornerX.subtract(this.size);
      break;
      case 2:
      this.cornerX =  this.cornerX.subtract(this.size);
      break;
    }
    
  }
  
  void update()
  {
    
    if(this.size.floatValue() * scale > 5 && (this.x.floatValue() * scale >= -width/2 && this.x.floatValue() * scale <= width/2 && this.y.floatValue() * scale >= -height/2 && this.y.floatValue() * scale <= height/2))
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
        rect(scale * this.cornerX.floatValue(), scale * this.cornerY.floatValue(), scale * this.size.floatValue(), scale * this.size.floatValue());
      if(num)
      {
        textSize(this.size.floatValue() * scale * TEXT_SCALE);
        String s = (this.size) + "";
        text(s, (this.cornerX.floatValue() + this.size.floatValue() * 0.5) * scale - textWidth(s) * 0.5, (this.cornerY.floatValue() + this.size.floatValue() * 0.5) * scale);
      }
      arc(this.x.floatValue() * scale, this.y.floatValue() * scale, this.size.floatValue() * 2 * scale, this.size.floatValue() * 2 * scale, this.start, this.end);
      popMatrix();
    }
  }
  
  
}
