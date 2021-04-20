final char ANGLE_UP = 'w';
final char ANGLE_DOWN = 's';

enum mode {
  FIRST, SECOND, THIRD
};

mode programMode = mode.FIRST;

void keyPressed()
{
  if(key == '1') {
    programMode = mode.FIRST;
  }

  if(key == '2') {
    programMode = mode.SECOND;
  }
  
  if(key == '3') {
    programMode = mode.THIRD;
  }
  if(key == ANGLE_UP) {
    if(programMode == mode.FIRST)
    {
      anchor.angle -= radians(5);
      b.angle -= radians(5);
      c.angle -= radians(5);
    }
    else if(programMode == mode.SECOND)
    {
      b.angle -= radians(5);
      c.angle -= radians(5);
    }
    else 
      c.angle -= radians(5);
  }

  if(key == ANGLE_DOWN) {
    if(programMode == mode.FIRST)
    {
      anchor.angle += radians(5);
      b.angle += radians(5);
      c.angle += radians(5);
    }
    else if(programMode == mode.SECOND)
    {
      b.angle += radians(5);
      c.angle += radians(5);
    }
    else 
      c.angle += radians(5);
  }
}

void announceSettings()
{
}
