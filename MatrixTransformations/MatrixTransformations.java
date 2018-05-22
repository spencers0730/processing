import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MatrixTransformations extends PApplet {

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
 
 public void setup()
 {
   background(255,255,255);
   
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
 
 public void draw()
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
 
 public void mouseClicked()
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
 
 public void mouseMoved()
 {
   xDisplay = convertX(mouseX);
   yDisplay = convertY(mouseY);
 }

public void keyPressed() {
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
public class Point
{
  int xCoor;
  int yCoor;
  int order;
  int red;
  int green;
  int blue;
  
  public Point(int x, int y)
  {
    xCoor= x;
    yCoor = y;
    order = countPoints;
    if(countPoints==1)
    red=255;
    if(countPoints==2)
    green=255;
    if(countPoints==3)
    blue=255;
  }
  
   public Point(int x, int y, int ord)
  {
    xCoor= x;
    yCoor = y;
    order = ord;
    if(ord==1)
    red=255;
    if(ord==2)
    green=255;
    if(ord==3)
    blue=255;
  }
  
  public void draw()
  {
    fill(red,green,blue);
    noStroke();
    ellipse(xCoor, yCoor, 10,10);
  }
  
  public boolean newPoint()
  {
    for(Point element: points)
    {
      if(xCoor==element.xCoor&&yCoor==element.yCoor)
      return false;
    }
    return true;
  }
  
  public int getX()
  {
    return xCoor;
  }
  
  public int getY()
  {
    return yCoor;
  }
}
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
public void clearOriginal()
{
  points.clear();
  transformedPoints.clear();
  countPoints = 0;
  displayCoordinates=true;
}
public void connectDots(ArrayList<Point> list)
{
  if(list.size()>1)
  {
  stroke(127,127,127);
  for(int i = 0; i<list.size()-1;i++)
  {
    strokeWeight(3);
    line(list.get(i).getX(), list.get(i).getY(), list.get(i+1).getX(),list.get(i+1).getY());
  }
  }
  
}

public void connectDots2(ArrayList<Point> list)
{
  stroke(127,127,127);
  strokeWeight(3);
  line(list.get(points.size()-1).getX(), list.get(points.size()-1).getY(), list.get(0).getX(),list.get(0).getY());
}
public float reconvertX(float x)
{
  return (50*x+400);
}

public float reconvertY(float y)
{
  return (300-50*y);
}
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
public void drawGrid()
{
  stroke(0,0,0);
  line(0,300,800,300);
   line(400,0,400,600);
   for(int i = 1; i<13;i++)
   {
     line(395,i*50,405,i*50);
   }
   for(int i = 1; i<17;i++)
   {
     line(i*50, 295, i*50, 305);
   }
}
public void drawQuad(ArrayList<Point> elements, int index)
{
  if(elements.size()==4)
  {
  int[] coords = new int[8];
  for(int i = 0;i<8;i++)
  {
    coords[i]=elements.get(i/2).getX();
    i++;
    coords[i]=elements.get(i/2).getY();
  }
  if(index==1)fill(0,0,255,50);
  else fill(255,255,0,50);
  quad(coords[0],coords[1],coords[2],coords[3],coords[4],coords[5],coords[6],coords[7]);
  }
}
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
  
  fill(0xff43EDCF);
  rect(860,300,110,70);
  fill(0,0,0);
  textSize(16);
  text("Click to \nDraw",880,330);
  
  fill(0xff43EDCF);
  rect(860,400,110,70);
  fill(0,0,0);
  textSize(16);
  text("Clear Original\nPicture",862,430);


  

 
}
public class matrixElement
{
  int position;
  float value;
  
  public matrixElement(int pos, float val)
  {
    position = pos;
    value = val;
  }
  
  public int getPos()
  {
    return position;
  }
  
  public float getValue()
  {
    return value;
  }
  
  public void toggleValue()
  {
    if(value<4)
    value+=.5f;
    else
    value = -4;
  }
}
public void multiply()
{
  transformedPoints.clear();
  int count = 0;
  for(Point p: points)
  {
    int x =(int) reconvertX( convertX(p.getX())*elements.get(0).getValue()+convertY(p.getY())*elements.get(1).getValue());
    int y = (int)reconvertY(convertX(p.getX())*elements.get(2).getValue()+convertY(p.getY())*elements.get(3).getValue());
    transformedPoints.add(new Point(x,y,count));
    count++;
  }
}
public void transformPoints()
{
  //this will call the multiply method and then the translated Points.
  multiply();
  displayTransformed=true;
}
  public void settings() {  size(1200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "MatrixTransformations" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
