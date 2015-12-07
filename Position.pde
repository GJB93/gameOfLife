class Position
{
  PVector pos;
  int index;
  
  Position()
  {
    this(new PVector(0,0), 0);
  }
  
  Position(PVector pos, int index)
  {
    this.pos = pos.copy();
    this.inddex = index;
  }
}