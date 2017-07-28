int num; 
int direction;
int turnDistance;
int timesTurned;
int completedSinceTurn;

float x, y;
float size;

int began;

void setup()
{
  began = millis();
  
  fullScreen();
  background(0);
  noStroke();
  textSize(24);
    
  size = .5;
  
  num = 1;
  direction = 0;
  turnDistance = 1;
  timesTurned = 0;
  completedSinceTurn = 0;
  
  x = width / 2;
  y = height / 2;
  
}

void draw()
{
  int now = millis();
  //float time = 1000. / frameRate;
  float time = 1000. / 30.;
  while(millis() - now < time)
  //for(int i =0; i < 14737922; i++)
  {
    if((x < width && x > 0) || (y < height && y > 0))
    {
      fill(0);

      if(isPrime(num))
        fill(255);

      rect(x, y, size, size);
      
      switch(direction)
      {
        case 0:
          x+=size;
          break;
        case 1:
          y-=size;
          break;
        case 2:
          x-=size;
          break;
        case 3:
          y+=size;
          break;
      }

      num++;
      completedSinceTurn++;
      
      if(completedSinceTurn == turnDistance) //turn
      {
        completedSinceTurn = 0;
        timesTurned++;
        direction = (direction + 1) % 4;
      }
      if(timesTurned == 2)
      {
        timesTurned = 0;
        turnDistance++;
      }
    }
    else
    {
      time = (millis() - began) / 1000;
      fill(255);
      translate(width / 2, height / 2);
      text("Done up to " + num + ".", 0, 0);
      text("That took " + time + " seconds.", 0, 24);
      noLoop();
      break;
    }
  }
}

boolean isPrime(int n)
{
  if(n <= 1) return false;
  if(n == 2) return true;
  int s = ceil(sqrt(n));
  for(int i = 2; i <= s; i++)
  {
    if(n % i == 0) return false;
  }
  return true;
}