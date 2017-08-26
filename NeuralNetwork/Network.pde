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

  Network(int inputs, int hiddenLayers, int[] hiddenNeurons, int outputs, float lr) {
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
    this.error = new float[outputs];

    this.lr = lr;
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

  void calcError(float[] targetValues) {
    for (int i = 0; i < this.error.length; i++) {
      this.error[i] = this.out[i] - targetValues[i];
    }
  }
  
  float getError(){
      float totalError = 0;
    for(int i = 0; i < this.error.length; i++){
      totalError += 0.5 * sq(this.error[i]);
    }
    return totalError;
  }


  void backPropogate(float[] targetValues) {
    this.calcError(targetValues);

    for (int i = 0; i < this.hidden[this.hidden.length - 1].contents.length; i++) {
      float inVal = this.hidden[this.hidden.length - 1].contents[i].output;
      for (int j = 0; j < this.output.getLen(); j++) {
        println(j, this.output.getLen());
        float outVal = this.output.contents[j].output;

        float deltaE = this.error[j] * outVal * (1 - outVal);
        this.output.contents[j].weights[i].setError(deltaE);
        deltaE *= inVal;
        float change = -this.lr * deltaE;
        this.output.contents[j].weights[i].update(change);
      }
    }

    for (int l = this.hidden.length - 1; l > 0; l--) 
      for (int j = 0; j < this.hidden[l].contents.length; j++) {
        float outVal = this.hidden[l].contents[j].output;

        float deltaKTimesWeight = 0;
        if (l == this.hidden.length - 1) {
          for (int k = 0; k < this.output.contents.length; k++) {
            deltaKTimesWeight += this.output.contents[j].weights[k].deltaE * this.output.contents[j].weights[k].val;
          }
        } else {
          for (int k = 0; k < this.hidden[l + 1].contents.length; k++) {
            deltaKTimesWeight += this.hidden[l + 1].contents[j].weights[k].deltaE * this.hidden[l + 1].contents[j].weights[k].val;
          }
        }

        for (int i = 0; i < this.hidden[l - 1].contents.length; i++) {
          float inVal = this.hidden[l - 1].contents[i].output;

          float deltaE = this.error[j] * outVal * (1 - outVal) * deltaKTimesWeight;
          this.output.contents[j].weights[i].setError(deltaE);
          deltaE *= inVal;
          float change = -this.lr * deltaE;
          this.output.contents[j].weights[i].update(change);
        }
      }
      
  }
}