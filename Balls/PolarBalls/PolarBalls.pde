ArrayList<Circle> circles = new ArrayList<Circle>();

final float MINVEL = 0;
final float MAXVEL = 15;

final float MINBOUNCE = .75;
final float MAXBOUNCE = .78;

final float MINRAD = 10;
final float MAXRAD = 50;

final float gAngStep = TWO_PI / 365;
final float gStep = .01;

float grav = 0.5;
float gAng = PI / 2;
boolean update = true;
boolean lines = true;


void setup()
{
  fullScreen();
  
  addCircles(0, width / 2, height / 2);
}

void draw()
{
  if(update)
  {
    if(mousePressed)
    {
      addCircles(1, constrain(mouseX, MAXRAD, width - MAXRAD), constrain(mouseY, MAXRAD, width - MAXRAD));
    }
    color c = color(51, 51, 51);
    noStroke();
    fill(c);
    rect(0,0, width, height);
    //background(51);
         
    for(int i = 0; i < circles.size(); i++)
    {
      circles.get(i).update();
      for(int j = i + 1; j < circles.size(); j++)
      {
        circles.get(i).collide(circles.get(j));
      }
    }
    
    //gAng += gAngStep;
    texts();
  } 
}

void keyPressed()
{
  if(keyCode == ' ') update = !update;
  if(keyCode == TAB) lines = !lines;
  if(update)
  {
    if(key == CODED)
    {
      if(keyCode == UP) grav -= gStep;
      else if(keyCode == DOWN) grav += gStep;
      else if(keyCode == LEFT) gAng += gAngStep;
      else if(keyCode == RIGHT) gAng -= gAngStep;
    }
  }
}

void texts()
{
  pushMatrix();
  fill(200);
  stroke(200);
  textSize(24);
  text("Balls: " + circles.size(), 12, 24);
  pushMatrix();
  translate(width / 2, height / 2);
  String text = grav + "";
  text(text, -6 * text.length(), -24);
  rotate(gAng);
  strokeWeight(7);
  line(0, 0, 200, 0);
  popMatrix();
  translate(width, height);
  text = "SPACE: PAUSE, TAB: SHOW VEL LINES, UP/DOWN: +-G, LEFT/RIGHT: +-ANGLE, CLICK FOR BALLS";
  text(text, -13.2 * text.length(), -24);
  popMatrix();
}

void addCircles(int num, float x, float y)
{
   for(int i = 0; i < num; i++)
   {
     float vel = random(MINVEL, MAXVEL);
     float vAng = random(TWO_PI);
     float bounce = random(MINBOUNCE, MAXBOUNCE);
     float rad = random(MINRAD, MAXRAD);
     
     int r = (int) random(255);
     int g = (int) random(255);
     int b = (int) random(255);    
     
     color col = color(r, g, b);
     
     circles.add(new Circle(x, y, vel, vAng, bounce, rad, col));
   }
}

void addCircles(int num)
{
  for(int i = 0; i < num; i++) addCircles(1, random(MAXRAD, width - MAXRAD), random(MAXRAD, height - MAXRAD));
}