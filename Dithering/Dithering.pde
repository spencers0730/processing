PImage im;
PImage out;

float pMouseX;

void setup() {
  im = loadImage("boy.jpg");
  out = loadImage("boy.jpg");
  image(im, 0, 0);
  size(1000, 500);
}

void draw() {
  if (mouseX != pMouseX) {
    pMouseX = mouseX;
    float power = 100;
    int p = 255;
    int n = 1 + int(pow(map(mouseX, 0, width, pow(2, 1/power), pow(p, 1/power)), power));

    out.loadPixels();
    for (int x = 0; x < out.width; x++)
      for (int y = 0; y < out.height; y++) {
        int i = index(x, y);
        color c = im.pixels[i];
        float r = red(c);
        float g = green(c);
        float b = blue(c);


        out.pixels[i] = color(qC(p, n, r), qC(p, n, g), qC(p, n, b));
      }
    out.updatePixels();
    image(out, width / 2, 0);
  }
}
int index(int x, int y) {
  return x + y * out.width;
}

int qC(int possible, int factor, float val) {
  factor--;
  return int(round(factor * val / possible) * possible / factor);
}