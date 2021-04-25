final char DEMO = 'd';
final char NORMAL = 'n';
final char BRANCH = 'b';
final char CONSTRAINT = 'c';
final char MOB = 'm';
final char LONG = 'l';
final char GEN = 'g';
final char GO = ENTER;
final char WIPE = 'w';
final char FOLLOW = 'f';
final char TENT = 't';
final char NEXT_STEP = ' '; 

boolean tent = false;

enum mode {
  DEMO, NORMAL, BRANCH, CONSTRAINT, MOB, LONG, GEN, GO, FOLLOW;
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

  if(key == MOB) {
    programMode = mode.MOB;
  }

  if(key == LONG) {
    programMode = mode.LONG;
  }

  if(key == GEN) {
    programMode = mode.GEN;
  }

  if(key == GO && programMode == mode.GEN) {
    finalize();
    programMode = mode.GO;
  }

  if(key == WIPE) {
    wipe();
  }

  if(key == FOLLOW) {
    programMode = mode.FOLLOW;
  }

  if(key == TENT) {
    tent = !tent;
  }

  if(key == NEXT_STEP) {
    if(programMode == mode.DEMO) {
      IKDemo.increaseCount();
      print("Demo step:" + IKDemo.demoCounter + "\n");
    } 
  }
}
