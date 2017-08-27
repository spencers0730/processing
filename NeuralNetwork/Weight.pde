class Weight{
  float val;
  float deltaE;

  Weight(float val){
    this.val = val;
  }
  
  void update(float newVal){
    this.val += newVal;  
    println(newVal);
  }
  
  void setError(float error){
    this.deltaE = error;
    
  }
}