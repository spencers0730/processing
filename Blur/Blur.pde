PImage in, out;

int size = 1;

void setup() {
  fullScreen();
  in = loadImage("bamboo.jpg");
  out = loadImage("bamboo.jpg");
}

void draw() {
  float oldSize = size;
  size = int(map(mouseX, 0, width, 0, 10));
  if (oldSize != size) {
    background(0);
    loadPixels();
    if (size != 0) {
      for (int i = 0; i <= in.width; i++)
        for (int j = 0; j <= in.height; j++) {

          float r = 0, g = 0, b = 0;

          int times = 0;

          for (int i2 = -size; i2 <= size; i2++) {
            for (int j2 = -size; j2 <= size; j2++) {
              int i3 = i + i2;
              int j3 = j + j2;
              if (i3 >= size && i3 <= in.width - size && j3 >= size && j3 <= in.height - size) {
                color c = in.get(i3, j3);
                r += red(c);
                g += green(c);
                b += blue(c);

                times++;
              }
            }
          } 
          if (times != 0) {
            r /= times;
            g /= times;
            b /= times;
          }
          out.set(i, j, color(r, g, b));
        }
      updatePixels();
      image(in, 0, 0);
      image(out, 0, in.height);
    } else {
      image(in, 0, 0);
      image(in, 0, in.height);
    }
  }
}