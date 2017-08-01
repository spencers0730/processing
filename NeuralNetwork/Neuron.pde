float sigma(float[] x, float[] y) {
  float s = 0;
  for (int i = 0; i < x.length && i < y.length; i++) {
    s += x[i] * y[i];
  }
  return s;
}

float sigmoid(float x){
  return (1 / (1 + exp(-x)));
}

  class Neuron {
  int type;

  float[] inputs;
  float[] weights;

  float output;

  Neuron(int type, int numInputs) {
    this.type = type;

    if (type != BIAS) {
      this.inputs = new float[numInputs];
      this.weights = new float[numInputs];
    } else {
      this.output = 1;
    }
  }

  float give(float[] inputs) {
    if (this.type != BIAS) {
      this.inputs = inputs;
      this.output = sigmoid(sigma(this.inputs, this.weights));
    }
  }
}