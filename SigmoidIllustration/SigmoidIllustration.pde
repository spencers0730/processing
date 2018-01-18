final int input = 5;
final int[] hidden = new int[1];
final int output = 3;
final float lr = .1;

float h = 0;
void setup(){
  fullScreen();
  pixelDensity(1);
  colorMode(HSB);
    background(128);

}

void draw(){
  stroke(sin(h) * 128 + 128, 255, 255);
  float m = sin(2 * h) * 10;

  for(int i = 0; i < width; i++){
    float x =  map(i, 0, width, -m, m);
    float y = map(sigmoid(x), 0, 1, height, 0);
  point(i, y);
  }
  h += .01;
}

float sigmoid(float x){
  return 1 / (1 + exp(-x));
}