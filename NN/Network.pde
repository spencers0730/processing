
static final int INPUT = 0;
static final int HIDDEN = 1;
static final int OUTPUT = 2;
static final int BIAS = 3;

class Network {
  private Layer input;
  private Layer[] hidden;
  private Layer output;

  private float[] intermediateVals;
  private float[] error;

  private float computedError;

  private float learnRate;
  private int numLayers;

  public Network(int ins, int hid, int[] hidNeurons, int outs, float lr) {
    this.input = new Layer(INPUT, ins, 0);
    this.hidden = new Layer[hid];
    for (int i = 0; i < this.hidden.length; i++) {
      int inputs = (i == 0) ? ins : this.hidden[i - 1].getNeurons();
      this.hidden[i] = new Layer(HIDDEN, hidNeurons[i], inputs);
    }
    this.output = new Layer()
  }
}