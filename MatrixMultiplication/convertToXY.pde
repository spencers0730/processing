public int convertX(double x)
{
  if(x>=400)
  return (int)(((x-400)/25+1)/2);
  else
  return (int)(((x-400)/25-1)/2);
}

public int convertY(double y)
{
  if(y<=300)
  return (int)(((300-y)/25+1)/2);
  else
  return (int)(((300-y)/25-1)/2);
}