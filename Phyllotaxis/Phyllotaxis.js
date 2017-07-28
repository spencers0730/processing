var spacing = 20;
var gold;
var num = 500;

var add = 0;
function setup() {
  createCanvas(1920, 1080);
  gold = PI * (3 - sqrt(5));
  colorMode(HSB);
  background(51);
  noStroke();
}

function draw() {
  background(51, .1);
  add += .06;
  var c = spacing +  5 * sin(add);
  var angle = gold + .0002 * cos(add);
  for(var i = 0; i < num; i++)
  {
    var a = i * angle;
    var r = c * sqrt(i);
    
    var x = r * cos(a) + width/2;
    var y = r * sin(a) + height/2;
    
    var size = map(r, 0, c * sqrt(num), 500, 30);
    
    var hu = map(r, 1, c * sqrt(num), 140, 240);
    fill(hu%255, 255, 255, 2)
    ellipse(x, y, size, size);
    
  }
}