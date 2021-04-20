PVector endEffector = new PVector(400,400);

void setup() {
  size(800,800);
  colorMode(RGB, 1.0f);
}

void draw() {
  background(0.8);
  fill(0.4, 0.8, 0.4);
  circle(endEffector.x, endEffector.y, 50);
}
