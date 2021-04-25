/*
  Michael Bathie, 7835010
  IK demonstration using FABRIK
*/
ArrayList<PVector> trackClicks;
PVector generate[];
Chain g;

PVector joints[];
PVector branchJoints[];
PVector branchExtra[];
PVector manyJoints[];
PVector tentJoints[];
EndEffector endPoint;
EndEffector branchEnds[];
EndEffector branchExtraEnd;

Chain IK;
Chain longChain;
Chain branch[];
Chain bExtra;
Chain tentChain[];


PVector jointDemo[];
EndEffector endPointDemo;

Chain IKDemo;

PVector member[];
EndEffector mobEnd;
EndEffector mobReal[];
Chain mob[];
float mobAngle;

void setup() {
  size(800,800);
  colorMode(RGB, 1.0f);
  strokeWeight(3);

  trackClicks= new ArrayList<PVector>();

  /*=== DEMO SETUP ===*/
  jointDemo = new PVector[4];

  jointDemo[0] = new PVector(100, 200);
  jointDemo[1] = new PVector(200, 500);
  jointDemo[2] = new PVector(400, 700);
  jointDemo[3] = new PVector(600, 600);

  endPointDemo = new EndEffector(700, 300, 20);

  IKDemo = new Chain(jointDemo, endPointDemo, "demonstration");  
  IKDemo.fabrikDemo();

  /*==================*/

  /*=== STANDARD SETUP ===*/

  joints = new PVector[5];

  joints[0] = new PVector(width/2, height);
  joints[1] = new PVector(width/2, 650);
  joints[2] = new PVector(width/2, 500);
  joints[3] = new PVector(width/2, 350);
  joints[4] = new PVector(width/2, 200);
  
  endPoint = new EndEffector(width/2 + 100, height/2, 20);

  IK = new Chain(joints, endPoint);

  /*======================*/

  /*=== BRANCH SETUP ===*/

  branchJoints = new PVector[5];
  branchEnds = new EndEffector[5];
  branch = new Chain[5];
  branchExtra = new PVector[5];
  branchExtraEnd = new EndEffector(100, 100, 20);

  int newHeight = height / joints.length;
  for(int i = 0; i < joints.length; i++) {
    branchJoints[0] = joints[i];
    branchJoints[1] = new PVector(width/2, branchJoints[0].y - 50);
    branchJoints[2] = new PVector(width/2, branchJoints[0].y - 100);
    branchJoints[3] = new PVector(width/2, branchJoints[0].y - 150);
    branchJoints[4] = new PVector(width/2, branchJoints[0].y - 200);

    if(i % 2 == 0) {
      branchEnds[i] = new EndEffector(width/4, i*newHeight + (newHeight/2), 20);
    } else {
      branchEnds[i] = new EndEffector(3*width/4, i*newHeight + (newHeight/2), 20);
    }
    branch[i] = new Chain(branchJoints, branchEnds[i], IK, i);
  }

  branchExtra[0] = branch[2].forward[2];
  branchExtra[1] = new PVector(width/2, branchExtra[0].y - 50);
  branchExtra[2] = new PVector(width/2, branchExtra[0].y - 100);
  branchExtra[3] = new PVector(width/2, branchExtra[0].y - 150);
  branchExtra[4] = new PVector(width/2, branchExtra[0].y - 200);
  bExtra = new Chain(branchExtra, branchExtraEnd, branch[2], 2);

  /*====================*/

  /*=== MOB SETUP ===*/

  member = new PVector[5];
  mob = new Chain[800];
  mobReal = new EndEffector[800];
  mobAngle = PI/400;
  float mobRadius = 400;
  mobEnd = new EndEffector(width/2 + 100, height/2, 20);

  for(int i = 0; i < 800; i++) {
    float x = mobRadius * cos(i*mobAngle) + width/2;
    float y = mobRadius * sin(i*mobAngle) + height/2;

    if(i%2 == 0) {
      if(x <= 400) {
        x = random(-300, 300);
      } else {
        x = random(500, 1100);
      }
    } else {
      if(y <= 400) {
        y = random(-300, 300);
      } else {
        y = random(500, 1100);
      }
    }
    
    member[0] = new PVector(x, y);
    member[1] = new PVector(x + 50, y + 50);
    member[2] = new PVector(x + 100, y + 100);
    member[3] = new PVector(x + 150, y + 150);
    member[4] = new PVector(x + 200, y + 200);
    mobReal[i] = new EndEffector(width/2 + 100, height/2 + 100, 20);

    mob[i] = new Chain(member, mobReal[i]);
  }

  /*=================*/

  /*=== LONG CHAIN SETUP ===*/

  manyJoints = new PVector[20];
  manyJoints[0] = new PVector(width/2, height);
  int yAdd = 50;
  for(int i = 1; i < manyJoints.length; i++) {
    manyJoints[i] = new PVector(width/2, height - i*yAdd);
  }
  longChain = new Chain(manyJoints, endPoint);

  /*========================*/

  /*=== TENT SETUP ===*/

  tentJoints = new PVector[10];
  tentChain = new Chain[100];
  float tentAngle = PI/50;
  float tentRadius = 200;

  for(int i = 0; i < tentChain.length; i++) {
    float x = tentRadius * cos(i*tentAngle) + width/2;
    float y = tentRadius * sin(i*tentAngle) + height/2;

    tentJoints[0] = new PVector(x,y);
    for(int j = 1; j < tentJoints.length; j++) {
      tentJoints[j] = new PVector(x+(j*20), y+(j*20));
    }

    tentChain[i] = new Chain(tentJoints, endPoint);
  }
  /*==================*/
}

void draw() {
  background(0.7);
  fill(0,0,0);
  stroke(0,0,0);

  if(programMode == mode.DEMO) {
    doDemo();

  } else if(programMode == mode.NORMAL) {
    IK.fabrik();
    IK.display();
    endPoint.display();

  } else if(programMode == mode.BRANCH) {
    stroke(0,0,0.3);
    fill(0,0,0.3);
    bExtra.fabrik();
    bExtra.display();
    branchExtraEnd.display(new PVector(0,0,1));

    for(int i = 0; i < branch.length; i++) {
      stroke(0,0.3,0);
      fill(0,0.3,0);
      branch[i].fabrik();
      branch[i].display();
      branchEnds[i].display(new PVector(0,1,0));
    }

    stroke(0.3,0,0);
    fill(0.3,0,0);
    IK.fabrik();
    IK.display();
    endPoint.display(new PVector(1,0,0));

  } else if(programMode == mode.CONSTRAINT) {
    IK.fabrik();
    IK.display();
    endPoint.display();

  } else if(programMode == mode.MOB){
    stroke(0,1,0);
    for(int i = 0; i < mob.length; i++) {
      mob[i].fabrik();
      mob[i].displayMob(i%3);
    }
    mobEnd.display();

  } else if(programMode == mode.LONG) {
    longChain.fabrik();
    longChain.display();
    endPoint.display();

  } else if(programMode == mode.GEN) {
    PVector temp;
    for(int i = 0; i < trackClicks.size(); i++) {
      temp = trackClicks.get(i);
      circle(temp.x, temp.y, 30);
    }
  } else if(programMode == mode.GO) {
    if(generate != null && generate.length > 2) {
      g.fabrik();
      g.display();
      endPoint.display();
    }
  } else if(programMode == mode.FOLLOW) {
    if(!tent) {
      IK.fabrik();
      IK.display();
      endPoint.display();
    } else {
      for(int i = 0; i < tentChain.length; i++) {
        tentChain[i].fabrik();
        tentChain[i].displayTent();
      }
      endPoint.display();
    }
  }

}

//loops through all endpoints and adjusts them
void mouseDragged() {
  if(programMode == mode.MOB && mobEnd.checkBounds()) {
    PVector temp;
    mobEnd.point.x = mouseX;
    mobEnd.point.y = mouseY;
    for(int i = 0; i < mobReal.length; i++) {
      temp = getMobPoint(i);
      mobReal[i].point.x = temp.x;
      mobReal[i].point.y = temp.y;
    }
    return;
  } 
  if(endPoint.checkBounds()) {
    endPoint.point.x = mouseX;
    endPoint.point.y = mouseY;
    return;
  } 
  if(branchExtraEnd.checkBounds()) {
    branchExtraEnd.point.x = mouseX;
    branchExtraEnd.point.y = mouseY;
    return;
  } 
  for(int i = 0; i < branchEnds.length; i++) {
    if(branchEnds[i].checkBounds()) {
      branchEnds[i].point.x = mouseX;
      branchEnds[i].point.y = mouseY;
      return;
    } 
  }
}

void mouseClicked() {
  if(programMode == mode.GEN) {
    trackClicks.add(new PVector(mouseX, mouseY));
  }
}

PVector getMobPoint(int num) {
  float x = 60 * cos(num*mobAngle);
  float y = 60 * sin(num*mobAngle);

  return new PVector(x+mouseX, y+mouseY);
}

void finalize() {
  generate = new PVector[trackClicks.size()];
  for(int i = 0; i < trackClicks.size(); i++) {
    generate[i] = trackClicks.get(i);
  }
  g = new Chain(generate, endPoint);
}

void wipe() {
  PVector temp;
  for(int i = trackClicks.size() - 1; i > -1; i--) {
    trackClicks.remove(trackClicks.get(i)); 
  }
  generate = new PVector[0];
}

//hard coded demo
void doDemo() {
  if(IKDemo.demoCounter > 14) {

    circle(IKDemo.demo[0].x, IKDemo.demo[0].y, 30);
    line(IKDemo.demo[0].x, IKDemo.demo[0].y, IKDemo.demo[1].x, IKDemo.demo[1].y);

    circle(IKDemo.demo[1].x, IKDemo.demo[1].y, 30);
    line(IKDemo.demo[1].x, IKDemo.demo[1].y, IKDemo.demo[2].x, IKDemo.demo[2].y);

    circle(IKDemo.demo[2].x, IKDemo.demo[2].y, 30);
    line(IKDemo.demo[2].x, IKDemo.demo[2].y, IKDemo.demo[3].x, IKDemo.demo[3].y);

    circle(IKDemo.demo[3].x, IKDemo.demo[3].y, 30);

    fill(0, 0, 0.7);
    stroke(0, 0, 0.7);

    circle(IKDemo.demo[8].x, IKDemo.demo[8].y, 30);

    line(IKDemo.demo[8].x, IKDemo.demo[8].y, IKDemo.demo[9].x, IKDemo.demo[9].y);

    circle(IKDemo.demo[9].x, IKDemo.demo[9].y, 30);
    line(IKDemo.demo[9].x, IKDemo.demo[9].y, IKDemo.demo[10].x, IKDemo.demo[10].y);

    circle(IKDemo.demo[10].x, IKDemo.demo[10].y, 30);
    line(IKDemo.demo[10].x, IKDemo.demo[10].y, IKDemo.demo[11].x, IKDemo.demo[11].y);

    circle(IKDemo.demo[11].x, IKDemo.demo[11].y, 30);

  } else {
    circle(IKDemo.demo[0].x, IKDemo.demo[0].y, 30);
    line(IKDemo.demo[0].x, IKDemo.demo[0].y, IKDemo.demo[1].x, IKDemo.demo[1].y);

    circle(IKDemo.demo[1].x, IKDemo.demo[1].y, 30);
    line(IKDemo.demo[1].x, IKDemo.demo[1].y, IKDemo.demo[2].x, IKDemo.demo[2].y);

    circle(IKDemo.demo[2].x, IKDemo.demo[2].y, 30);
    line(IKDemo.demo[2].x, IKDemo.demo[2].y, IKDemo.demo[3].x, IKDemo.demo[3].y);

    circle(IKDemo.demo[3].x, IKDemo.demo[3].y, 30);

    fill(0, 0.7, 0);
    stroke(0, 0.7, 0);

    if(IKDemo.demoCounter > 0)
      circle(IKDemo.demo[4].x, IKDemo.demo[4].y, 30);

    if(IKDemo.demoCounter > 1)
      line(IKDemo.demo[4].x, IKDemo.demo[4].y, IKDemo.demo[2].x, IKDemo.demo[2].y);

    if(IKDemo.demoCounter > 2)
      circle(IKDemo.demo[5].x, IKDemo.demo[5].y, 30);
    if(IKDemo.demoCounter > 3)
      line(IKDemo.demo[5].x, IKDemo.demo[5].y, IKDemo.demo[1].x, IKDemo.demo[1].y);

    if(IKDemo.demoCounter > 4)
      circle(IKDemo.demo[6].x, IKDemo.demo[6].y, 30);
    if(IKDemo.demoCounter > 5)
      line(IKDemo.demo[6].x, IKDemo.demo[6].y, IKDemo.demo[0].x, IKDemo.demo[0].y);

    if(IKDemo.demoCounter > 6)
      circle(IKDemo.demo[7].x, IKDemo.demo[7].y, 30);

    fill(0, 0, 0.7);
    stroke(0, 0, 0.7);

    if(IKDemo.demoCounter > 7)
      circle(IKDemo.demo[8].x, IKDemo.demo[8].y, 30);

    if(IKDemo.demoCounter > 8)
      line(IKDemo.demo[8].x, IKDemo.demo[8].y, IKDemo.demo[6].x, IKDemo.demo[6].y);

    if(IKDemo.demoCounter > 9)
      circle(IKDemo.demo[9].x, IKDemo.demo[9].y, 30);
    if(IKDemo.demoCounter > 10)
      line(IKDemo.demo[9].x, IKDemo.demo[9].y, IKDemo.demo[5].x, IKDemo.demo[5].y);

    if(IKDemo.demoCounter > 11)
      circle(IKDemo.demo[10].x, IKDemo.demo[10].y, 30);
    if(IKDemo.demoCounter > 12)
      line(IKDemo.demo[10].x, IKDemo.demo[10].y, IKDemo.demo[4].x, IKDemo.demo[4].y);

    if(IKDemo.demoCounter > 13)
      circle(IKDemo.demo[11].x, IKDemo.demo[11].y, 30);
  }

  endPointDemo.display();  
}