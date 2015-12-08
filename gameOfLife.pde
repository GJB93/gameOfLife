import controlP5.*;
ControlP5 cp5;
Accordion accordion;
RadioButton r;

ArrayList<Integer> totalDeaths;
ArrayList<Integer> totalBirths;
ArrayList<Integer> totalOverC;
ArrayList<Integer> totalLonl;
ArrayList<Integer> lonlOverC;
ArrayList<Integer> totalSurv;
ArrayList<Integer> genDeaths;
ArrayList<Integer> genBirths;
ArrayList<Integer> genOverC;
ArrayList<Integer> genLonl;
ArrayList<Integer> genSurv;
ArrayList<Integer> generation;

Graph deathGraph;
Graph vsGraph;
Graph genGraph;

float borderW, borderH;

int maxInit=Integer.MIN_VALUE;
int minInit=Integer.MAX_VALUE;
int minDB = 0;
int maxDB = maxInit;
int maxLO = maxInit;
int minGDB = 0;
int maxGDB = maxInit;


int mode = 0;
int elapsed = 0;
int updateRate = 0;
int screenDivision = 10;
int rows;
int cols;
boolean start;

void setup()
{
  size(500, 500);
  frameRate(60);
  borderW = width*0.1f;
  borderH = height*0.1f;
  
  rows = int(height/screenDivision);
  cols = int(width/screenDivision);
  board = new Board(rows, cols);
  
  //createGliderGun(6, 8);
  start = false;
   
  totalDeaths = new ArrayList<Integer>();
  totalBirths = new ArrayList<Integer>();
  lonlOverC = new ArrayList<Integer>();
  lonlOverC.add(0);
  lonlOverC.add(0);
  totalSurv = new ArrayList<Integer>();
  genDeaths = new ArrayList<Integer>();
  genBirths = new ArrayList<Integer>();
  genOverC = new ArrayList<Integer>();
  genLonl = new ArrayList<Integer>();
  genSurv = new ArrayList<Integer>();
  generation = new ArrayList<Integer>();
  
  gui();
}

Board board;


void draw()
{
  background(50);
  
  switch(mode)
  {
    case 0:
    {
      board.render();
      break;
    }
      
    case 1:
    {
      createGliderGun(0, 0);
      r.activate(0);
      mode = 0;
      break;
    }
    
    case 2:
    {
      randomBoard();
      start = false;
      r.activate(0);
      mode = 0;
      break;
    }
    
    case 3:
    {
      board = new Board(rows, cols);
      start = false;
      r.activate(0);
      mode = 0;
      break;
    }
    
    case 4:
    {
      start = true;
      elapsed = 0;
      r.activate(0);
      mode = 0;
      break;
    } 
  }
  
  if(start && elapsed == updateRate)
  {
    board.update();
    elapsed = 0;
  }
  else
  {
    elapsed++;
  }
}


void gui()
{
  //Creating a new ControlP5 object
  cp5 = new ControlP5(this);
  
  /*
    Creating an accordion group that will hold radio buttons
    to allow the user to switch between the different groups
    of graphs
  */
  Group g1 = cp5.addGroup("Choose Graph").setBackgroundColor(color(255)).setBackgroundHeight(200);
  
  /*
    Creating the radio buttons for switching graphs
  */
  r = cp5.addRadioButton("radio")
    .setPosition(10, 20)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Game of Life Simulation", 0)
    .addItem("Create Glider Gun", 1)
    .addItem("Random Board", 2)
    .addItem("Clear Board", 3)
    .addItem("Start Simulation", 4)
    .setColorLabel(color(0))
    .activate(0)
    .moveTo(g1)
    ;
  
  /*
    Creating an accordion that holds the menu options
  */
  accordion = cp5.addAccordion("acc")
                  .setPosition(width-210, 20)
                  .setWidth(200)
                  .addItem(g1)
                  ;
  
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {mode = 4;}}, 's');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {mode = 3;}}, 'c');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {mode = 2;}}, 'r');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.hide();}}, 'h');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.show();}}, 'd');
  //Allowing multiple accordion groups to be open
  accordion.setCollapseMode(Accordion.MULTI);
  //Setting the accordion to be open by default
  accordion.open(0);
}

void randomBoard()
{
  int minDB = 0;
  board = new Board(rows, cols);
  
  for(int row=0; row<rows; row++)
  {
    for(int col=0; col<cols; col++)
    {
      float ranNum = random(0,1);
      if(ranNum > 0.5f)
      {
        board.set(row,col, true);
      }
      else
      {
        board.set(row,col, false);
      }
    }
  }
  
  totalDeaths = new ArrayList<Integer>();
  totalBirths = new ArrayList<Integer>();
  lonlOverC = new ArrayList<Integer>();
  lonlOverC.add(0);
  lonlOverC.add(0);
  totalSurv = new ArrayList<Integer>();
  genDeaths = new ArrayList<Integer>();
  genBirths = new ArrayList<Integer>();
  genOverC = new ArrayList<Integer>();
  genLonl = new ArrayList<Integer>();
  genSurv = new ArrayList<Integer>();
  generation = new ArrayList<Integer>();
  
  maxDB = maxInit;
  maxLO = maxInit;
  minGDB = 0;
  maxGDB = maxInit;
  
  gui();
}

/*
  The radio method controls what happens when
  each radio button is pressed
*/
void radio(int theC)
{
  /*
    The switch statement controls which mode the
    program enters depending on the radio button
    chosen
  */
  switch(theC)
  {
    case 0:
    {
      mode = 0;
      break;
    }
    
    case 1:
    {
      mode = 1;
      break;
    }
    
    case 2:
    {
      mode = 2;
      break;
    }
    
    case 3:
    {
      mode = 3;
      break;
    }
    
    case 4:
    {
      mode = 4;
      break;
    }
    
    case 5:
    {
      mode = 5;
      break;
    }
    
    case 6:
    {
      mode = 6;
      break;
    }
    
    case 7:
    {
      mode = 7;
      break;
    }
  }
}

void mouseDragged()
{
  int i = int(map(mouseX, 0, width, 0, cols));
  int j = int(map(mouseY, 0, height, 0, rows));
  
  if(mouseButton == LEFT)
  {
    board.set(j, i, true);
  } else if(mouseButton == RIGHT)
  {
    board.set(j, i, false);
  }
}

void createGliderGun(int initalRow, int initialCol)
{
  int minDB = 0;
  board = new Board(rows, cols);
  //Left Square
  board.set(initalRow+5, initialCol+1, true);
  board.set(initalRow+5, initialCol+2, true);
  board.set(initalRow+6, initialCol+1, true);
  board.set(initalRow+6, initialCol+2, true);
  
  //Left 3 block
  board.set(initalRow+6, initialCol+11, true);
  board.set(initalRow+5, initialCol+11, true);
  board.set(initalRow+7, initialCol+11, true);
  
  //C shape
  board.set(initalRow+8, initialCol+12, true);
  board.set(initalRow+4, initialCol+12, true);
  board.set(initalRow+3, initialCol+13, true);
  board.set(initalRow+3, initialCol+14, true);
  board.set(initalRow+9, initialCol+13, true);
  board.set(initalRow+9, initialCol+14, true);
  
  //Dot
  board.set(initalRow+6, initialCol+15, true);
  
  //Spaceshippy thing
  board.set(initalRow+4, initialCol+16, true);
  board.set(initalRow+8, initialCol+16, true);
  board.set(initalRow+7, initialCol+17, true);
  board.set(initalRow+6, initialCol+17, true);
  board.set(initalRow+5, initialCol+17, true);
  board.set(initalRow+6, initialCol+18, true);
  
  
  //Rectangle 6 block
  board.set(initalRow+5, initialCol+21, true);
  board.set(initalRow+4, initialCol+21, true);
  board.set(initalRow+3, initialCol+21, true);
  board.set(initalRow+5, initialCol+22, true);
  board.set(initalRow+4, initialCol+22, true);
  board.set(initalRow+3, initialCol+22, true);
  
  //Top right and bottom left
  board.set(initalRow+2, initialCol+23, true);
  board.set(initalRow+6, initialCol+23, true);
  
  //Top 2 line
  board.set(initalRow+2, initialCol+25, true);
  board.set(initalRow+1, initialCol+25, true);
  
  //Bottom 2 line
  board.set(initalRow+6, initialCol+25, true);
  board.set(initalRow+7, initialCol+25, true);
  
  //Right Square
  board.set(initalRow+4, initialCol+35, true);
  board.set(initalRow+3, initialCol+35, true);
  board.set(initalRow+4, initialCol+36, true);
  board.set(initalRow+3, initialCol+36, true);
}

void createGraphs()
{
  totalDeaths.add(board.death);
  totalBirths.add(board.birth);
  lonlOverC.set(0, board.overcrowding);
  lonlOverC.set(1, board.lonliness);
  totalSurv.add(board.survive);
  genDeaths.add(board.genDeath);
  genBirths.add(board.genBirth);
  genOverC.add(board.genOvercrowding);
  genLonl.add(board.genLonliness);
  genSurv.add(board.genSurvive);
  generation.add(board.generation);
  
  if(board.generation == 0)
  {
    if(totalDeaths.get(0) > totalBirths.get(0) && totalDeaths.get(0) > totalSurv.get(0))
    {
      maxDB = totalDeaths.get(0);
    }
    else if(totalBirths.get(0) > totalDeaths.get(0) && totalBirths.get(0) > totalSurv.get(0))
    {
      maxDB = totalBirths.get(0);
    }
    else
    {
      maxDB = totalSurv.get(0);
    }
  }
  
  if(board.overcrowding > board.lonliness)
  {
    maxLO = board.overcrowding;
  }
  else
  {
    maxLO = board.lonliness;
  }
  
  if(board.death > board.birth && board.death > board.survive)
  {
    maxDB = board.death;
  }
  else if(board.birth > board.death && board.birth > board.survive)
  {
    maxDB = board.birth;
  }
  else
  {
    maxDB = board.survive;
  }
  
  if(board.genDeath > maxGDB)
  {
    maxGDB = board.genDeath;
  }
  
  if(board.genBirth > maxGDB)
  {
    maxGDB = board.genBirth;
  }
  
  if(board.genSurvive > maxGDB)
  {
    maxGDB = board.genSurvive;
  }
  
  deathGraph = new Graph("Total Births vs Deaths", totalDeaths, totalBirths, totalSurv, generation, maxDB, minDB, borderW, borderH, color(255, 0, 0), color(0,255,0), color(255));
  vsGraph = new Graph("Lonliness vs Overcrowding", lonlOverC, generation, maxLO, 0, borderW, borderH, color(0));
  genGraph = new Graph("Births vs Deaths per Generation", genDeaths, genBirths, genSurv, generation, maxGDB, minGDB, borderW, borderH, color(255, 0, 0), color(0,255,0), color(255));
}