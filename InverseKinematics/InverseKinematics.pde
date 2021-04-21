/*
  Michael Bathie, 7835010
  IK demonstration using FABRIK
*/

EndEffector endPoint;

void setup() {
  size(800,800);
  colorMode(RGB, 1.0f);

  endPoint = new EndEffector(width/2, height/2, 20);
}

void draw() {
  background(0.8);
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

