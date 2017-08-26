class Layer {
  Neuron[] contents;

  float[] outputValues;

  int type;

  Layer(int type, int number, int numInputs) {
    this.type = type;
    this.contents = new Neuron[number + 1];
    this.outputValues = new float[this.contents.length];
    if (type != INPUT)
      numInputs++;
    for (int i = 0; i < number; i++) {
      this.contents[i] = new Neuron(type, numInputs);
    }
    if (type != OUTPUT)
     this.contents[this.contents.length - 1] = new Neuron(BIAS, 0);
  }

  int getLen(){
    return this.contents.length;
  }

  void giveVals(float[] inputValues) {
    for (int i = 0; i < this.contents.length - 1 && i < inputValues.length; i++) {
      this.outputValues[i] = this.contents[i].give(inputValues);
    }
  }
  float[] getVals() {
    return this.outputValues;
  }
}