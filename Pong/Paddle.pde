class Paddle
{
  PVector pos;  
  
  Paddle(float x, float y)
  {
    pos = new PVector(x, y);
  }
  
  void update()
  {    
    pushMatrix();
    noStroke();
    fill(255);
    translate(this.pos.x, this.pos.y);
    rect(-PADDLE_WIDTH, - PADDLE_HEIGHT, PADDLE_WIDTH, PADDLE_HEIGHT);
    popMatrix();
  }
  
  void move(int dir)
  {
    this.pos.y += dir * PADDLE_SPEED;
    this.pos.y = constrain(this.pos.y, PADDLE_HEIGHT, height);
  }
}