final float BALL_SPEED = 10;
final float PADDLE_SPEED = 10;

final float BALL_RAD = 10;

final float PADDLE_WIDTH = 30;
final float PADDLE_HEIGHT = 3 * PADDLE_WIDTH;

final float PADDING = 2 * PADDLE_WIDTH;

PFont arial;

Ball ball;
Paddle left;
Paddle right;

int leftScore;
int rightScore;

int leftSpeed;
int rightSpeed;

void setup()
{
  size(1000, 1000);
  
  ball = new Ball(BALL_RAD);
  left = new Paddle(PADDING, height * 0.5);
  right = new Paddle(width - PADDING, height * 0.5);
  
  leftScore = 0;
  rightScore = 0;
  
  leftSpeed = 0;
  rightSpeed = 0;
}

void draw()
{
  background(0);
  pushMatrix();
  noStroke();
  fill(255,100);
  rect(0, 0, width, PADDING);
  rect(0, height - PADDING, width, height - PADDING);
  for(int i = 0; i < 30; i++)
  {
    rect((width - PADDING * 0.5) * 0.5, height / 30. * i, PADDING * 0.5, PADDING * 0.5);
  }
  textSize(40);
  translate(width * 0.5, 3 * PADDING);
  text(leftScore, -30 - (40 + textWidth(leftScore + "")) * 0.5, 0);
  text(rightScore, 30 + textWidth(rightScore + "") * 0.5, 0);
  popMatrix();
  
  
  ball.update();
  
  left.move(leftSpeed);
  right.move(rightSpeed);

  left.update();
  right.update();
  
  ball.collide(left);
  ball.collide(right);
}

void keyPressed()
{
  switch(key)
  {
    case 'w':
    leftSpeed = -1;
    break;
    case 's':
    leftSpeed = 1;
    break;
    case CODED:
    switch(keyCode)
    {
      case UP:
      rightSpeed = -1;
      break;
      case DOWN:
      rightSpeed = 1;
      break;
    }
    break;
  }
}

void keyReleased()
{
  switch(key)
  {
    case 'w':
    case 's':
    leftSpeed = 0;
    break;
    case CODED:
    switch(keyCode)
    {
      case UP:
      case DOWN:
      rightSpeed = 0;
      break;
    }
    break;
  }
}