function setup() {
  createCanvas(1000, 1000);
  angleMode(DEGREES);
  ellipseMode(CORNER);
}

function draw() {
  background(51);
  fill(255, 218, 190);
  noStroke();
  translate(width / 2, height / 2);
  ellipse(-100, 0, 100, map(mouseX, 0, width, 25, 15));
  translate(0, map(mouseX, 0, width, 12.5, 7.5));
  rotate(map(mouseX, 0, width, -125, -15));
  translate(0, -.5 * map(mouseX, 0, width, 20, 10))
  ellipse(0, 0, 100,map(mouseX, 0, width, 20, 10));
  translate(100, .5 * map(mouseX, 0, width, 20, 10));
  ellipse(0,0,map(mouseX, 0, width, 30, 10), map(mouseX, 0, width, 30, 10));
}