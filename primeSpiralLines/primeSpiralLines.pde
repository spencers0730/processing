int num; 
int direction;
int turnDistance;
int timesTurned;
int completedSinceTurn;

float x, y;
float size;

int began;

float m = 0;

void setup()
{
  began = millis();

  fullScreen();
  colorMode(HSB);
  background(0);
  noStroke();
  textSize(24);

  size = 2;

  reset();
}

void draw()
{
  int now = millis();
  float time = 1000. / 60.;
  while (millis() - now < time)
  {
    if ((x < width && x > 0) || (y < height && y > 0))
    {
      if (m == 0)
      {

        if (isPrime(num)) {
          pushMatrix();
          noStroke();
          fill(255);
          translate(x, y);
          rect(0, 0, size, size);
          //String number = num + "";
          //float numSize = size / (2 * number.length());
          //textSize(numSize);
          //fill(0);
          //text(number, x + size * .5 + .5 * numSize, y + .5 * numSize);
          popMatrix();
        }
      }

      float oldX = x;
      float oldY = y;

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

      stroke(64);
      //stroke(128 + 128* sin(num / (10000 + 10000 * sin(m))), 255, 255);
      line(oldX + size / 2, oldY + size / 2, x +  size / 2, y + size / 2);

      num++;
      completedSinceTurn++;

      if (completedSinceTurn == turnDistance) //turn
      {
        completedSinceTurn = 0;
        timesTurned++;
        direction = (direction + 1) % 4;
      }
      if (timesTurned == 2)
      {
        timesTurned = 0;
        turnDistance++;
      }
    } else
    {
      //time = (millis() - began) / 1000;
      //fill(255);
      //translate(width / 2, height / 2);
      ////text("Done up to " + num + ".", 0, 0);
      ////text("That took " + time + " seconds.", 0, 24);
      //noLoop();
      //break;
      reset();
      m += .2;
    }
  }
}

void reset()
{
  num = 1;
  direction = 0;
  turnDistance = 1;
  timesTurned = 0;
  completedSinceTurn = 0;

  x = width / 2;
  y = height / 2;
}

boolean isPrime(int n)
{
  if (n <= 1) return false;
  if (n == 2) return true;
  int s = ceil(sqrt(n));
  for (int i = 2; i <= s; i++)
  {
    if (n % i == 0) return false;
  }
  return true;
}