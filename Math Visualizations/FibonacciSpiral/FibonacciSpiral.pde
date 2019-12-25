
import java.math.BigInteger;
import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;

final float EASING = .8;
final float INCREASE = 1.04;
final float TEXT_SCALE = .1;
final String INSTRUCT = "Z: Zoom C: Color S: Squares N: Numbers H: Help";

float scale;

int dir;
BigInteger centerX;
BigInteger centerY;

BigInteger fib1;
BigInteger fib2;

ArrayList<Square> squares;

boolean rainbow;
boolean ease;
boolean rect;
boolean num;
boolean help;

void settings() {
  fullScreen();
}

void setup() {
  colorMode(HSB);
  squares = new ArrayList<Square>();

  rainbow = true;
  ease = true;
  rect = true;
  num = true;
  help = true;

  scale = 10;
  dir = 0;

  fib1 = BigInteger.ZERO;
  fib2 = BigInteger.ONE;

  centerX = BigInteger.ZERO;
  centerY = BigInteger.ZERO;
}

void draw() {
  background(0);

  if (ease)
    scale = scale * (EASING) + (new BigDecimal(height / 2).multiply(new BigDecimal(1 - EASING))
        .divide(new BigDecimal(fib2), RoundingMode.HALF_UP).round(new MathContext(10))).floatValue();

  for (Square s : squares) {
    s.update();
  }

  if (help) {
    pushMatrix();
    translate(width / 2, height);
    textSize(30);
    fill(255);
    noStroke();
    text(INSTRUCT, -textWidth(INSTRUCT) * 0.5, -30);
    popMatrix();
  }
  
  saveFrame();
}

void keyPressed() {
  switch (key) {
  case 'c':
    rainbow = !rainbow;
    break;
  case 'z':
    ease = !ease;
    break;
  case 's':
    rect = !rect;
    break;
  case 'n':
    num = !num;
    break;
  case 'h':
    help = !help;
    break;
  }
}

void mousePressed() {
  step();
}

void step() {
  if (fib2.toString().length() < 25) {
    squares.add(new Square(fib2, dir, centerX, centerY));

    BigInteger addFib = fib1;

    switch (dir) {
    case 0: // right to left
      centerY = centerY.add(addFib);
      break;
    case 1: // up to down
      centerX = centerX.add(addFib);
      break;
    case 2: // left to right
      centerY = centerY.subtract(addFib);
      break;
    case 3: // down to up
      centerX = centerX.subtract(addFib);
      break;
    }

    dir++;
    dir %= 4;

    BigInteger fibTemp = fib2;
    fib2 = fib2.add(fib1);
    fib1 = fibTemp;
  }
}

void mouseWheel(MouseEvent e) {
  float scroll = e.getCount();

  scale *= pow(INCREASE, -scroll);

}
