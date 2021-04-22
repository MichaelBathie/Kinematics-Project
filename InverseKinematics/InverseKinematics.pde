/*
  Michael Bathie, 7835010
  IK demonstration using FABRIK
*/

PVector joints[];
PVector branchJoints[];
EndEffector endPoint;
EndEffector branchEnds[];

Chain IK;
Chain branch[];


PVector jointDemo[];
EndEffector endPointDemo;

Chain IKDemo;

void setup() {
  size(800,800);
  colorMode(RGB, 1.0f);
  strokeWeight(3);

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

  joints = new PVector[5];

  joints[0] = new PVector(width/2, height);
  joints[1] = new PVector(width/2, 650);
  joints[2] = new PVector(width/2, 500);
  joints[3] = new PVector(width/2, 350);
  joints[4] = new PVector(width/2, 200);
  
  endPoint = new EndEffector(width/2 + 100, height/2, 20);

  IK = new Chain(joints, endPoint);

  branchJoints = new PVector[5];
  branchEnds = new EndEffector[5];
  branch = new Chain[5];

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
    IK.fabrik();
    IK.display();

    for(int i = 0; i < branch.length; i++) {
      stroke(0,0,0);
      fill(0,0,0);
      branch[i].fabrik();
      branch[i].display();
      branchEnds[i].display();
    }
    endPoint.display(new PVector(0,1,0));
  }

}

//can put check in a loop for more than one end point
void mouseDragged() {
  if(endPoint.checkBounds()) {
    endPoint.point.x = mouseX;
    endPoint.point.y = mouseY;
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