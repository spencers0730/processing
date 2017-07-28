const MIN_QUAL = 1;
const MAX_QUAL = 3;

const MIN_SIZE = 1;
const MAX_SIZE = 2.5;

const MIN_N = 40;
const MAX_N = 100;

const instruct = "Quality: 1 Low, 2 Med, 3 High";

var quality = (MIN_QUAL + MAX_QUAL) * 0.5;

var size;
var maxN;

var centerX, centerY;
var sizeX, sizeY;
var minX, minY, maxX, maxY;

var ca, cb;

var oldMouse;

function setup() {

  createCanvas(1920, 1080);
  
  centerX = -.25;
  centerY = 0;
  
  sizeX = 1.5;
  sizeY = 1.5;
  
  minX = centerX - sizeX;
  minY = centerY - sizeY;
  maxX = centerX + sizeX;
  maxY = centerY + sizeY;
  
  oldMouse = createVector();
}

function draw() {

   setQual(quality);
   
   var newMouse = createVector(mouseX, mouseY);
   
   var hasMoved =  newMouse.mag() != oldMouse.mag();
   
   oldMouse = createVector(mouseX, mouseY);
   
   if(hasMoved)
   {
     ca = map(mouseX, 0, width, -1, 1);
     cb = map(mouseY, 0, height, 1, -1);
  
     for(var y = 0; y < height; y+=size)
     {
       for(var x = 0; x < width; x+=size)
       {
         var actX = map(x, 0, width, minX, maxX);
         var actY = map(y, 0, height, maxY, minY);
        
         var count = calc(actX, actY);
        
         push();
         fill(color(map(count, 0, maxN, 0, 255)));
         noStroke();
         rect(x, y, size, size);
         pop();
       }
     }
   }
 push();
  textSize(24);
  fill(255);
  var coords = "Julia set of (" + ca + ", " + cb + ")";
  text(coords, width / 2 - coords.length * 6, 24); 
  var qual = "Quality: " + quality;
  text(qual, width / 2 - qual.length * 6, 48);
  text(instruct, width / 2 - instruct.length * 6, height - 24);
  pop();
}

function setQual(q)
{
  size = ceil(map(q, MIN_QUAL, MAX_QUAL, MAX_SIZE, MIN_SIZE));
  maxN = ceil(map(q, MIN_QUAL, MAX_QUAL, MIN_N, MAX_N));
}

function keyPressed()
{
  switch(key)
  {
    case '1':
    quality = MIN_QUAL;
    break;
    case '2':
    quality = (MIN_QUAL + MAX_QUAL) * 0.5;
    break;
    case '3':
    quality = MAX_QUAL;
    break;
  }
}

function calc(a, b)
{
  var n = 0;
  
  while(n < maxN)
  {
    var aa = a * a - b * b;
    var bb = 2 * a * b;
    
    a = aa + ca;
    b = bb + cb;
    
    if(abs(a+b) > 4)
      break;
    n++;
  }
    
  return n;
}