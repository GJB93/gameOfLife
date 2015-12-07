class Board
{
  ArrayList<Position> cellPositions;
  int rows;
  int cols;
  int overcrowding;
  int genOvercrowding;
  int lonliness;
  int genLonliness;
  int birth;
  int genBirth;
  int death;
  int genDeath;
  int survive;
  int genSurvive;
  int generation;
  float cellWidth;
  float cellHeight;
  boolean[][] cells;
  boolean[][] nextCells;
  boolean end;
 
    
  Board(int rows, int cols)
  {
    this.rows = rows;
    this.cols = cols;
    overcrowding = 0;
    lonliness = 0;
    birth = 0;
    death = 0;
    genOvercrowding = 0;
    genLonliness = 0;
    genBirth = 0;
    genDeath = 0;
    genSurvive = 0;
    generation = 0;
    cells = new boolean[rows][cols]; 
    nextCells = new boolean[rows][cols];
    end = false;
    cellPositions = new ArrayList<Position>();
     
    cellWidth = width  / cols;
    cellHeight = height  / rows;
  }  
 
  void render()
  {
    for(int row=0; row<rows; row++)
    {
       for(int col=0; col<cols; col++)
       {
         float x = col * cellHeight;
         float y = row * cellWidth;
         if(cells[row][col])
         {
           stroke(255);
           fill(255);
         }
         else
         {
           stroke(50);
           fill(0);
         }
         rect(x,y,cellHeight,cellWidth);
       }
     }
   }
   
  void update()
  {
    genOvercrowding = 0;
    genLonliness = 0;
    genBirth = 0;
    genDeath = 0;
    genSurvive = 0;
     
    for(int row = 0; row < rows; row++)
    {
      for(int col = 0; col < cols; col++)
      {
        
        if(countLiveCells(row, col) >= 2 && countLiveCells(row, col) <= 3)
        {
          nextCells[row][col] = cells[row][col];
          genSurvive++;
        }
        
        if(countLiveCells(row, col) == 3)
        {
          nextCells[row][col] = true;
          birth++;
          genBirth++;
        }
        
        if(countLiveCells(row, col) > 3)
        {
          nextCells[row][col] = false;
          overcrowding++;
          genOvercrowding++;
          genDeath++;
          death++;
        }
        
        if(countLiveCells(row, col) < 2)
        {
          nextCells[row][col] = false;
          lonliness++;
          genLonliness++; 
          genDeath++;
          death++;
        }
      }
    }
     
    if(genBirth == 0 && genDeath == 0)
    {
      end = true;
    }
    else
    {
      survive += genSurvive;
      generation++;
      //boolean[][] temp = cells;
      cells = nextCells;
      nextCells = new boolean[rows][cols];
      //nextCells = temp;
    }
  }
   
  int countLiveCells(int row, int col)
  {
    int count = 0;
     
    if(get(row-1,col-1))
    {
      count++;
    }
     
    if(get(row-1,col))
    {
      count++;
    }
     
    if(get(row-1,col+1))
    {
      count++;
    }
     
    if(get(row,col-1))
    {
      count++;
    }
     
    if(get(row,col+1))
    {
      count++;
    }
     
    if(get(row+1,col-1))
    {
      count++;
    }
     
    if(get(row+1,col))
    {
      count++;
    }
     
    if(get(row+1,col+1))
    {
      count++;
    }
   
    return count;
  }
 
  void set(int row, int col, boolean value)
  {
    if (row >= 0 && row < rows && col >= 0 && col < cols && !cells[row][col])
    {
      float x = col * cellHeight;
      float y = row * cellWidth;
      cells[row][col] = value;
      survive++;
      cellPositions.add(new Position(new PVector(x, y), row, col));
    }
  }  
   
  boolean get(int row, int col)
  {
    if (row >= 0 && row < rows && col >= 0 && col < cols)
    {
      return cells[row][col];
    }
    else
    {
      return false;
    }
  } 
}