public void box()
{
  //displayLines = false;
  fill(50,50,50);
  rect(800,50,400,500);
  fill(255,255,255);
  textSize(16);
  text("Click on your 4 matrix parameters:\nToggle between -4 and 4 inclusive", 850, 100);
  stroke(255,255,255);
  strokeWeight(5);
  line(850,150,850,275);
  line(985,150,985,275);
  fourInputs();
  
  
}