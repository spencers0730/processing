class Circle
{
  float x;
  float y;
  float vel;
  float vAng;
  float rad;
  float m;
  float bounce;
  color col;
  
  Circle(float x, float y, float vel, float vAng, float bounce, float rad, color col)
  {
    this.x = x;
    this.y = y;
    this.vel = vel;
    this.vAng = vAng;
    this.bounce = bounce;
    this.rad = rad;
    this.col = col;
    this.m = rad;
  }
  
  public void update()
  {
    float acc = grav;
    float aAng = gAng;
    
    float xVel = this.vel * cos(this.vAng) + acc * cos(aAng);
    float yVel = this.vel * sin(this.vAng) + acc * sin(aAng);
    
    if(this.x >= width - this.rad || this.x <= this.rad)
    {
      xVel *= -this.bounce;
    }
    if(this.y >= height - this.rad || this.y <= this.rad)
    {
      yVel *= -this.bounce;
    }
    
    this.vAng = calcAng(xVel, yVel) % TWO_PI;
    
    this.vel = sqrt(sq(xVel) + sq(yVel));
    
    this.x += xVel;
    this.y += yVel;
        
    this.x = constrain(this.x, this.rad, width - this.rad);
    this.y = constrain(this.y, this.rad, height - this.rad);
    
    this.show();
  }
  
  void collide(Circle other)
  {
    //float d = dist(this.x, this.y, other.x, other.y);
    ////float d2 = dist(this.x + this.vel * cos(this.vAng), this.y + this.vel * sin(this.vAng), other.x + other.vel * cos(other.vAng), other.y + other.vel * sin(other.vAng));
    //if(d <= this.rad + other.rad)// && d2 <= this.rad + other.rad)
    //{
    //  //float ang = calcAng(this.x - other.x, this.y - other.y);
    //  //this.aAng = ang;
    //  //other.aAng = PI + ang;
      
    //  //float force = map(d, 0, this.rad + other.rad, 5, 1);
    //  //float thisForce = force * this.vel;
    //  //float otherForce = force * other.vel;
      
    //  //this.acc = thisForce / this.rad;
    //  //other.acc = otherForce / other.rad;
      
      
    //  //float xVelThis = -this.vel * cos(this.vAng); 
    //  //float xVelOther = -other.vel * cos(other.vAng);
      
    //  //float yVelThis = -this.vel * sin(this.vAng); 
    //  //float yVelOther = -other.vel * sin(other.vAng);
      
    //  //float moX = xVelThis * this.rad + xVelOther * other.rad;
    //  //float moY = yVelThis * this.rad + yVelOther * other.rad;
      
    //  //xVelThis = (moX / 2) / this.rad;
    //  //xVelOther = (moX / 2) / other.rad;
       
    //  //yVelThis = (moY / 2) / this.rad;
    //  //yVelOther = (moY / 2) / other.rad;
      
    //  //this.vel = sqrt(sq(xVelThis) + sq(yVelThis));
    //  //this.vAng = calcAng(xVelThis, yVelThis);
      
    //  //other.vel = sqrt(sq(xVelOther) + sq(yVelOther));
    //  //other.vAng = calcAng(xVelOther, yVelOther);
    //}
    
    //PVector location =  new PVector(this.x, this.y);
    //PVector location2 = new PVector(other.x, other.y);

    //PVector velocity = new PVector(this.vel * cos(this.vAng), this.vel * sin(this.vAng));
    //PVector velocity2 = new PVector(other.vel * cos(other.vAng), other.vel * sin(other.vAng)); 
    
    //PVector distanceVect = PVector.sub(location2, location);

    //float distanceVectMag = distanceVect.mag();

    //float minDistance = this.m + other.m;

    //if (distanceVectMag < minDistance) {
    //  float distanceCorrection = (minDistance-distanceVectMag)/2.0;
    //  PVector d = distanceVect.copy();
    //  PVector correctionVector = d.normalize().mult(distanceCorrection);
    //  location2.add(correctionVector);
    //  location.sub(correctionVector);

    //  float theta  = distanceVect.heading();

    //  float sine = sin(theta);
    //  float cosine = cos(theta);

    //  PVector[] bTemp = {
    //    new PVector(), new PVector()
    //  };

    //  bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
    //  bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

    //  PVector[] vTemp = {
    //    new PVector(), new PVector()
    //  };

    //  vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
    //  vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
    //  vTemp[1].x  = cosine * velocity2.x + sine * velocity2.y;
    //  vTemp[1].y  = cosine * velocity2.y - sine * velocity2.x;

    //  PVector[] vFinal = {  
    //    new PVector(), new PVector()
    //  };

    //  vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
    //  vFinal[0].y = vTemp[0].y;

    //  vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
    //  vFinal[1].y = vTemp[1].y;

    //  bTemp[0].x += vFinal[0].x;
    //  bTemp[1].x += vFinal[1].x;

    //  PVector[] bFinal = { 
    //    new PVector(), new PVector()
    //  };

    //  bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
    //  bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
    //  bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
    //  bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

    //  location2.x = location.x + bFinal[1].x;
    //  location2.y = location.y + bFinal[1].y;

    //  location.add(bFinal[0]);

    //  velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
    //  velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
    //  velocity2.x = cosine * vFinal[1].x - sine * vFinal[1].y;
    //  velocity2.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      
      
    //  this.vel = sqrt(sq(velocity.x) + sq(velocity.y));
    //  this.vAng = calcAng(velocity.x, velocity.y);
      
    //  other.vel = sqrt(sq(velocity2.x) + sq(velocity2.y));
    //  other.vAng = calcAng(velocity2.x, velocity2.y);
  //}
    
}

  private float calcAng(float xVel, float yVel)
  {
    float ang;
    if(xVel == 0)
    {
       ang = abs(yVel) / yVel * PI / 2;
    }
    else 
    {
      ang = atan(yVel / xVel);
      if(xVel < 0)
      {
        ang += PI;
      }
    }
    return ang;
  }
  
  private void show()
  {
    pushMatrix();
    noStroke();
    fill(this.col);
    translate(this.x, this.y);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    rotate(vAng);
    if(lines)
    {
      stroke(255);
      strokeWeight(2);
      line(0,0, map(vel, MINVEL, MAXVEL, 0, 70), 0);
    }
    popMatrix();
  }
}