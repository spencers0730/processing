ArrayList<Particle> balls = new ArrayList<Particle>();

final float MINVEL = 0;
final float MAXVEL = 0;

final float MINBOUNCE = .8;
final float MAXBOUNCE = .95;

final float MINRAD = 2;
final float MAXRAD = 3;

final float INITGRAV = 1;
final float DENSITY = 10;

final float GRAV = 1;

boolean update = true;
boolean background = true;

boolean collide = true;
boolean lines = false;

boolean stationary = true;

PVector mouseSpeed;

final String inst = "SPACE: PAUSE, TAB: SHOW VEL LINES, 0: STATIONARY MODE, 1: CLEAR, 2: SHOW TRAILS, 3: NO COLLISION MODE, CLICK FOR BALLS";

void setup()
{
  fullScreen();
  colorMode(HSB);
  ellipseMode(CENTER);
  background(51);
   
  addCircles(1, width / 2, height / 2);
}

void draw()
{
  if(update)
  {
    if(background) background(51);
   
    
   
    
    
    texts(); 
    
     for(int i = 0; i < balls.size(); i++)
     {
       balls.get(i).update();
       for(int j = i + 1; j < balls.size(); j++)
       {
         balls.get(i).gravitate(balls.get(j));
        
         if(collide)
         {
           if(balls.get(i).collide(balls.get(j)))
           {
              j--;  
           }
        }
       }
     }
     
  } 
}

void keyPressed()
{
  if(keyCode == ' ') update = !update;
  
  if(update)
  {
    if(keyCode == TAB) lines = !lines;
    if(key == '0') stationary = !stationary;
    if(key == '1') 
    {
      balls.clear();
      background(51);
    }
    if(key == '2') background = !background;
    if(key == '3') collide = !collide;
  }
}

void mousePressed()
{
  if(update)
  {
    if(mouseButton == RIGHT)
    {
      stationary = true;
    }
    
    addCircles(1, constrain(mouseX, MAXRAD, width - MAXRAD), constrain(mouseY, MAXRAD, width - MAXRAD));
  };
}

void texts()
{
  pushMatrix();
  fill(200);
  noStroke();
  textSize(20);
  textAlign(CENTER);
  translate(width / 2, 0);
  
  String spaces = "      ";
  String text = "BALLS: " + balls.size() + spaces + "STATIONARY: " + stationary + 
                "\nCOLLIDE: " + collide + spaces + "DRAW LINES: " + lines +
                "\nDRAW TRAILS: " + !background + spaces + "UPDATE: " + update;
  text(text, 0, 20);
  translate(0, height);
  text(inst, 0, -20);
  popMatrix();
}

void addCircles(int num, float x, float y)
{
   for(int i = 0; i < num; i++)
   {
     PVector pos = new PVector(x, y);
     PVector vel = new PVector(0, 0);//PVector.random2D().mult(random(MINVEL, MAXVEL));
     float bounce = random(MINBOUNCE, MAXBOUNCE);
     float rad = random(MINRAD, MAXRAD);
     if(stationary) rad = MAXRAD * 20;
     else
     {
       PVector add = PVector.random2D().mult(balls.get(0).rad * 2);
       pos = new PVector(width / 2, height / 2).add(add);
       vel = new PVector(sqrt(balls.get(0).mass / (balls.get(0).rad * 2)),0).rotate(add.heading() + PI / 2);
     }
     int r = (int) random(255);
     color col = color(r, 255, 255);
     
     balls.add(new Particle(pos, vel, rad, bounce, false, col));
   }
    if(stationary)
    {
      stationary = false;
    }
}

void addCircles(int num)
{
  for(int i = 0; i < num; i++) addCircles(1, random(MAXRAD, width - MAXRAD), random(MAXRAD, height - MAXRAD));
}