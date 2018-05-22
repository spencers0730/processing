class Material {
  private float indexOfRefraction;
  private color fillCol;
  private color borderCol;
  private PVector corner;
  private PVector[] vertices;
  
  Material(float indexOfRefraction, color fillCol, color borderCol, PVector[] vertices){
  this.indexOfRefraction = indexOfRefraction;
  this.fillCol = fillCol;
  this.borderCol = borderCol;
  
  for(int i = 0; i < vertices.length; i++){
  
  }
  }
  
  float getIndex(){return this.indexOfRefraction;}
  
}
