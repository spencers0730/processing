class Point{

  PVector pos;
  PVector vel;
  
  Point(float x, float y, float mag){
    this.pos = new PVector(x, y);
    this.vel = PVector.random2D().setMag(mag);
  }
  
  void update(){
    this.pos.add(this.vel);
    
    if(this.pos.x >= width || this.pos.x <= 0){
      this.vel.x *= -1;
    }
    if(this.pos.y >= height || this.pos.x <= 0){
      this.vel.y *= -1;
    }
    
    this.pos.x = constrain(this.pos.x, 0, width);
    this.pos.y = constrain(this.pos.y, 0, height);
  }
}