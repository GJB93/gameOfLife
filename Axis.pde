class Axis
{
  //Creating fields necessary for creating the axis of a graph
  ArrayList<Integer> yText;
  ArrayList<Integer> xText;
  int max;
  int min;
  float borderW; 
  float borderH;
  float graphW;
  float graphH;
  float tickW;
  float textIntW;
  float textIntH;
  int verticalIncrement;
  float horizontalIncrement;
  int dataRange;
  float numberInc;
  float tickIncrement;
  
  //Constructors for the Axis class
  Axis()
  {
    this(0, width, width*0.1f, height*0.1f, 0);
  }
  
  //Base constructor
  Axis(int max, int min, float borderW, float borderH, float rectW)
  {
    //Set the max and min values
    this.max = max;
    this.min = min;
    
    //Set the values for drawing the graph
    this.borderW = borderW; 
    this.borderH = borderH;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    tickW = borderW*0.1f;
    textIntW = borderW*0.5f;
    textIntH = borderH*0.2f;
    verticalIncrement = 10;
    horizontalIncrement = rectW;
    dataRange = max-min;
    numberInc = (float) dataRange/ (float)verticalIncrement;
    tickIncrement = graphH/ verticalIncrement;
  }
  
  //Constructor for an Integer and String ArrayList
  Axis(ArrayList<Integer> yText, ArrayList<Integer> xText, int max, int min, float borderW, float borderH, float rectW)
  {
    this(max, min, borderW, borderH, rectW);
    //Initialise the yText and xText ArrayLists
    this.yText = new ArrayList<Integer>();
    this.xText = new ArrayList<Integer>();
    
    //Copy the data entered to the constructor into the class' ArrayLists
    this.yText.addAll(yText);
    this.xText.addAll(xText);
  }
  
  //Method to draw the vertical and horizontal axis lines
  void drawAxisLines()
  {
    stroke(255);
    line(borderW, (height-borderH) - graphH, borderW, height-borderH);
    line(borderW, (height-borderH), borderW+graphW, height-borderH);
  }
  
  //Method to draw the ticks for the X axis
  void drawXTicks()
  {
    textSize(10);
    textAlign(LEFT, CENTER);
    text("Generation 0 - " + xText.size(), width*0.5f, (height-borderH)+textIntW);
  }
  
  //Method to draw the X-ticks specific for bar graphs
  void drawBarXTicks()
  {
    textSize(10);
    textAlign(CENTER, CENTER);
    text("Lonliness", borderW+(horizontalIncrement/2), (height-borderH)+textIntH);
    text("Overcrowding", borderW+(horizontalIncrement/2)*3, (height-borderH)+textIntH);
    text("Generation 0 - " + xText.size(), width*0.5f, (height-borderH)+textIntW);
  }
  
  //Method to draw the ticks for the Y axis
  void drawYTicks()
  {
    //Align the text appropriately
    textAlign(RIGHT, CENTER);
    
    //For each tick increment, draw a tick and the registration numbers scaled between the max and minimum value
    for(float i=0; i<= verticalIncrement; i++)
    {
      line(width-borderW, (height-borderH)-(tickIncrement*i), borderW-tickW, (height-borderH)-(tickIncrement*i));
      text(int((numberInc*i)+min), borderW-textIntH, (height-borderH)-(tickIncrement*i));
    }//end for
  }
}