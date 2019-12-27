 //<>//
/**
 AP Calculus BC Project 2016-17
 Author: Spencer Schoenberg
 */

//Quality Constants
static final float MIN_QUAL = 1;
static final float MAX_QUAL = 3;

static final float MIN_SIZE = 1;
static final float MAX_SIZE = 3;

static final float MIN_N = 50;
static final float MAX_N = 250;

//text constants
static final String instruct = "Click/Hold: Draw set. Quality: 1 Low, 2 Med, 3 High. Switch Mode: M. Color Mode: C";
static final String Julia = "Julia set of ";
static final String Mandelbrot = "Mandelbrot set";

static final int textSize = 30;

//Initially medium quality
float quality = (MIN_QUAL + MAX_QUAL) * 0.5;

//Quality variables
float size;
int maxN;

//Coordinates of picture
float centerX, centerY;
float sizeX, sizeY;
float minX, minY, maxX, maxY;

//Julia Set Arguments
float ca, cb;

//Modes
boolean update;
boolean zoom;
boolean mandelbrot;
boolean colorMode;

void setup()
{
  //Quick drawing 
  fullScreen(P2D);  
  //For colored mode
  colorMode(HSB, 255);

  //Initial modes
  update = true;
  zoom = false;
  colorMode = false;
  mandelbrot = false;
}

void draw()
{  
  if (!zoom)
  {
    //sets quality & mode
    setMode(mandelbrot);
    setQual(quality);
  }

  //updates coordinates
  minX = centerX - sizeX;
  minY = centerY - sizeY;
  maxX = centerX + sizeX;
  maxY = centerY + sizeY;

  //when you press mouse or key
  if (mousePressed || update)
  {
    //don't update until event
    update = false;

    //initial arguments of Julia set based off mouse pos
    if (!mandelbrot && !zoom)
    {  
      ca = map(mouseX, 0, width, -1, 1);
      cb = map(mouseY, 0, height, 1, -1);
    }

    //draws specific Julia set / Mandelbrot Set 
    for (int y = 0; y < height; y+=size)
      for (int x = 0; x < width; x+=size)
      {
        //converts mouse location to coordinates
        float actX = map(x, 0, width, minX, maxX);
        float actY = map(y, 0, height, maxY, minY);

        //determines if certain coordinate is bound or calculates count to escape
        int count = calc(actX, actY);

        //for coloring
        int hu = ceil(map(sqrt(count), 0, sqrt(maxN), 0, 255));
        color col;

        //coloring black if bound or color if not
        if (colorMode) //HSB
        {
          //bounded is black
          if (hu >= 255) 
          {
            col = color(0);
          }
          //otherwise draw hu
          else col = color((170+hu)%255, 200, 255);
        } else //coloring B & W
        {
          col = color(hu);
        }

        pushMatrix();
        fill(col);
        noStroke();
        rect(x, y, size, size);
        popMatrix();
      }
  }
  
  //if(!mandelbrot && !zoom && quality == MAX_QUAL)
  //  save("JS" + nf(ca, 1, 3) + "," + nf(cb, 1, 3) + ".png");

  texts();
}

void texts()
{
  //text and instructions
  pushMatrix();
  textSize(textSize);
  fill(255);
  String coords;

  if (mandelbrot)
  {
    coords = Mandelbrot;
  } else
  {
    coords = Julia;
    coords += "(" + nf(ca, 1, 4) + ", " + nf(cb, 1, 4) + ")";
  }

  text(coords, width / 2 - textWidth(coords) * .5, textSize); 
  String qual = "Quality: " + nf(quality, 1, 0);
  text(qual, width / 2 - textWidth(qual) * .5, textSize * 2);
  text(instruct, width / 2 - textWidth(instruct) * .5, height - textSize);
  popMatrix();
}

void reset()
{
  background(0);
  update = true;
  zoom = false;
}

void setMode(boolean m)
{
  if (m)
  {
    quality = MAX_QUAL;
    centerX = -.75;
    sizeX = 2;
    sizeY = 4./3.;
  } else
  {
    centerX = 0;
    sizeX = 2.5;
    sizeY = 2;
  }
}

void setQual(float q)
{
  size = ceil(map(q, MIN_QUAL, MAX_QUAL, MAX_SIZE, MIN_SIZE));
  maxN = ceil(map(q, MIN_QUAL, MAX_QUAL, MIN_N, MAX_N));
}


void keyPressed()
{

  switch(key)
  {
  case '1':
    quality = MIN_QUAL;
    break;
  case '2':
    quality = (MIN_QUAL + MAX_QUAL) * 0.5;
    break;
  case '3':
    quality = MAX_QUAL;
    break;
  case 'm':
    mandelbrot = !mandelbrot;
    break;
  case 'c':
    colorMode = !colorMode;
    break;
  }
  reset();
}

int calc(float a, float b)
{
  int n = 0;

  if (mandelbrot)
  {
    ca = a;
    cb = b;
  }

  while (n < maxN)
  {
    float aa = a * a - b * b;
    float bb = 2 * a * b;

    a = aa + ca;
    b = bb + cb;

    if (abs(a) + abs(b) > 4)
      break;
    n++;
  }

  return n;
}

void mouseWheel(MouseEvent e)
{
  float f = e.getCount();

  if (f != 0)
  {
    zoom = true;
    sizeX *= pow(1.01, f);
    sizeY *= pow(1.01, f);
  }
}
