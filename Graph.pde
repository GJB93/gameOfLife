class Graph
{
  //Creating fields needed for drawing a graph
  Axis axis;
  ArrayList<Integer> dataset1;
  ArrayList<Integer> dataset2;
  ArrayList<Integer> data;
  ArrayList<Integer> names;
  int max;
  int min;
  int numOfDatasets;
  float borderW = width*0.1f; 
  float borderH;
  float graphW;
  float graphH;
  float rectWidth;
  color c1;
  color c2;
  String title;
  
  //Constructors for Graph class
  Graph()
  {
    this("", 0, 0, 0, 0, 0);
  }
  
  //Base constructor
  Graph(String title, int dataSize, int max, int min, float borderW, float borderH)
  {
    this.title = title;
    this.borderW = borderW; 
    this.borderH = borderH;
    this.max = max;
    this.min = min;
    graphW = width - (borderW*2.0f);
    graphH = height - (borderH*2.0f);
    rectWidth = graphW/ (float) (dataSize);
  }
  
  //Constructor that only uses a single colour for the graph
  Graph(String title, ArrayList<Integer> data1, ArrayList<Integer> data2, ArrayList<Integer> names, int max, int min, float borderW, float borderH, color c1, color c2)
  {
    this(title, data1.size(), max, min, borderW, borderH);
    this.dataset1 = new ArrayList<Integer>();
    this.dataset2 = new ArrayList<Integer>();
    this.names = new ArrayList<Integer>();
    this.dataset1.addAll(data1);
    this.dataset2.addAll(data2);
    this.names.addAll(names);
    this.numOfDatasets = 2;
    this.c1 = c1;
    this.c2 = c2;
  }
  
  
  //Constructor that uses an array of colours to draw the graph
  Graph(String title, ArrayList<Integer> data, ArrayList<Integer> names, int max, int min, float borderW, float borderH, color c)
  {
    this(title, data.size(), max, min, borderW, borderH);
    this.data = new ArrayList<Integer>();
    this.names = new ArrayList<Integer>();
    this.data.addAll(data);
    this.names.addAll(names);
    this.c1 = c;
  }
  
  //Method to draw a bar chart using the data input
  void drawBarChart()
  {
    //Write the graph title
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(title, width/2, borderH*0.5f);
    stroke(255);
    //For each element of data
    for(int i=0; i<data.size(); i++)
    {
      //Use the map method to determine the scale of the bar relevant to the graph width and height
      float x = map(i, 0, data.size(), borderW, borderW+graphW);
      float y = map(data.get(i), min, max, height-borderH, borderH);
      
      //Each bar has its own colour
      fill(255, 0, 0);
      //Draw the bar
      rect(x, y, rectWidth, (height-borderH)-y);
    }//end for 
    
    
    //Create a new axis for the bar chart
    axis = new Axis(data, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the bar chart
    axis.drawAxisLines();
    axis.drawBarXTicks();
    axis.drawYTicks();
    
  }
  
  //Method to draw a trend line using the data given
  void drawTrendLine()
  {
    //Write the graph title
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(title, width/2, borderH*0.5f);
    //There is one less line than there is data values when drawing a trend line graph
    rectWidth = graphW/ (float)(dataset1.size()-1);
    //Set the colour for the line
    
    //For each data value
    for(int i=1; i<dataset1.size(); i++)
    {
      //Use the map method to determine the scale of the line relevant to the graph width and height
      float x1 = map(i-1, 0, dataset1.size()-1, borderW, borderW+graphW);
      float y1 = map(dataset1.get(i-1), min, max, height-borderH, borderH);
      float x2 = map(i, 0, dataset1.size()-1, borderW, borderW+graphW);
      float y2 = map(dataset1.get(i), min, max, height-borderH, borderH);
      
      float x3 = map(i-1, 0, dataset2.size()-1, borderW, borderW+graphW);
      float y3 = map(dataset2.get(i-1), min, max, height-borderH, borderH);
      float x4 = map(i, 0, dataset2.size()-1, borderW, borderW+graphW);
      float y4 = map(dataset2.get(i), min, max, height-borderH, borderH);
      
      stroke(c1);
      
      //Draw the line from the element before to the current element
      line(x1, y1, x2, y2);
      
      stroke(c2);
      line(x3, y3, x4, y4);
    }//end for
    
    
    //Create a new axis for the trend line graph
    axis = new Axis(dataset1, names, max, min, borderW, borderH, rectWidth);
    
    //Draw the axis for the trend line graph
    axis.drawAxisLines();
    axis.drawXTicks();
    axis.drawYTicks();
    
  }
  
  /*
  //Method to draw a slopegraph for two sets of values
  void drawSlopeGraph()
  {
    //Setting some defaults used to draw the graph
    int numYears = 7;
    float x1 = map(width*0.25f, 0, width, borderW, borderW+graphW);
    float x2 = map(width-(width*0.25f), 0, width, borderW, borderW+graphW);
    float tWidth = 50;
    axis = new Axis();

    //Drawing the slopegraph axis
    axis.drawSlopeAxis();
    
    //Writing the title for the graph
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(title, width/2, borderH*0.5f);
    textSize(8);
    
      float y1 = map(preRecessionAvg, min, max, height-borderH, borderH);
      float y2 = map(postRecessionAvg, min, max, height-borderH, borderH);
      
      //Drawing the slope
      line(x1, y1, x2, y2);
    }
  }
  */
  
  /*
    Method used for tracking the mouse postition, which allows the user to
    see the specific value for each given year when howvering over the graph
  */
  void drawRegAmount()
  {
    if (mouseX >= borderW && mouseX <= width - borderW)
    {
      int i = (int) map(mouseX, borderW, width - borderW, 0, dataset1.size() - 1);
      float x = map(i, 0, dataset1.size()-1, borderW, borderW+graphW);
      float y = map(dataset1.get(i), min, max, height-borderH, borderH);
      textAlign(LEFT, CENTER);
      stroke(249, 241, 220);
      fill(249, 241, 220);
      rect(mouseX+10, y, 90, 30);
      stroke(255, 0, 0);
      fill(255, 0, 0);
      line(mouseX, borderH, mouseX, height - borderH);
      ellipse(x, y, 10, 10);
      fill(50);
      textSize(9);
      text("Year: " + names.get(i), mouseX+12, y+10);
      text("Sold: " + dataset1.get(i), mouseX+12, y+20);
    }
  }
}