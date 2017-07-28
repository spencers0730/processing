class Layer
{
  Neuron[] neurons;
  String title;
  float x;
  int index;
  
  Layer(float x, float spacing, int n, float size, String title, int index)
  {
    this.neurons = new Neuron[n];
    this.title = title;
    this.x = x;
    this.index = index;
    
    if(this.index == 0)
    {
      for(int i = 0; i < n; i++)
      {
        float y = spacing * i + HORZ_BUFFER;
        this.neurons[i] = new Neuron(x, y, size, randomArray(n));
      }
    }
    else
    {
      for(int i = 0; i < n; i++)
      {
        float y = spacing * i + HORZ_BUFFER;
        this.neurons[i] = new Neuron(x, y, size, layers[this.index - 1].neurons, randomArray(layers[this.index - 1].neurons.length));
      }
    }
  }
  
  void show()
  {
    noStroke();
    fill(255);
    textSize(HORZ_BUFFER * 0.25);
    text(title, this.x - textWidth(title) * 0.5, HORZ_BUFFER * 0.5); 
    for(int i = 0; i < this.neurons.length; i++)
    {
      this.neurons[i].update();
    }
    if(this.index != 0)
      this.connect(layers[this.index - 1]);
  }
  
  void connect(Layer other)
  {
    noFill();
    strokeWeight(1);
    for(int i = 0; i < this.neurons.length; i++)
    {
      for(int j = 0; j < other.neurons.length; j++)
      {
         stroke(map(this.neurons[i].weights[j], -1, 1, 0, 255));
         line(this.neurons[i].x, this.neurons[i].y, other.neurons[j].x, other.neurons[j].y);
      }
    }
  }
}