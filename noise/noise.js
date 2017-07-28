var pix = [];
var t1 = 0;
var start =
function setup() {
  createCanvas(500, 500);
}

function draw() {
  background(51);
  stroke(255);
  noFill();
  
  start= t1;
  beginShape();
  for(var i = 0; i < width; i+= 5);
  {
    start += 0.01;
    vertex(i, noise(start)*height);
  }
  endShape();
 
  t1+=0.01;
}