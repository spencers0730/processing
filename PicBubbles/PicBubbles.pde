PImage img;
ArrayList<bubble> bubbles;

int MAXNUMIMGS = 6;
float MAXRAD;
float MINRAD = 4;

void setup()
{
  fullScreen();
  MAXRAD = height / 2;;

  bubbles = new ArrayList<bubble>();
  img = load(MAXNUMIMGS);
  
  reset();
}

void draw()
{
   background(255);

   int initSize = bubbles.size();
   for(int i = initSize - 1; i >= 0; i--)
   {
     bubble b = bubbles.get(i);
     b.show();
     if(b.delete(mouseX, mouseY))
     {
       addBubbles(b);
       bubbles.remove(b);
     }
   }
    
   text(frameRate, width / 2, height / 2);

}

void reset()
{
  bubbles.clear();
  bubbles.add(new bubble(width / 2, height / 2, 0, img));
}

void pop()
{
  int initSize = bubbles.size();
  for(int i = initSize-1; i >= 0; i--)
  {
    bubble b = bubbles.get(i);
    if(b.large())
    {
      addBubbles(b);
      bubbles.remove(b);
    }
  }
}

void addBubbles(bubble parent)
{
  float newR = 0.5 * parent.r;
  
  float rightX = parent.x - newR;
  float leftX = parent.x + newR;
  float topY = parent.y - newR;
  float botY = parent.y + newR;
  
  bubble topRight = new bubble(rightX, topY, parent.level + 1, img);
  bubble topLeft = new bubble(leftX, topY, parent.level + 1, img);
  bubble botRight = new bubble(rightX, botY, parent.level + 1, img);
  bubble botLeft = new bubble(leftX, botY, parent.level + 1, img);
  
  bubbles.add(topRight);
  bubbles.add(topLeft);
  bubbles.add(botRight);
  bubbles.add(botLeft);
}

color getColor(float x, float y, PImage image)
{
  return getColor(x, y, 1, 1, image);
}

color getColor(float x, float y, float w, float h, PImage image)
{
  float r = 0;
  float g = 0;
  float b = 0;
  int s = 0;
  
  for(float i = x; i < x + w; i++)
  {
    for(float j = y; j < y + h; j++)
    {
      s++;
      
      color t = image.get(floor(i), floor(j));
      r += red(t);
      g += green(t);
      b += blue(t);
      
    }
  }
  
  r /= s;
  b /= s;
  g /= s;
  return color(r, g, b);
}

PImage load(int n)
{
  int r = 7;//ceil(random(n));
  return loadImage("image" + r + ".jpg");
}

void keyPressed()
{
  if(key == 'p')
  {
    pop();
  }
  else if(key == 'm')
  {
    img = loadImage("image7.JPG");
    reset();
  }
  else
  {
    if(keyCode == ' ')
    {
      reset();
    }
    
    img = load(MAXNUMIMGS);
  }
}