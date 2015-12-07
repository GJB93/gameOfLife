class Position
{
  PVector pos;
  int row;
  int col;
  
  Position()
  {
    this(new PVector(0,0), 0, 0);
  }
  
  Position(PVector pos, int row, int col)
  {
    this.pos = pos.copy();
    this.row = row;
    this.col = col;
  }
}