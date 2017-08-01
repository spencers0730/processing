class Network {

  Layer input;
  Layer[] hidden;
  Layer output;

  Network(int inputs, int hiddenLayers, int[] hiddenNeurons, int outputs) {
    this.input = new Layer(INPUT, inputs, 1);
    this.hidden = new Layer[hiddenLayers];
    for (int i = 0; i < hiddenLayers; i++) {
      int previousLayerOutputs;
      if (i == 0)
        previousLayerOutputs = inputs;
      else
        previousLayerOutputs = hiddenNeurons[i - 1];
        
      hidden[i] = new Layer(HIDDEN, hiddenNeurons[i], previousLayerOutputs);
    }
    this.output = new Layer(OUTPUT, outputs, hiddenNeurons[hiddenNeurons.length - 1]);
  }
  
  float[] step(float[] inputValues){
    this.input.give(inputValues);
  }
}
