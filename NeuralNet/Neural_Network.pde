class Network {
  Layer inputs;
  Layer[] hidden;
  Layer outputs;
  
  
  Network(int numInputs, int hiddenLayers, int[] numHidden, int numOutputs){
    
    inputs = new Layer(0, numInputs, this, 0);
    
    hidden = new Layer[hiddenLayers];
    for(int i = 0; i < hidden.length; i++)
      hidden[i] = new Layer(1, numHidden[i], this, i);
    
    outputs = new Layer(2, numOutputs, this, 0);
  }
  
  void update(float[] inputValues){
    inputs.setInputValues(inputValues);
    for(int i = 0; i < hidden.length; i++){
      hidden[i].
    }
  }
}