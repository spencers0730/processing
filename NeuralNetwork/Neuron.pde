  float sigma(float[] x, Weight[] y) {
  float s = 0;
  for (int i = 0; i < x.length && i < y.length; i++) {
    s += x[i] * y[i].val;
  }
  return s;
}

float sigmoid(float x) {
  return (1 / (1 + exp(-x)));
}

class Neuron {
  int type;

  float[] inputs;
  Weight[] weights;

  float output;

  Neuron(int type, int numInputs) {
    this.type = type;
    this.inputs = new float[numInputs];
    this.weights = new Weight[numInputs];
    if (type != BIAS) {
      initWeights();
    } else {
      this.output = 1;
    }
  }

  void initWeights() {
    for (int i = 0; i < this.weights.length; i++) {
      this.weights[i] = new Weight(random(-1, 1));
    }
  }

  void setWeights(float[] values) {
    if (values.length == this.weights.length) {
      for (int i = 0; i < this.weights.length; i++) {
        this.weights[i] = new Weight(values[i]);
      }
    }
    //if (map) {
    //  minWeight = min(minWeight, min(this.getWeights()));
    //  maxWeight = max(maxWeight, max(this.getWeights()));
    //}
  }
  float[] getWeights() {
    float[] weightVals = new float[this.weights.length];
    for (int i = 0; i < this.weights.length; i++) {
      weightVals[i] = this.weights[i].val;
    }
    return weightVals;
  }


  float give(float[] inputs) {
    if (this.type == HIDDEN || this.type == OUTPUT) {
      this.inputs = inputs;
      this.output = sigmoid(sigma(this.inputs, this.weights));
    }
    return this.output;
  }
  void give(float input) {
    if (this.type == INPUT) {
      this.output = input;
    }
  }
}