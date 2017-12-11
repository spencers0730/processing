class Layer{
  private Neuron[] n;
  
  private float[] out;
  
  private int type;
  private int numNotBias;
  private int numTotal;
  
  public Layer(int type, int num, int in){
    this.type = type;
    
    this.numNotBias = num;    
    
    if (this.type != INPUT) {
      in++;
    }
    
    if(this.type != OUTPUT){
      this.n = new Neuron[this.numNotBias + 1];
      this.n[n.length - 1] = new Neuron(BIAS, 0);
    } else {
      this.n = new Neuron[this.numNotBias];
    }
    for(Neuron i : this.n){
      i = new Neuron(this.type, in);
    }
    this.out = new float[this.n.length];
    
  }
}