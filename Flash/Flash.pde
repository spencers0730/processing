void setup() {
  fullScreen();
}
void draw() {
  for (int i = 0; i < width; i+=2)
    for (int j = 0; j < height; j+=2) {
      if (i < 2 || j < 2) {
        float k = random(255);
        set(i, j, color(k, k, k));
      } else {
        set(i, j, get(i - 2, j - 2));
      }
    }
}