float z = 0;

float s = 20;

ArrayList<Point> points;

boolean lines;

void setup() {
  fullScreen();
  colorMode(HSB);
  background(0);
  
  points = new ArrayList<Point>();

  lines = false;
  
  for (int i = 0; i < 200; i++) {
    points.add(new Point(new PVector(random(width), random(height)), PVector.random2D().mult(10), random(1, 3), 1, false, color(random(255), 255, 255)));
  }
}

void draw() {
  //background(0);
  pushMatrix();
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);
  popMatrix();

  int x = 5;
  for(int i = 0; i < x; i++)
  for(Point p : points){
    p.update(x);
  }
  for(Point p : points){
    p.show();
  }

  //int maxX = int(width / s);
  //int maxY = int(height /s);

  //float l = s / 2;

  //for (int i = 0; i < maxX; i++)
  //  for (int j = 0; j < maxY; j++) {
  //    pushMatrix();
  //    translate(i * s, j * s);
  //    rotate(-map(angle(i, j), 0, 1, 0, TWO_PI));
  //    stroke(255);
  //    //noStroke();
  //    //fill(angle(i, j) * 255);
  //    //rect(0, 0, s, s);
  //    line(-l, 0, l, 0);
  //    line(0, -l, l, 0);
  //    line(0, l, l, 0);
  //    popMatrix();
  //  }
}

void keyPressed(){
  if(keyCode == TAB){
    lines = !lines;
  }
  switch(key){
    case CODED:
    switch(keyCode){
      case TAB:
      lines = !lines;
    }  
  }
}

float angle(float x, float y) {
  //z += .000005;
  return map(noise(x * .005, y * .005, z), 0, 1, -TWO_PI, TWO_PI);
}