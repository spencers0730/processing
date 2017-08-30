class Arm
{
  PVector anchor;
  
  float pos;
  float vel;
  float acc;
  
  float damp;
  float weight;
  
  Arm(PVector anchor, float pos, float vel, float acc, float damp, float weight)
  {
    this.anchor = anchor;
    this.pos = pos;
    this.vel = vel;
    this.acc = acc; 
    this.damp = damp;
    this.weight = weight;
  }
  
  void anchor(PVector next)
  {
    PVector position = new PVector(sin(-this.pos + PI) * 100 + this.anchor.x, cos(-this.pos + PI) * 100 + this.anchor.y);
    PVector diff = next.copy().sub(position);
    ellipse(position.x, position.y, 5, 5);
    this.pos = diff.heading() - HALF_PI;
    this.anchor = next;
  }
  
  void show()
  {
    this.acc = sin(this.pos) * this.weight;
    this.vel += this.acc;
    this.vel *= this.damp;
    this.pos += this.vel;
    
    pushMatrix();
    translate(this.anchor.x, this.anchor.y);
    stroke(255);
    strokeWeight(2);
    rotate(this.pos);
    line(0,0,0, -100);
    popMatrix();
  }
  
}