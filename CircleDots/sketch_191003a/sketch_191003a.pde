
void setup(){
  size(1000, 1000, P3D);
}

float a = 0;

void draw(){
  background(0);
  fill(255);
  noStroke();
  translate(width / 2, height / 2);
  float r = 400;
  
  for(int i = 0; i <= 100; i++){
      float theta = HALF_PI /100 * i;
      for(int j = 0; j <= 100; j++){
        float phi = HALF_PI / 100 * j;
        float b = theta - sin(a) * phi;
        float x, y = x = r * sin(phi);
        x *= cos(b);
        y *= sin(b);
        float z = r * cos(phi);
      
        translate(x, y, z); 
        sphere(0);
        }
  }



//  float r = 400;
//  for(float theta = 0; theta <= TWO_PI; theta += random(0.005, 0.0015)){
//     for(float phi = 0; phi <= HALF_PI; phi += random(0.005, 0.015)){
//        float x, y = x = r * sin(phi);
//        x *= cos(theta);
//        y *= sin(theta);
//        float z = r * cos(phi);
//        //pushMatrix();
//        //translate(x, y, z);
//        //sphere(10);
//        //popMatrix();
//        circle(x, y, 10000 /sq(500 - z));
//     }
//  }
//}
}
