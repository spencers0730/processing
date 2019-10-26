PImage input;
PGraphics output;
float size, _size, alpha;
void setup() {
  fullScreen();

  input = loadImage("bamboo.jpg");
  float ratio = 0.5 * height / input.height;
  input.resize(int(ratio * input.width), int(ratio * input.height));

  output = createGraphics(input.width, input.height);

  size = 10;
}
void draw() {
  background(50);

  if (size != _size) {
    alpha = 255 / (PI * sq(size / 2));
    _size = size;
  }
  size = map(mouseX, 0, width, 5, 20);

  output.beginDraw();
  output.noStroke();
  output.background(50);
  for (int i = 0; i < input.pixels.length; i++) {
    int x = i % input.width;
    int y = i / input.width;
    output.fill(input.pixels[i], alpha);
    output.ellipse(x, y, size, size);
  }
  output.endDraw();

  image(input, 0, 0);
  image(output, 0, height / 2);
}
