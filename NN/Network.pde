static final int INPUT = 0;
static final int HIDDEN = 1;
static final int OUTPUT = 2;
static final int BIAS = 3;

class Network{
  private Layer input;
  private Layer[] hidden;
  private Layer output;
  
  private float[] intermediateVals;
  private float[] error;
  
  private float computedError;
  
  private float learnRate;
  private int numLayers;
  
  public Network(int ins, int hid, int[] hidNeurons, int outs, float lr){
    this
  }
}