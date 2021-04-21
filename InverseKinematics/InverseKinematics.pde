/*
  Michael Bathie, 7835010
  IK demonstration using FABRIK
*/

PVector joints[];
EndEffector endPoint;

Chain IK;


PVector jointDemo[];
EndEffector endPointDemo;

Chain IKDemo;

void setup() {
  size(800,800);
  colorMode(RGB, 1.0f);
  strokeWeight(3);

  joints = new PVector[4];

  joints[0] = new PVector(width/2, height);
  joints[1] = new PVector(width/2, 700);
  joints[2] = new PVector(width/2, 600);
  joints[3] = new PVector(width/2, 500);
  
  endPoint = new EndEffector(width/2, height/2, 20);

  IK = new Chain(joints, endPoint);


  jointDemo = new PVector[4];

  jointDemo[0] = new PVector(100, 200);
  jointDemo[1] = new PVector(200, 500);
  jointDemo[2] = new PVector(400, 700);
  jointDemo[3] = new PVector(600, 600);

  endPointDemo = new EndEffector(700, 300, 20);

  IKDemo = new Chain(jointDemo, endPointDemo, "demonstration");  
  IKDemo.fabrikDemo();
}

void draw() {
  background(0.7);
  fill(0,0,0);
  stroke(0,0,0);

  if(programMode == mode.DEMO) {
    doDemo();
  } else {
   endPoint.display();
  }

}

//can put check in a loop for more than one end point
void mouseDragged() {
  if(endPoint.checkBounds()) {
    endPoint.point.x = mouseX;
    endPoint.point.y = mouseY;
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