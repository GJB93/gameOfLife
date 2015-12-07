import controlP5.*;
ControlP5 cp5;
Accordion accordion;

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
int minDB = minInit;
int maxDB = maxInit;
int maxLO = maxInit;
int minGDB = 0;
int maxGDB = maxInit;


int mode = 0;

void setup()
{
  size(1000, 700);
  frameRate(60);
  borderW = width*0.1f;
  borderH = height*0.1f;
  
  int initNum = 500;
  int rows = int(height/10);
  int cols = int(width/10);
  board = new Board(rows, cols);
  for(int i=0; i<initNum; i++)
  {
    board.set(int(random(rows-1)),int(random(cols-1)), true);
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
      deathGraph.drawTrendLine();
      break;
    }
    
    case 2:
    {
      genGraph.drawTrendLine();
      break;
    }
  }
  if(!board.end)
  {
    board.update();
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
    
    if(board.generation == 1)
    {
      if(totalDeaths.get(0) > totalBirths.get(0))
      {
        minDB = totalBirths.get(0);
        maxDB = totalDeaths.get(0);
      }
      else
      {
        minDB = totalDeaths.get(0);
        maxDB = totalBirths.get(0);
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
    
    if(board.death > board.birth)
    {
      maxDB = board.death;
    }
    else
    {
      maxDB = board.birth;
    }
    
    if(board.genDeath > maxGDB)
    {
      maxGDB = board.genDeath;
    }
    
    if(board.genBirth > maxGDB)
    {
      maxGDB = board.genBirth;
    }
    
    deathGraph = new Graph("Total Births vs Deaths", totalDeaths, totalBirths, generation, maxDB, minDB, borderW, borderH, color(255, 0, 0), color(0,255,0));
    vsGraph = new Graph("Lonliness vs Overcrowding", lonlOverC, generation, maxLO, 0, borderW, borderH, color(0));
    genGraph = new Graph("Births vs Deaths per Generation", genDeaths, genBirths, generation, maxGDB, minGDB, borderW, borderH, color(255, 0, 0), color(0,255,0));
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
  Group g1 = cp5.addGroup("Choose Graph").setBackgroundColor(color(255, 50)).setBackgroundHeight(150);
  
  /*
    Creating the radio buttons for switching graphs
  */
  cp5.addRadioButton("radio")
    .setPosition(10, 20)
    .setItemWidth(20)
    .setItemHeight(20)
    .addItem("Game of Life Simulation", 0)
    .addItem("Total Births vs Deaths", 1)
    .addItem("Births vs Deaths per Gen", 2)
    .setColorLabel(color(255))
    .activate(0)
    .moveTo(g1)
    ;
  
  /*
    Creating an accordion that holds the menu options
  */
  accordion = cp5.addAccordion("acc")
                  .setPosition(10, 20)
                  .setWidth(200)
                  .addItem(g1)
                  ;
  //Allowing multiple accordion groups to be open
  accordion.setCollapseMode(Accordion.MULTI);
  //Setting the accordion to be open by default
  accordion.open(0);
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
  }
}