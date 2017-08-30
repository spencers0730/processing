ArrayList<Circle> circles;
color[] cols;

final float MINVEL = 5;
final float MAXVEL = 5;

final float MINRAD = 1;
final float MAXRAD = 2;

final float MINBOUNCE = .75;
final float MAXBOUNCE = .85;

final float gAngStep = .01;
final float gStep = .01;

float grav = 0;
float gAng = PI / 2;
int cNum = 6;

boolean update = true;

void setup()
{
  circles = new ArrayList<Circle>();
  //cols = new color[cNum];
  //for(int i = 0; i < cNum; i++)
  //{
  //  int r = (int) random(255);
  //  int g = (int) random(255);
  //  int b = (int) random(255);
    
  //  cols[i] = color(r, g, b);
  //}
  
  fullScreen();
  noStroke();
  
  addCircles(1000, width / 2, height / 2);
  
}

void draw()
{
  if(update)
  {
    if(mousePressed) addCircles(100, mouseX, mouseY);
    background(51);
    for(Circle c : circles)
    {
      c.update();
    }
    //gAng += gAngStep;
    text();
    grav = round(grav / .01) * .01;
  }
}

void addCircles(int num, float x, float y)
{
  for(int i = 0; i < num; i++)
  {
    float vel = random(MINVEL, MAXVEL);
    float vAng = random(TWO_PI);
    float rad = random(MINRAD, MAXRAD);
    float bounce = random(MINBOUNCE, MAXBOUNCE);
    
    int r = (int) random(255);
    int g = (int) random(255);
    int b = (int) random(255);
    
    color col = color(r, g, b);
    //color col = cols[(int)random(cols.length)];
    
    circles.add(new Circle(x, y, vel, vAng, rad, bounce, col));
  }
}

void addCircles(int num)
{
  for(int i = 0; i < num; i++)
  {
    float x = random(width);
    float y = random(height);
    addCircles(1, x, y);
  }
}

void text()
{
  pushMatrix();
  fill(255);
  stroke(255);
  textSize(24);
  text("Balls: " + circles.size(), 0, 24);
  translate(width / 2, height / 2);
  String mid = grav + "";
  text(mid, -6 * mid.length(), -24);
  rotate(gAng);
  strokeWeight(6);
  line(0, 0, 300, 0);
  popMatrix();

}

void keyPressed()
{
  if(keyCode == ' ') update = !update;
  if(key == CODED)
  {
    if(keyCode == LEFT) gAng += gAngStep;
    else if(keyCode == RIGHT) gAng -= gAngStep;
    if(keyCode == UP) grav -= gStep;
    else if(keyCode == DOWN) grav += gStep;
  }
}