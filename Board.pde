class Board
{
   int rows;
   int cols;
   int overcrowding;
   int lonliness;
   int birth;
   int survive;
   int generation;
   float cellWidth;
   float cellHeight;
   boolean[][] cells;
   boolean[][] nextCells;
 
    
   Board(int rows, int cols)
   {
     this.rows = rows;
     this.cols = cols;
     overcrowding = 0;
     lonliness = 0;
     birth = 0;
     survive = 0;
     generation = 0;
     cells = new boolean[rows][cols]; 
     nextCells = new boolean[rows][cols];
     
     cellWidth = width  / cols;
     cellHeight = height  / rows;
   }  
 
   void render()
   {
     for(int row = 0; row < rows; row++)
     {
        for(int col = 0; col < cols; col++)
       {
         float  x = col * cellHeight;
         float  y = row * cellWidth;
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
     for(int row = 0; row < rows; row++)
     {
       for(int col = 0; col < cols; col++)
       {
         if(!get(row,col) && countLiveCells(row, col) == 3)
         {
           nextCells[row][col] = true;
           birth++;
         }
         
         if(get(row,col) && countLiveCells(row, col) >= 2 && countLiveCells(row, col) <= 3)
         {
           nextCells[row][col] = true;
           //survive++;
         }
         
         if(get(row,col) && countLiveCells(row, col) > 3)
         {
           nextCells[row][col] = false;
           overcrowding++;
         }
         
         if(get(row,col) && countLiveCells(row, col) < 2)
         {
           nextCells[row][col] = false;
           lonliness++;
         }
       }
     }
     
     generation++;
     //boolean[][] temp = cells;
     cells = nextCells;
     //nextCells = temp;
     
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
     if (row >= 0 && row < rows && col >= 0 && col < cols)
     {
       cells[row][col] = value;
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