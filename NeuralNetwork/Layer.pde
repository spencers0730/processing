class Layer {
  Neuron[] contents;

  float[] outputValues;

  int type;
  int neuronLength;

  Layer(int type, int numNeurons, int numInputs) {
    this.type = type;

    if (this.type != INPUT) {
      numInputs++;
    }
    if (this.type != OUTPUT) {
      this.contents = new Neuron[numNeurons + 1];
      this.contents[this.contents.length - 1] = new Neuron(BIAS, 0);
    } else {
      this.contents = new Neuron[numNeurons];
    }
    for (int i = 0; i < numNeurons; i++) {
      this.contents[i] = new Neuron(type, numInputs);
    }
    this.outputValues = new float[this.contents.length];      
    this.outputValues[this.outputValues.length - 1] = 1;

    this.neuronLength = this.contents.length - 1;
    if (this.type == OUTPUT) {
      this.neuronLength++;
    }
  }

  void giveVals(float[] inputValues) {
    if (this.type == INPUT) {
      for (int i = 0; i < this.neuronLength; i++) {
        this.outputValues[i] = inputValues[i];
      }
      for (int i = 0; i < this.neuronLength; i++) {
        this.contents[i].give(inputValues[i]);
      }
    } else {
      for (int i = 0; i < this.neuronLength; i++) {
        this.outputValues[i] = this.contents[i].give(inputValues);
      }
    }
    this.contents[this.contents.length - 1].give(1);
  }

  float[] getVals() {
    return this.outputValues;
  }
}