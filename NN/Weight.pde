class Weight {
  private float current;
  private float deltaError; //partial derivative with respect to this weight
  
  public Weight(float init){
    this.current = init;
  }
  
  public void update(float delta){
    this.current += delta;
  }
  
  public void setError(float error){
    this.deltaError = error;
  }
  
  public float getError(){
    return this.deltaError;
  }
}
  