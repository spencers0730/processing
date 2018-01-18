float dotProduct(float[] a, float[] b) {
  float s = 0;
  for (int i = 0; i < a.length && i < b.length; i++) {
    s += a[i] * b[i];
  }
  return s;
}

float calcError(float[] a, float[] b){
  float s = 0;
  for (int i = 0; i < a.length && i < b.length; i++) {
    s += sq(a[i] - b[i]);
  }
  return s;
}

float sigmoid(float x) {
  return (1 / (1 + exp(-x)));
}

float dsigmoid(float x) {
  float s = sigmoid(x);
  return s * (1 - s);
}

class Network {
  private float[][] values;
  private float[][][] weights;

  private float lr;

  private float error;

  public Network(int input, int[] hidden, int output, float lr) {
    int layers = 2 + hidden.length;
    this.values = new float[layers][];
    this.weights = new float[layers - 1][][];
    for (int i = 0; i < this.values.length; i++) {
      int neurons;
      if (i == 0) neurons = input + 1;
      else if (i == values.length - 1 && hidden.length != 0) 
        neurons = hidden[i - 1] + 1;
      else neurons = output;
      this.values[i] = new float[neurons];
    }

    for (int i = 0; i < values.length; i++) {
      this.values[i][this.values[i].length - 1] = 1;
    }

    for (int i = 0; i < weights.length; i++) {
      int weight;
      if (i == 0 && hidden.length != 0) weight = hidden[i + 1];
      else weight = output;
      this.weights[i] = new float[weight][];
    }
    this.lr = lr;
    this.initWeights();
  }

  private void initWeights() {
    for (float[][] layer : this.weights)
      for (float[] neuron : layer)
        for (float weight : neuron)
          weight = random(-1, 1);
  }

  public float[] run(float[] in) {
    for (int layer = 0; layer < this.values.length; layer++) {
      for (int neuron = 0; neuron < this.values[layer].length - 1; neuron++) {
        if (layer == 0) this.values[layer][neuron] = in[neuron];
        else this.values[layer][neuron] = 
          sigmoid(dotProduct(this.values[layer - 1], this.weights[layer][neuron]));
      }
    }
    return this.values[this.values.length - 1];
  }

  public float[] iterate(float[] in, float[] expected) {
    float[] out = this.run(in);
    this.backProp(out, expected);
    return out;
  }
  
  private void backProp(){
  this.error(expected, out);
  
  }

  private void error(float[] expected, float[] reality) {
    this.error = calcError(expected, reality);
  }
  
  public float getError(){
    return this.error;
  }
  
}