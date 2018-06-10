float hue = 0; 
void setup() { 
  fullScreen();
  colorMode(RGB, 1, 1, 1);
} 
void draw() { 
  hue += .01;
  float light = 1; 
  float sat = 1;
  float temp1 = (light >= .5) ? light + sat - light * sat : light * (1 + sat); 
  float temp2 = 2 * light - temp1; 
  float tempHue = (hue % 360) / 360; 
  float r = addOrSub(tempHue + 1.0/3, temp1, temp2);
  float g = addOrSub(tempHue, temp1, temp2);
  float b = addOrSub(tempHue - 1.0/3, temp1, temp2);
  
  print(r, g, b);
  background(color(r, g, b));
}

float addOrSub(float x, float y, float z) {
  if (x > 1) x--;
  else if (x < 0) x++;
    if (x * 6 < 1) {
    x = z + (y - z) * 6 * x;
  } else if (x * 2 < 1) {
    x = y;
  } else if (x * 3 < 2) {
    x = z + (y - z) * (2.0 / 3 - x) * 6;
  } else {
    x = z;
  }
  return x;
}
