Arm a, b;

void setup()
{
  size(500, 500);
  
  a = new Arm(new PVector(width / 2, height / 2), random(0, PI), random(0, PI * .1), 0, random(.995, .99995), random(.0005, .0009));
  b = new Arm(new PVector(width / 2, height / 10), random(0, PI), 0, 0, random(.995, .99995), random(.0005, .009));
}

void draw()
{
  background(0, 1);
  
   a.show();
   //a.acc+=b.acc;
   b.anchor(new PVector(sin(-a.pos + PI) * 100 + a.anchor.x, cos(-a.pos + PI) * 100 + a.anchor.y));
   b.show();
  
  //translate(anchor.x, anchor.y);
  //rotate(pos - HALF_PI);
  //line(0, 0,100, 0);
  ////arc(0,0,100, 100, 0, PI);
  //acc = sin(pos) * .008;
  //vel += acc;
  //vel *= .99;
  //pos += vel;
}