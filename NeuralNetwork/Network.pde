class Network {

  Layer input;
  Layer[] hidden;
  Layer output;

  float[] out;

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

  float[] iterate(float[] inputValues, float[] targetValues) {
    this.input.giveVals(inputValues);
    this.hidden[0].giveVals(this.input.getVals());
    for (int i = 1; i < hidden.length; i++) {
      this.hidden[i].giveVals(this.hidden[i - 1].getVals());
    }
    this.output.giveVals(this.hidden[hidden.length - 1].getVals());
    this.out = this.output.getVals();
    this.backPropogate(targetValues);
    return this.out;
  }

  void backPropogate(float[] targetValues) {
  }
}