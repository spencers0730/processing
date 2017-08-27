final int inputs = 10;
final int hiddenNum = 2;
final int[] hiddenNeurons = new int[]{2, 2};
final int outputs = inputs;
final float lr = .005;

final float TOTAL_WIDTH = 800;
final float TOTAL_HEIGHT = 800;

final float X_BUFF = 25;
final float Y_BUFF = 25;

float X_STEP;
float Y_STEP;

float SIZE;

Network net;

Point[] p;

float[] random;
float[] target;

float totalError;
boolean run, map;

void setup() {
  fullScreen();

  net = new Network(inputs, hiddenNum, hiddenNeurons, outputs, lr);

  run = false;
  map = false;

  random = new float[inputs];
  target = new float[inputs];

  int maxNeurons = max(inputs, max(hiddenNeurons), outputs);

  X_STEP = TOTAL_WIDTH / (net.numLayers + .5);
  Y_STEP = TOTAL_HEIGHT / (maxNeurons + 1);

  SIZE = Y_STEP / 3;

  int n = 0;
  for (int i = 0; i < hiddenNeurons.length; i++) 
    n += hiddenNeurons[i] + 1;

  p = new Point[inputs + 1 + n + 2 * outputs + 1];

  int num = 0;
  int index = 0;
  
  //Y_STEP = TOTAL_HEIGHT / inputs;
  for (int i = 0; i < inputs + 1; i++) {
    p[num] = new Point(index * X_STEP + X_BUFF, i * Y_STEP + Y_BUFF, SIZE, index);
    num++;
  }
  index++;
  for (int i = 0; i < hiddenNum; i++) {
    //Y_STEP = TOTAL_HEIGHT / hiddenNeurons[i];
    for (int j = 0; j < hiddenNeurons[i] + 1; j++) {
      p[num] = new Point(index * X_STEP + X_BUFF, j * Y_STEP + Y_BUFF, SIZE, index);
      num++;
    }  
    index++;
  }
  //Y_STEP = TOTAL_HEIGHT / outputs;
  for (int i = 0; i < outputs; i++) {
    p[num] = new Point(index * X_STEP + X_BUFF, i * Y_STEP + Y_BUFF, SIZE, index);
    num++;
  }
  index++;
  for (int i = 0; i < outputs; i++) {
    p[num] = new Point(index * X_STEP + X_BUFF, i * Y_STEP + Y_BUFF, SIZE, index);
    num++;
  }
}

void draw() {
  background(64, 128, 255);
  int num = 0;
  for (int i = 0; i < inputs + 1; i++) {
    p[num].circle(net.input.contents[i].output);
    num++;
  }
  for (int i = 0; i < hiddenNum; i++)
    for (int j = 0; j < hiddenNeurons[i] + 1; j++) {
      p[num].update(net.hidden[i].contents[j].output, net.hidden[i].contents[j].getWeights());
      num++;
    }
  for (int i = 0; i < outputs; i++) {
    p[num].update(net.output.contents[i].output, net.output.contents[i].getWeights());
    num++;
  }
  for (int i = 0; i < outputs; i++) {
    p[num].circle(target[i]);
    num++;
  }
  textSize(30);
  fill(0);
  //text(int(100*10*totalError)/10+ "%", width / 2, height - 30);
  text(totalError, width / 2, height - 30);

  if (run) {
    mousePressed();
  }
}

void mousePressed() {


  for (int i = 0; i < random.length; i++) {
    float r = int(random(0, 2));
    random[i] = r;
    target[target.length - i - 1] = r;
  }
  net.iterate(random, target);
  totalError = net.getTotalError();
}

void keyPressed() {
  switch(key) {
  case ' ':
    run = !run;
    break;
  case 'm':
    map = !map;
    break;
  }
}