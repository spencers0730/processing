var col = 0;
var is = false;

function setup() {
  createCanvas(1920, 1080)
  colorMode(HSB);
}

function draw() {
  background(col, 255, 255);
  if(is)col++;
  col %= 255;
  console.log(col);
}

function mousePressed()
{
  is = !is;
}