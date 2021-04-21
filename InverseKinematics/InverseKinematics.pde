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

  IKDemo = new Chain(jointDemo, endPointDemo);  
}

void draw() {
  background(0.5);
  fill(0.4, 0.8, 0.4);

  endPoint.display();
}

//can put check in a loop for more than one end point
void mouseDragged() {
  if(endPoint.checkBounds()) {
    endPoint.point.x = mouseX;
    endPoint.point.y = mouseY;
  } 
}

