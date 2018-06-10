void setup() {
  noLoop();
  size(17, 17);
  PImage i = loadImage("i.bmp");
  i.resize(17, 17);
  image(i, 0, 0);
  int counter = 1;
  for (int c : i.pixels) {
    print("0x" + hex(c).substring(2) + " ");
    if (counter % 17 == 0) {
      println();
      counter++;
    } else print(",");
  }
}
