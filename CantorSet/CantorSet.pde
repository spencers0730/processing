void setup() {
  fullScreen();
  background(255);
  noStroke();
  fill(0);
  call(0,10,width,20);
}

void call(float x, float y, float l, int level){
 if(level > 0){
   call(x, y + 20, l /3, level - 1);
  call(x + l * .666, y + 20, l /3, level - 1);
  rect(x, y, l, 10);
 }
}
