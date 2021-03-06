ArrayList<Particle> rockets;
ArrayList<Particle> debris;

final float MINVELR = 7;
final float MAXVELR = 15;

final float MINRADR = 4;
final float MAXRADR = 8;

final float MINBOUNCER = .7;
final float MAXBOUNCER = .85;

final float MINANGR = 4 * PI / 3;
final float MAXANGR = 5 * PI / 3;

final int MINLIFER = 80;
final int MAXLIFER = 140;

final float MINVELD = 0;
final float MAXVELD = 9;

final float MINRADD = 1;
final float MAXRADD = 1.5;

final float MINBOUNCED = .7;
final float MAXBOUNCED = .85;

final int MINLIFED = 40;
final int MAXLIFED = 80;

final int MINPARTICLES = 20;
final int MAXPARTICLES = 100;

final float GRAVANGRAVSTEP = .01;
final float GRAVSTEP = .01;

final float DENSITY = 1;

PVector grav;

boolean update = true;
boolean lines = false;

int startRockets = 10;

void setup()
{
  fullScreen();
  rockets = new ArrayList<Particle>();
  debris = new ArrayList<Particle>();
  
  grav = new PVector(0, 0.1);
  
  addRocket(startRockets);
  
  background(51);
}

void draw()
{
  //background(50, 5);
  color c = color(50, 50, 50, 64);
  fill(c);
  noStroke();
  rect(0, 0, width, height);
  int addRockets = 0;
  
  for(int i = 0; i < rockets.size(); i++)
  {
    rockets.get(i).update();
    if(rockets.get(i).count <= 0)
    {
      addDebris(rockets.get(i));
      rockets.remove(rockets.get(i));
      i--;
      addRockets++;
    }
  }
   
  for(int i = 0; i < debris.size(); i++)
  {
    debris.get(i).update();
    if(debris.get(i).count <= 0)
    {
      debris.remove(debris.get(i));
      i--;
    }
  }
  
//addRocket(constrain(addRockets, 0, startRockets - rockets.size()));
addRocket(constrain(addRockets, 0, rockets.size() - addRockets));
  
  if(mousePressed)
  {
    addRocket(1, new PVector(mouseX, height-MAXRADR));
  }
}

void keyPressed()
{
  if(keyCode == ' ') update = !update;
  if(keyCode == TAB) lines = !lines;
  if(key == '0') grav.rotate(PI);
  if(key == CODED)
  {
    if(keyCode == LEFT) grav.rotate(GRAVANGRAVSTEP);
    else if(keyCode == RIGHT) grav.rotate(-GRAVANGRAVSTEP);
    if(keyCode == UP) grav.setMag(grav.mag() + GRAVSTEP);
    else if(keyCode == DOWN) grav.setMag(grav.mag() - GRAVSTEP);
  }
}
void addRocket(int num,  PVector pos)
{
  for(int i = 0; i < num; i++)
  {
    PVector vel;
    
    float velMag = random(MINVELR, MAXVELR);
    float vAng = random(MINANGR, MAXANGR);
    vel = new PVector(velMag * cos(vAng), velMag * sin(vAng));
    
    float rad = random(MINRADR, MAXRADR);
    float bounce = random(MINBOUNCER, MAXBOUNCER);
    int count = (int) random(MINLIFER, MAXLIFER);

    int r = (int) random(255);
    int g = (int) random(255);
    int b = (int) random(255);

    color col = color(r, g, b);
    
    Particle p = new Particle(pos, vel, rad, bounce, count, col);
    
    rockets.add(p);
  }
}

void addRocket(int num)
{
  for(int i = 0; i < num; i++)
  {
    addRocket(1, new PVector(random(width), height));
  }
}

void addDebris(Particle parent)
{
    for(float i = parent.mass; i > 0; i += 0)
    {
      PVector pos = new PVector(parent.pos.x, parent.pos.y);
      PVector vel = PVector.random2D().setMag(random(MINVELD, MAXVELD)).add(parent.vel);
      float rad = random(MINRADD, MAXRADD);
      float mass = sq(rad) * DENSITY;
      float bounce = random(MINBOUNCED, MAXBOUNCED);
      int count = (int) random(MINLIFED, MAXLIFED);
      color col = parent.col;
      
      Particle p = new Particle(pos, vel, rad, bounce, count, col);
      
      debris.add(p);
      
      i -= mass;
    }
}