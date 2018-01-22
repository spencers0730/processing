void setup() {
  fullScreen();
}
void draw() {
  int m = int(map(mouseX, 0, width, 25, 1));
  int n = int(map(mouseY, 0, height, 1, 25));
  for (int i = 0; i < width; i+=m)
    for (int j = 0; j < height; j+=n) {
      if (i < 2 || j < 2) {
        float k = random(255);
        set(i, j, color(k, k, k));
      } else {
        set(i, j, get(i - m, j - n));
      }
    }
}