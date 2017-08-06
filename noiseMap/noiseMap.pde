float z = 0;

float increment = .01;

float s = 20;

void setup() {
  fullScreen();
}

void draw(){
  background(0);
  
  int maxX = int(width / s);
  int maxY = int(height /s);
  
  float l = s / 2;
  
  for(int i = 0; i < maxX; i++)
    for(int j = 0; j < maxY; j++){
      pushMatrix();
      translate(i * s, j * s);
      rotate(angle(i, j));
      //rotate(0);
      stroke(255);
      line(-l, 0, l, 0);
      line(0, -l, l, 0);
      line(0, l, l, 0);
      popMatrix();
    }
}

float angle(float x, float y) {
  z += increment / 5000;
  return map(noise(x * increment, y * increment, z), 0, 1, -PI, PI);
}