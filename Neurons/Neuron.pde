float sum(Neuron[] inputs, float[] weights)
{
  float s = 0;
  for(int i = 0; i < inputs.length; i++)
  {
    s += inputs[i].val * weights[i];
  }
  return s;
}

float[] randomArray(int n)
{
  float[] arr = new float[n];
  
  for(int i = 0; i < n; i++)
  {
    arr[i] = random(-1, 1);
  }
  return arr;
}

class Neuron
{
  float x, y;
  float size;
  Neuron[] inputs;
  float[] weights;
  float val;
  boolean input;
  
  Neuron(float x, float y, float size, Neuron[] inputs, float[] weights)
  {
    this.x = x;
    this.y = y;
    this.size = size;
    this.inputs = inputs;
    this.weights = weights;
    this.input = false;
  }
  
  Neuron(float x, float y, float size, float[] weights)
  {
    this.x = x;
    this.y = y;
    this.size = size;
    this.weights = weights;
    this.input = true;
    this.val = random(-1, 1);
  }

  void update()
  {
    if(!this.input)
      this.val = sum(this.inputs, this.weights);
    
    if(random(1) < .1)
    {
      this.weights[(int)this.weights.length-1] += random(-.1, .1);
    }
          
    this.show();
  }
  
  void show()
  {
    noStroke();
    fill(map(this.val, -1, 1, 0, 255));
    ellipse(this.x, this.y, this.size, this.size);
    fill(128);
    textSize(this.size * 0.5);
    //text(nf(this.val,1, 2), this.x, this.y);
    text(this.val, this.x-textWidth(this.val + "") * .5, this.y + 10);
  }
}