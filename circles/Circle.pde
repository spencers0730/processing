class Circle
{
  float x; 
  float y;
  
  float vel;
  float vAng;
  float bounce;
  
  color c;
  float rad;
  
   public Circle(float x, float y, float vel, float vAng, float rad, float bounce, color c)
   {
     this.x = x;
     this.y = y;
     this.vel = vel;
     this.vAng = vAng;
     this.rad = rad;
     this.bounce = bounce;
     this.c = c;
   }
   
   void update()
   {
     float xVel = vel * cos(vAng) + grav * cos(gAng);
     float yVel = vel * sin(vAng) + grav * sin(gAng);
     
     if(this.x <= this.rad || this.x >= width - this.rad)
     {
       xVel *= -this.bounce;
     }
     if(this.y <= this.rad || this.y >= height - this.rad)
     {
       yVel *= -this.bounce;
     }
     
     if(xVel == 0)
     {
       this.vAng = abs(yVel) / yVel * PI / 2;
     }
     else 
     {
       this.vAng = atan(yVel / xVel);
       if(xVel < 0)
       {
         this.vAng += PI;
       }
     }
     
     this.x += xVel;
     this.y += yVel;
     
     this.x = constrain(this.x, this.rad, width - this.rad);
     this.y = constrain(this.y, this.rad, height - this.rad);
          
     this.vel = sqrt(sq(xVel) + sq(yVel));
     
     this.show();
   }
   
   void collide(Circle other)
   {
     float distance = sqrt(sq(abs(this.x-other.x)) + sq(abs(this.y - other.y)));
     float min = this.rad + other.rad;
     if(distance <= min)
     {
     
     }
   
   }
   
   
   void show()
   {
     pushMatrix();
     noStroke();
     fill(this.c);
     translate(this.x, this.y);
     ellipse(0, 0, this.rad * 2, this.rad * 2);
     //stroke(255);
     //strokeWeight(2);
     //rotate(this.vAng);
     //line(0,0, map(this.vel, 0, 10, 10, 100), 0);
     popMatrix();  
   }
 
}