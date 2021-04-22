final char DEMO = 'd';
final char NORMAL = 'n';
final char BRANCH = 'b';
final char CONSTRAINT = 'c';
final char NEXT_STEP = ' '; 

enum mode {
  DEMO, NORMAL, BRANCH, CONSTRAINT
};

mode programMode = mode.DEMO;

void keyPressed()
{
  if(key == DEMO) {
    programMode = mode.DEMO;
  }

  if(key == NORMAL) {
    programMode = mode.NORMAL;
  }

  if(key == BRANCH) {
    programMode = mode.BRANCH;
  }

  if(key == CONSTRAINT) {
    programMode = mode.CONSTRAINT;
  }

  if(key == NEXT_STEP) {
    if(programMode == mode.DEMO) {
      IKDemo.increaseCount();
      print("Demo step:" + IKDemo.demoCounter + "\n");
    } 
  }
}
