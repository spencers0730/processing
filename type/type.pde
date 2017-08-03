String current;

float x, y;
float w, h;

float size;

int index;
int max;

void setup() {
  fullScreen();
  textMode(CORNER);
  x = 100;
  y = 100;
  w = 1000;
  h = 100;

  index = 0;

  current = "";
  size = h;
}

void draw() {
  max = current.length() - 1;
  
  background(0);
  textSize(size);
  noStroke();
  fill(128, 128, 255);
  rect(x, y, w, h);
  fill(0);
  String display = current.substring(index);
  while (textWidth(display) > w) {
    //display = display.substring(0, display.length() - 1);
    index++;
    display = current.substring(index);
  }
  text(display, x, y + h);
}

void keyPressed() {
  if (key == BACKSPACE) {
    if (current.length() > 0) {
      current = current.substring(0, max);
      index--;
    }
  } else if (key != CODED) {
    current += key;
  } else switch(keyCode) {
  case UP:
    index = 0;
    break;
  case DOWN:
    index = current.length() - 1;
    break;
  case LEFT:
    if (index > 0)
      index--;
    break;
  case RIGHT:
    if (index < max)
      index++;
    break;
  }

}