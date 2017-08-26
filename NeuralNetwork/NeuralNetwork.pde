final int inputs = 3;
final int hiddenNum = 1;
final int[] hiddenNeurons = new int[]{4};
final int outputs = 3;
final float lr = .01;

final float TOTAL_WIDTH = 300;
final float TOTAL_HEIGHT = 300;

final float X_BUFF = 25;
final float Y_BUFF = 25;

final float X_STEP = TOTAL_WIDTH / (1 + hiddenNum + 1 - 1);
final float Y_STEP = TOTAL_HEIGHT / (max(inputs, max(hiddenNeurons), outputs) - 1);

Network net;

Point[] p;

void setup() {
  size(600, 600);

  net = new Network(inputs, hiddenNum, hiddenNeurons, outputs, lr);
  
  int n =0 ;
 for(int i = 0; i < hiddenNeurons.length; i++) 
   n += hiddenNeurons[i];
  
  p = new Point[inputs + n + outputs];

  int num = 0;
  int index = 0;
  for (int i = 0; i < inputs; i++) {
    p[num] = new Point(index * X_STEP + X_BUFF, i * Y_STEP + Y_BUFF, index);
    num++;
  }
  index++;
  for (int i = 0; i < hiddenNum; i++)
    for (int j = 0; j < hiddenNeurons[i]; j++) {
      p[num] = new Point(index * X_STEP + X_BUFF, i * Y_STEP + Y_BUFF, index);
      num++;
    }
  index++;
  for (int i = 0; i < outputs; i++) {
    p[num] = new Point(index * X_STEP + X_BUFF, i * Y_STEP + Y_BUFF, index);
    num++;
  }
}

void draw() {
  background(0);
  int num = 0;
  for (int i = 0; i < inputs; i++) {
    p[num].update(net.input.contents[i].output, net.input.contents[i].getWeights());
    num++;
  }
  for (int i = 0; i < hiddenNum; i++)
    for (int j = 0; j < hiddenNeurons[i]; j++) {
      p[num].update(net.hidden[i].contents[j].output, net.hidden[i].contents[j].getWeights());
      num++;
    }
  for (int i = 0; i < outputs; i++) {
    p[num].update(net.output.contents[i].output, net.output.contents[i].getWeights());
    num++;
  }
}

void mousePressed(){
  float[] random = new float[inputs];
    float[] target = new float[inputs];

  for(int i = 0; i < random.length; i++){
    float r = random(-1, 1);
    random[i] = r;
    target[target.length - i - 1] = r;
  }
  net.iterate(random, target);
}