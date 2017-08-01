float sum(float[] values) {
  int s = 0;
  for (int i = 0; i< values.length; i++) {
    s += values[i];
  }
  return s;
}

class Layer {
  Neuron[] neurons;

  Layer(int type, int n, Network net, int index) {
    for (int i = 0; i < n; i++) {
      neurons[i] = new Neuron(type, index, net);
    }
  }
  
  void transferValues()
  
  float[] getOutputs(){
  }

  void setInputValues(float[] values) {
    if(neurons.length == values.length){
      for(int i = 0; i < values.length; i++){
        neurons[i].setInput(values[i]);
      }
    }
  }


  float getError(float target) {
    return target - sum(this.getValues());
  }
}