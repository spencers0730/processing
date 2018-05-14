 int countPoints=0;
 ArrayList<Point> points;
 ArrayList<matrixElement> elements;
 ArrayList<Point> transformedPoints;
 int maxPoints;
 String myText="";
 int xDisplay;
 int yDisplay;
 boolean displayCoordinates;
 boolean displayLines;
 boolean displayTransformed;
 
 void setup()
 {
   background(255,255,255);
   size(1200, 800);
   points = new ArrayList<Point>();
   transformedPoints = new ArrayList<Point>();
   maxPoints = 4;
   displayCoordinates = true;
   displayLines = true;
   elements = new ArrayList<matrixElement>();
   for(int i = 1; i<=4; i++)
   {
     elements.add(new matrixElement(i,0));
   }
 }
 
 void draw()
 {
   background(255,255,255);
   drawGrid();
   for(Point element:points)
   {
     element.draw();
   }
   if(countPoints==maxPoints)
   {
     connectDots2(points);
     drawQuad(points,1);
     displayCoordinates = false;
     box();
   }
   connectDots(points);
   textSize(16);
   if(displayCoordinates)
   {
   text("X: "+xDisplay+" Y: "+yDisplay,mouseX+10, mouseY+10);
   }
   if(displayTransformed)
   {
     //connectDots(transformedPoints);
     //connectDots2(transformedPoints);
     drawQuad(transformedPoints,2);
     for(Point element:transformedPoints)
   {
     element.draw();
   }
   }


 
 }
 
 void mouseClicked()
 {
   if(mouseX>0&&mouseX<800&&mouseY>0&&mouseY<600)
   {
   Point trial = new Point(((mouseX+25)/50)*50, ((mouseY+25)/50)*50);
   if(countPoints<maxPoints)
   {
     if(trial.newPoint())
     {
     countPoints++;
     points.add(trial);
     }
   }
   }
   if(mouseX>860&&mouseX<910&&mouseY>160&&mouseY<210)
   {
     elements.get(0).toggleValue();
   }
   if(mouseX>860&&mouseX<910&&mouseY>220&&mouseY<270)
   {
     elements.get(2).toggleValue();
   }
   if(mouseX>920&&mouseX<970&&mouseY>160&&mouseY<210)
   {
     elements.get(1).toggleValue();
   }
   if(mouseX>920&&mouseX<970&&mouseY>220&&mouseY<270)
   {
     elements.get(3).toggleValue();
   }
   if(mouseX>860&&mouseX<970&&mouseY>300&&mouseY<370)
   {
     transformPoints();
   }
   
   if(mouseX>860&&mouseX<970&&mouseY>400&&mouseY<470)
   {
     clearOriginal();
   }
 }
 
 void mouseMoved()
 {
   xDisplay = convertX(mouseX);
   yDisplay = convertY(mouseY);
 }

void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (myText.length() > 0) {
      myText = myText.substring(0, myText.length()-1);
    }
  } else if (keyCode == DELETE) {
    myText = "";
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
  
    myText = ""+key;
  }
}