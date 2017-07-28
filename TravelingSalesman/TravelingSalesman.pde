City[] cities;

final int totalCities = 10;

int startIndex;

int[] best;
int[] current;

void setup()
{
  size(1000, 1000);
  
  cities = new City[totalCities];
  
  startIndex = int(random(totalCities));
  best = new int[totalCities];
  
  for(int i = 0; i < totalCities; i++)
  {
    best[i] = (startIndex + i) % totalCities;
  }
  
}

void draw()
{
  background(0);
  
  for(int i = 0; i < totalCities; i++)
  {
    cities[i].before = -1;
    cities[i].after = -1;
  }
  for(int h = 0; h < totalCities; h++)
    for(int i = 0; i < totalCities; i++)
    {
      float minDist = -1;
      boolean found = false;
      for(int j = 0; j < totalCities && !found; j++)
      {
        if(i != j)
        {
          float currentDist = dist(cities[current[i]].x, cities[current[i]].y, cities[current[i] % totalCities].x, cities[current[i] % totalCities].y);
          if(currentDist < minDist || minDist < 0)
          {
            minDist = currentDist;
            current[h]
            found = true;
          }
        }
      }
    }
  
}

float getDistance(int[] current)
{
  float sum = 0;
  for(int i = 0; i < totalCities; i++)
  {
    sum += dist(cities[current[i]].x, cities[current[i]].y, cities[current[i + 1] % totalCities].x, cities[current[i + 1] % totalCities].y);
  }
  return sum;
}