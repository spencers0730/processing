class Layer {
  Neuron[] contents;
  Neuron bias;

  float[] outputValues;

  int type;

  Layer(int type, int number, int numInputs) {
    this.type = type;
    this.contents = new Neuron[number];
    if (type != INPUT)
      numInputs++;
    for (int i = 0; i < number; i++) {
      this.contents[i] = new Neuron(type, numInputs);
    }
    if (type != OUTPUT)
      this.bias = new Neuron(BIAS, 0);
  }

  void giveVals(float[] inputValues) {
    for (int i = 0; i < this.contents.length && i < inputValues.length; i++) {
      this.outputValues[i] = this.contents[i].give(inputValues);
    }
  }
  float[] getVals() {
    return this.outputValues;
  }
}