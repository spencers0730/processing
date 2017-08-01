class Layer {
  Neuron[] contents;
  Neuron bias;

  float[] outputValues;

  int type;

  Layer(int type, int number, int numInputs) {
    this.type = type;
    this.contents = new Neuron[number];
    if(type != INPUT)
      numInputs++;
    for (int i = 0; i < number; i++) {
      this.contents[i] = new Neuron(type, numInputs);
    }
    if (type != OUTPUT)
      this.bias = new Neuron(BIAS, 0);
  }
  
  float[] give(float[] inputValues){
    for(int i = 0; i < this.contents.length && i < inputValues.length; i++){
      outputValues[i] = 
    }
  }
}