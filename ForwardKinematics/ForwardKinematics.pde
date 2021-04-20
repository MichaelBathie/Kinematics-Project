PVector start  = new PVector(100, 400);

Arm anchor = new Arm(start.x,start.y, 150, radians(60));
Arm b = new Arm(anchor, 150, radians(40));
Arm c = new Arm(b, 150, radians(40));


PFont font;

void setup() {
  size(800,800);
  colorMode(RGB, 1.0f);
  font = createFont("Arial", 16, true);
}

void draw() {
  background(0.8);
  strokeWeight(5);

  stroke(0.0,0.0,0.0);

  if(programMode == mode.FIRST)
    stroke(0.3, 0.3, 1.0);
  anchor.drawArm();

  if(programMode == mode.SECOND)
    stroke(0.3, 0.3, 1.0);
  b.recalculate(anchor);
  b.drawArm();

  if(programMode == mode.THIRD)
    stroke(0.3, 0.3, 1.0);
  c.recalculate(b);
  c.drawArm();

  printToScreen(calculateEndPoint());
}

void printToScreen(String message) {
  textFont(font, 36);
  fill(0);

  text(message, 20, 780);
}

//https://stackoverflow.com/questions/2663570/how-to-calculate-both-positive-and-negative-angle-between-two-lines
float angleBetweenLinesInRad(PVector line1Start, PVector line1End, PVector line2Start, PVector line2End) {
  float a = line1End.x - line1Start.x;
  float b = line1End.y - line1Start.y;
  float c = line2End.x - line2Start.x;
  float d = line2End.y - line2Start.y;

  float atanA = atan2(a, b);
  float atanB = atan2(c, d);

  return atanA - atanB;
}

String calculateEndPoint() {
  String coordinate = "could not calculate the coordinate";

  PVector vi = new PVector(0, 0);
  PVector vj = new PVector(100, 0);

  float a1 = angleBetweenLinesInRad(vi, vj, anchor.startPoint, anchor.endPoint); 
  float a2 = angleBetweenLinesInRad(anchor.startPoint, anchor.endPoint, b.startPoint, b.endPoint); 
  float a3 = angleBetweenLinesInRad(b.startPoint, b.endPoint, c.startPoint, c.endPoint); 

  float c1 = cos(a1);
  float c12 = cos(a1 + a2);
  float c123 = cos(a1 + a2 + a3);
  float s1 = sin(a1);
  float s12 = sin(a1 + a2);
  float s123 = sin(a1 + a2 + a3);

  int x = int((anchor.length * c1) + (b.length * c12) + (c.length * c123));
  int y = int((anchor.length * s1) + (b.length * s12) + (c.length * s123));

  int newX = x + int(start.x);
  int newY = y + int(start.y);

  coordinate = "End point is: ( " + newX + " , " + newY + " )";

  fill(1,0,0);
  circle(x + start.x, y + start.y, 30);

  return coordinate;
}

