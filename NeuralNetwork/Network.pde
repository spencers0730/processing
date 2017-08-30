static final int INPUT = 0;
static final int HIDDEN = 1;
static final int OUTPUT = 2;
static final int BIAS = 3;

float sigma(float[] x, float[] y) {
  float s = 0;
  for (int i = 0; i < x.length && i < y.length; i++) {
    s += x[i] * y[i];
  }
  return s;
}

class Network {

  Layer input;
  Layer[] hidden;
  Layer output;

  float[] out;
  float[] error;

  float lr;
  int numLayers;

  Network(int inputs, int hiddenLayers, int[] hiddenNeurons, int outputs, float lr) {
    this.input = new Layer(INPUT, inputs, 1);
    this.hidden = new Layer[hiddenLayers];
    int previousLayerOutputs = inputs;
    for (int i = 0; i < hiddenLayers; i++) {
      hidden[i] = new Layer(HIDDEN, hiddenNeurons[i], previousLayerOutputs);
      previousLayerOutputs = hiddenNeurons[i];
    }
    this.output = new Layer(OUTPUT, outputs, previousLayerOutputs);

    this.numLayers = 1 + hiddenLayers + 1;

    this.error = new float[outputs];

    this.lr = lr;
  }

  float[] iterate(float[] inputValues, float[] targetValues) {

    Layer l;

    for (int i = 0; i < this.numLayers; i++) {
      if (i == 0) {
        l = this.input;
      } else if (i == this.hidden.length + 1) {
        l = this.output;
      } else {
        l = this.hidden[i - 1];
      }
      l.giveVals(inputValues);
      inputValues = l.getVals();
    }
    this.out = inputValues;
    this.backPropogate(targetValues);
    return this.out;
  }

  void calcError(float[] targetValues) {
    for (int i = 0; i < this.error.length; i++) {
      this.error[i] = this.out[i] - targetValues[i];
    }
  }

  float getTotalError() {
    float totalError = 0;
    for (int i = 0; i < this.error.length; i++) {
      totalError += 0.5 * sq(this.error[i]);
    }
    return totalError;
  }


  void backPropogate(float[] targetValues) {
    this.calcError(targetValues);

    Layer layerIn, layerOut;

    for (int l = 0; l < this.numLayers - 1; l++) {
      if (l == 0) {
        layerIn = this.input;
      } else {
        layerIn = this.hidden[l - 1];
      }

      if (l < this.hidden.length) {
        layerOut = this.hidden[l];
      } else {
        layerOut = this.output;
      }


      for (int j = 0; j < layerOut.neuronLength; j++) {
        float valOut = layerOut.contents[j].output;
        float deltaE = valOut * (1 - valOut);

        if (layerOut.type == OUTPUT) {
          deltaE *= this.error[j];
        } else {
          Layer next;
          if (l + 1 < this.hidden.length) {
            next = this.hidden[l + 1];
          } else {
            next = this.output;
          }
          float deltaK = 0;
          for (int k = 0; k < next.neuronLength; k++) {
            Weight nextWeight = next.contents[k].weights[j];
            deltaK += nextWeight.deltaE * nextWeight.val;
          }
          deltaE *= deltaK;
        }

        for (int i = 0; i < layerIn.contents.length; i++) {
          float valIn = layerIn.contents[i].output;
          layerOut.contents[j].weights[i].setError(deltaE);
          deltaE *= valIn;
          float deltaW = -this.lr * deltaE;
          layerOut.contents[j].weights[i].update(deltaW);
        }
      }
    }
  }
}