public void fourInputs()
{
  fill(255,255,255);
  rect(860,160,50,50);
  rect(920,160,50,50);
  rect(860,220,50,50);
  rect(920,220,50,50);
  
  fill(0,0,0);
  textSize(18);
  text(""+elements.get(0).getValue(), 870, 195);
  text(""+elements.get(1).getValue(), 930, 195);
  text(""+elements.get(2).getValue(), 870, 255);
  text(""+elements.get(3).getValue(), 930, 255);
  
  fill(#43EDCF);
  rect(860,300,110,70);
  fill(0,0,0);
  textSize(16);
  text("Click to \nDraw",880,330);
  
  fill(#43EDCF);
  rect(860,400,110,70);
  fill(0,0,0);
  textSize(16);
  text("Clear Original\nPicture",862,430);


  

 
}