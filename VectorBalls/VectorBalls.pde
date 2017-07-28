ArrayList<Particle> balls = new ArrayList<Particle>();

final float MINVEL = 0;
final float MAXVEL = 15;

final float MINBOUNCE = .75;
final float MAXBOUNCE = .78;

final float MINRAD = 5;
final float MAXRAD = 15;

final float GRAVANGSTEP = TWO_PI / 365;
final float GRAVSTEP = .01;

final float MINGRAV = 0.0001;
final float MAXGRAV = 1;
final float INITGRAV = .3;

PVector grav;

boolean update = true;
boolean lines = true;

final String inst = "SPACE: PAUSE, TAB: SHOW VEL LINES, UP/DOWN: +-G, LEFT/RIGHT: +-ANGLE, CLICK FOR BALLS";

void setup()
{
  fullScreen();
  colorMode(HSB);
  background(51);
  
  grav = new PVector(0, INITGRAV);
  
  addCircles(10, width / 2, height / 2);
}

void draw()
{
  if(update)
  {
    background(51);
    texts(); 

     for(Particle p : balls)
     {
       p.update();
     }
  } 
}

void keyPressed()
{
  if(keyCode == ' ') update = !update;
  
  if(update)
  {
    if(keyCode == TAB) lines = !lines;
    if(key == '0') grav.rotate(PI);
    if(key == '1') background(51);
    if(update)
    {
      if(key == CODED)
      {
        if(keyCode == UP) grav.setMag(grav.mag() + GRAVSTEP);
        else if(keyCode == DOWN) grav.setMag(grav.mag() - GRAVSTEP);
        else if(keyCode == LEFT) grav.rotate(GRAVANGSTEP);
        else if(keyCode == RIGHT) grav.rotate(-GRAVANGSTEP);
        
        grav.limit(MAXGRAV);
      }
    }
  }
}

void mousePressed()
{
  addCircles(5, constrain(mouseX, MAXRAD, width - MAXRAD), constrain(mouseY, MAXRAD, width - MAXRAD));
}

void texts()
{
  pushMatrix();
  fill(200);
  stroke(200);
  textSize(24);
  text("Balls: " + balls.size(), 12, 24);
  translate(width / 2, height / 2);
  pushMatrix();  
  String text = grav.mag() + "";
  text(text, -6 * text.length(), -24);
  rotate(grav.heading());
  strokeWeight(7);
  line(0, 0, 200, 0);
  popMatrix();
  translate(0, height / 2);
  text(inst, -6 * inst.length(), -24);
  popMatrix();
}

void addCircles(int num, float x, float y)
{
   for(int i = 0; i < num; i++)
   {
     PVector pos = new PVector(x, y);
     PVector vel = PVector.random2D();
     float bounce = random(MINBOUNCE, MAXBOUNCE);
     float rad = random(MINRAD, MAXRAD);
     
     int r = (int) random(255);
     //int g = (int) random(255);
     //int b = (int) random(255);    
     
     color col = color(r, 255, 255, 100);
     
     balls.add(new Particle(pos, vel, rad, bounce, col));
   }
}

void addCircles(int num)
{
  for(int i = 0; i < num; i++) addCircles(1, random(MAXRAD, width - MAXRAD), random(MAXRAD, height - MAXRAD));
}