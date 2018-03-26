float minX, minY, maxX, maxY;
float real, imag;

void setup() {
  size(1000, 1000);
  //fullScreen(P2D);
  colorMode(HSB);
  noLoop();

  minX = -2;
  minY = -2;
  maxX = 2;
  maxY = 2;
}

void draw() {
  for (float x = 0; x < width; x+=1.) {
    for (float y = 0; y < height; y+=1.) {
      float a = map(x, 0, width, minX, maxX);
      float b = map(y, 0, height, maxY, minY);
      complexFunc(a, b);

      float arg_z = atan2(imag, real) + PI;
      float hu = 255 / TWO_PI * arg_z;
      float l = 255 * (1 - pow(2, -sqrt(sq(imag) + sq(real))));
      float s = 255;
      
      if(prox(real, .005, .25) || prox(imag, .005, .25)){
        s = 0;
      }

      set((int)x, (int)y, color(hu, s, l));
    }
  }
}

void complexFunc(float a, float b) {
  real = pow(a, 3) - 2 * a * pow(b, 2) - 1;
  imag = 3 * pow(a, 2) * b - pow(b, 3);
}

boolean prox(float x, float min, float mult){
  return min / mult > Math.abs(Math.rint(x / mult) - x / mult);
}
