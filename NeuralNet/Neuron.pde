float[] multiply(float[] inputs, float[] weights) {
  if (inputs.length != weights.length)
    return null;
  float[] outputs = new float[inputs.length];
  for (int i = 0; i < inputs.length; i++) {
    outputs[i] = inputs[i] * weights[i];
  }
  return outputs;
}

float sigma(float[] inputs) {
  float s = 0;
  for (int i = 0; i < inputs.length; i++) {
    s += inputs[i];
  }
  return s;
}

float sigmoid(float x) {
  return 1 / (1 + exp(-x));
}

class Neuron {
  Network net;
  int index; 

  float bias;

  float inputs[];
  float weights[];

  float output;

  int type;

  Neuron(int type, int index, Network n) {
  }

  void update() {
    if (this.type != INPUT) {
      this.output = sigmoid(sigma(multiply(this.inputs, this.weights)) + this.bias);
    }

  }

  void setInput(float value){
    if(this.type == INPUT)
      this.output = value;
  }

  void setInputs(float[] values){
    if(this.type != INPUT){
      this.inputs = values;
    }
  }

  //float[] getInputs()
  //{
  //  float[] inputs = new float[2];
  //  for (int i = 0; i < inputs.length; i++) {
  //    inputs[i] = net.getInputs(this.index - 1)[i];
  //  }
  //  return inputs;
  //}



  //float getOutput(){
  //  return this.output;
  //}

  //void setInput(float value){
  //  this.output = value;
  //}

  //void update() {

  //  if (this.type != 0) {
  //    //this.inputs = this.getInputs();
  //    this.output = sigma(this.inputs, this.weights);
  //  }
  //}

  void error() {
  }
}