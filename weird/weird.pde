float size;
float t = 0;

void setup()
{
  fullScreen();
  colorMode(HSB);
  noStroke();
}
void draw()
{  
  PVector[] rands = new PVector[3];
  
  for(int i = 0; i < rands.length; i++)
  {
    float randX = random(width);
    float randY = random(height);
    rands[i] = new PVector(randX, randY);
  }
  for(float y = 0; y < height; y+=size)
  {
    for(float x = 0; x < width; x+=size)
    {
      float min = 0;
      for(int i = 0; i < rands.length; i++)
      {
        float d = (sq(abs(x-rands[i].x)) + sq(abs(y-rands[i].y)));
        
        if(i == 0)
          min = d;
        else
        min = min(d, min);
      }
      
      //min = sq(min);
      fill(min % 255, 255, 255);
      rect(x,y,size, size);
    }
  }
}