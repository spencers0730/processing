int index, maxIndex;
int maxX, maxY;

final float FONT_SIZE = 10;

final int MAXCHARS = 101;
final int MINCHARS = 5;

void setup() {
  //fullScreen();
  size(600, 600);
  textSize(2 * FONT_SIZE);

  index = 0;
  maxX = int(width / (FONT_SIZE * .5));
  maxY = int(height / (FONT_SIZE));
  maxIndex = maxX * maxY / 2;

  background(0);
}

void draw() {
  fill(255);
  int chars = int(random(MINCHARS, MAXCHARS));
  for (int i = 0; i < chars; i++) {
    float x = FONT_SIZE * (index % maxX);
    float y = FONT_SIZE * ((index - (index % maxY))/maxY);
    index++;
    text((char)int(random(34, 127)), x, y);
  }
  if (index >= maxIndex)
  {
    background(0);
    index = 0;
  }
}