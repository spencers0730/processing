float hu = 0;
boolean change = true;
void setup(){
  fullScreen();
  colorMode(HSB);
}
void draw(){
  background(hu, 255 + random(-5, 0), 255 + random(-5, 0));
  if(change)
  hu+=.5;
  hu%=255;
}

void keyPressed(){
  change = !change;
}