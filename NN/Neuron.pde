
class Neuron{
  private int type;
  
  private float[] in;
  private Weight[] w;
  
  private float out;
  
  public Neuron(int type, int inputs){
    this.type = type;
    this.in = new float[inputs];
    this.w = new Weight[inputs];
    if(this.type != BIAS){
      initWeights();
    } else {
      this.out = 1;
    }
  }
}