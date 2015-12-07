import controlP5.*;
ControlP5 cp5;
Accordion accordion;

int mode = 0;

void setup()
{
  size(1000, 700);
  frameRate(60);
  int initNum = 500;
  int rows = int(height/10);
  int cols = int(width/10);
  board = new Board(rows, cols);
  for(int i=0; i<initNum; i++)
  {
    board.set(int(random(rows-1)),int(random(cols-1)), true);
  }
  gui();
}

Board board;

void draw()
{
  background(50);
  switch(mode)
  {
    case 0:
    board.render();
  }
  if(!board.end)
  {
    board.update();
  }
  fill(100);
  rect(width*0.20f, height*0.025f, 300, 200);
  fill(255);
  text("Generation: " + board.generation, width*0.25f, height*0.05f);
  fill(255, 0, 0);
  text("Died of overcrowding: " + board.overcrowding, width*0.25f, height*0.1f);
  text("Died of lonliness: " + board.lonliness, width*0.25f, height*0.15f);
  fill(0, 255, 0);
  text("Born: " + board.birth, width*0.25f, height*0.2f);
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