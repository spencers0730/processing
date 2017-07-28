class Ball
{
  float r;
  
  PVector pos;
  PVector vel;
  
  Ball(float r)
  {
    this.r = r;
    this.reset();
  }
  
  void reset()
  {
    pos = new PVector(width * 0.5, height * 0.5);
    vel = PVector.random2D().mult(BALL_SPEED);
  }
  
  void update()
  {
    pos.add(vel);
    
    //left wall
    if(this.pos.x - this.r <= 0)
    {
      rightScore++;
      this.reset();
    }
    //right wall
    if(this.pos.x + this.r >= width)
    {
      leftScore++;
      this.reset();
    }
    //top and bottom
    if(this.pos.y - this.r <= 2 * PADDING || this.pos.y + this.r >= height - 2 * PADDING)
    {
      this.vel.y *= -1;
    }
    
    //this.pos.x = constrain(this.pos.x, 0, width);
    this.pos.y = constrain(this.pos.y, this.r + 2 * PADDING, height - this.r - 2 * PADDING);
    
    pushMatrix();
    noStroke();
    fill(255);
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2);
    popMatrix();

}
  
  void collide(Paddle p)
  {
    float left = this.pos.x - this.r;
    float right = this.pos.x + this.r;
    float top = this.pos.y - this.r; 
    float bot = this.pos.y + this.r;
    
    if((p.pos.x + PADDLE_WIDTH < right && p.pos.x + PADDLE_WIDTH > left && p.pos.y < top && p.pos.y + PADDLE_HEIGHT > bot))// ||(p.pos.x - PADDLE_WIDTH < right && p.pos.x - PADDLE_WIDTH > left && p.pos.y < top && p.pos.y + PADDLE_HEIGHT > bot))
    {
      this.vel.x *= -1;
    }
    
  }
  
}