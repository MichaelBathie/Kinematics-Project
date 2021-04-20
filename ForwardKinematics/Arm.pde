class Arm {
  PVector startPoint;
  PVector endPoint;
  float angle;
  float length;

  PVector colour = new PVector(0.6,0.1,0.5);

  //for the first arm 
  Arm(float startX, float startY, float length, float angle) {
    this.length = length;
    this.angle = angle;
    this.startPoint = new PVector(startX, startY);
    getEndPoint();
  }

  //for each subsequent arm
  Arm(Arm parent, float length, float angle) {
    this.length = length;
    this.angle = angle;
    this.startPoint = new PVector(parent.endPoint.x, parent.endPoint.y);
    getEndPoint();
  }

  void getEndPoint() {
    float dx = length * cos(angle);
    float dy = length * sin(angle);
    this.endPoint = new PVector(startPoint.x + dx, startPoint.y + dy);
  }

  void recalculate(Arm parent) {
    this.startPoint = new PVector(parent.endPoint.x, parent.endPoint.y);
  }

  void drawArm() {
    getEndPoint();
    line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);
    fill(this.colour.x, this.colour.y, this.colour.z); 
    circle(this.startPoint.x, this.startPoint.y, 30);
    circle(this.endPoint.x, this.endPoint.y, 30);
  }
}