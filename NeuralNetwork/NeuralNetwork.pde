final int inputs = 20;
final int hiddenNum = 0;
final int[] hiddenNeurons = new int[]{2};
final int outputs = inputs;
final float lr = 5;

float TOTAL_WIDTH;
float TOTAL_HEIGHT;

float X_BUFF;
float Y_BUFF;

float X_STEP;
float Y_STEP;

float SIZE;

//float minWeight;
//float maxWeight;

Network net;

Point[] p;

float[] random;
float[] target;

float totalError;
boolean run, map;

void setup() {
  fullScreen();
  colorMode(HSB);

  net = new Network(inputs, hiddenNum, hiddenNeurons, outputs, lr);

  run = false;
  map = false;

  //minWeight = 0;
  //maxWeight = 0;

  random = new float[inputs];
  target = new float[inputs];

  int maxNeurons = max(inputs, max(hiddenNeurons), outputs);

  float buffer = .01;

  TOTAL_WIDTH = width * (1 - 2 * buffer);
  TOTAL_HEIGHT = height * (1 - 2 * buffer);

  X_BUFF = width * buffer;
  Y_BUFF = height * buffer;

  X_STEP = TOTAL_WIDTH / float(net.numLayers + 1);
  Y_STEP = TOTAL_HEIGHT / (maxNeurons + 1);

  println(TOTAL_WIDTH, TOTAL_HEIGHT, X_BUFF, Y_BUFF, X_STEP, Y_STEP);

  SIZE = Y_STEP / 3;

  int n = 0;
  for (int i = 0; i < hiddenNeurons.length; i++) 
    n += hiddenNeurons[i] + 1;

  p = new Point[inputs + 1 + n + 2 * outputs + 1];

  int num = 0;
  int index = 0;

  for (int i = 0; i < inputs + 1; i++) {
    p[num] = new Point(index * X_STEP + X_BUFF, i * Y_STEP + Y_BUFF, SIZE, index);
    num++;
  }
  index++;
  for (int i = 0; i < hiddenNum; i++) {
    for (int j = 0; j < hiddenNeurons[i] + 1; j++) {
      p[num] = new Point(index * X_STEP + X_BUFF, j * Y_STEP + Y_BUFF, SIZE, index);
      num++;
    }  
    index++;
  }
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
  //background(64, 128, 255);
  background(128, 64, 200);
  int num = 0;
  for (int i = 0; i < inputs + 1; i++) {
    p[num].circle(net.input.contents[i].output);
    num++;
  }
  for (int i = 0; i < hiddenNum; i++)
    for (int j = 0; j < hiddenNeurons[i] + 1; j++) {
      p[num].update(net.hidden[i].contents[j].output, net.hidden[i].contents[j].getWeights());
      //if (map || true) {
      //  minWeight = min(minWeight, min(net.hidden[i].contents[j].getWeights()));
      //  maxWeight = max(maxWeight, max(net.hidden[i].contents[j].getWeights()));
      //}
      num++;
    }
  for (int i = 0; i < outputs; i++) {
    p[num].update(net.output.contents[i].output, net.output.contents[i].getWeights());
    //if (map|| true) {
    //    minWeight = min(minWeight, min(net.output.contents[i].getWeights()));
    //    maxWeight = max(maxWeight, max(net.output.contents[i].getWeights()));
    //  }
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
    call(1);
  }
}

void mousePressed() {
  call(1);
}

void call(int n) {
  for (int t = 0; t < n; t++) {
    for (int i = 0; i < random.length; i++) {
      float r = int(random(0, 2));
      random[i] = r;
      target[target.length - i - 1] = r;
    }
    net.iterate(random, target);
    totalError = net.getTotalError();
  }
}

void keyPressed() {
  switch(key) {
  case ' ':
    run = !run;
    break;
  case 'm':
    map = !map;
    break;
  case '1':
    call(10);
    break;
  case '2':
    call(500);
    break;
  case '3':
    call(2000);
    break;
  }
}