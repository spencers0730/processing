float waveSpacing = 100;
float minHeight = 20;
float maxHeight = 30;
float period = 8;
float waveStart = 1;
float waveStep = 5;
float waveHeight = 20;
float curveHeight = 10;
float mutation = .01;

void setup()
{
  size(1920, 1080);  
}

void draw()
{
  for(int i = 0; i < height; i++)
  {
   
    for(int j = 0; j < width; j++)
    {
      int r = floor(random(0, 255));
      color c;
      if(abs((i + waveStart + curveHeight * sin(period * TWO_PI * j / width)) % waveSpacing) <= waveHeight) c = color(2*r, 2*r, 2*r);
      else c = color(r, r, r);
      set(j, i, c);
    }

  }
  
  curveHeight *= random(1 - mutation, 1 + mutation); 
  period *= random(-mutation, mutation); 
  waveHeight *= random(1 - mutation, 1 + mutation);
  waveStart += waveStep;
  waveStart %= height;
  
}