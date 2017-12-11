float sigma(float[] f) {
  float s = 0;
  for (float i : f) s += i;
  return s;
}

float dotP(float[] a, float[] b) {
  float s = 0;
  for (int i = 0; i < a.length && i < b.length; i++) {
    s += a[i] * b[i];
  }
  return s;
}

float sigmoid(float f) {
  return (1 / (1 + exp(-f)));
}


void setup() {
  fullScreen();
}






//sigmoid illustration
float mx = 0;
float r = 5;
void draw() {
  if (mx != mouseX) {
    mx = mouseX;
    r = sq(map(mouseX, 0, width, 1, 10));
    for (int i =0; i < width; i++) {
      float y = map(sigmoid(map(i, 0, width, -r, r)), 0, 1, height, 0);
      point(i, y);
    }
  }
}