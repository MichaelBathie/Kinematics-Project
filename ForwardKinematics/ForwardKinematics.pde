Arm anchor = new Arm(400,400, 100, radians(60));
Arm b = new Arm(anchor, 100, radians(-40));
Arm c = new Arm(b, 100, radians(50));

void setup() {
  size(800,800);
  colorMode(RGB, 1.0f);
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
}
