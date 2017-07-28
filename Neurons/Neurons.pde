final float HORZ_BUFFER = 120;
final float VERT_BUFFER = 100;
final float NEURON_SIZE = 20;

float horzSpacing;
float vertSpacing;

Layer[] layers;

final int numLayers = 3;
final int minNeurons = 2;
final int maxNeurons = 3;

void setup()
{
  fullScreen();
  
  layers = new Layer[numLayers];
 
  horzSpacing = (width - 2 * VERT_BUFFER) / (numLayers - 1);
  
  for(int i = 0; i < numLayers; i++)
  {
    int numNeurons = int(random(minNeurons, maxNeurons + 1));

    vertSpacing = (height - 2 * HORZ_BUFFER) / (numNeurons - 1);
    
    float x = horzSpacing * i + VERT_BUFFER;
    
    String title = "" + i;
    if(i == 0)
    {
      title = "Input";
    }
    else if(i + 1 == numLayers)
    {
      title = "Output";
    }
    
    layers[i] = new Layer(x, vertSpacing, numNeurons, NEURON_SIZE, title, i);
  }
  
}

void draw()
{
  background(0);
  textSize(10);
  text(frameRate, 10, 10);  
  
  for(int i = 0; i < layers.length; i++)
  {
    layers[i].show();
  }
}