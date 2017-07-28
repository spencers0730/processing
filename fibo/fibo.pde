c final float EASING = .8;
final float INCREASE = 1.04;
final float TEXT_SCALE = .1;
final String INSTRUCT = "Z: Zoom C: Color S: Squares N: Numbers H: Help";

float scale;

int dir;
long centerX;
long centerY;

long fib1;
long fib2;

ArrayList<Square> squares;

boolean rainbow;
boolean ease;
boolean rect;
boolean num;
boolean help;

void settings()
{
  fullScreen();
}

void setup()
{
  colorMode(HSB);
  squares = new ArrayList<Square>();
  
  rainbow = true;
  ease = true;
  rect = true;
  num = true;
  help = true;
  
  scale = 10;
  dir = 0;

  fib1 = 0;
  fib2 = 1;

}

void draw()
{
  background(0);
  
  if(ease)
    scale = scale * (EASING) + .2 * (10000. / fib2) * (1 - EASING);
    
  for (Square s : squares)
  {
    s.update();
  }
  
  if(help)
  {
    pushMatrix();
    translate(width / 2, height);
    textSize(30);
    fill(255);
    noStroke();
    text(INSTRUCT, -textWidth(INSTRUCT) * 0.5, -30);
    popMatrix();
  }
}

void keyPressed()
{
  switch(key)
  {
    case 'c':
    rainbow = !rainbow;
    break;
    case 'z':
    ease = !ease;
    break;
    case 's':
    rect = !rect;
    break;
    case 'n':
    num = !num;
    break;
    case 'h':
    help = !help;
    break;
  }
}

void mousePressed()
{
  step();
}

void step()
{  
  squares.add(new Square(fib2, dir, centerX, centerY));
  
  long addFib = fib1;
  
  switch(dir)
  {
    case 0: //right to left
    centerY += addFib;
    break;
    case 1: //up to down
    centerX += addFib;
    break;
    case 2: //left to right
    centerY -= addFib;
    break;
    case 3: //down to up
    centerX -= addFib;
    break;
  }
  
  dir++;
  dir %= 4;
  
  long fibTemp = fib2;
  fib2 += fib1;
  fib1 = fibTemp;
  
}

void mouseWheel(MouseEvent e)
{
  float scroll = e.getCount();
  
  scale *= pow(INCREASE, -scroll);
  
}