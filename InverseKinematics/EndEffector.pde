class EndEffector {
  PVector point;
  float radius;

  EndEffector(float x, float y, float r) {
    point = new PVector(x, y);
    radius = r;
  }
  
  boolean checkBounds() {
    float dx = abs(this.point.x - mouseX);
    float dy = abs(this.point.y - mouseY);

    float d = sqrt(sq(dx) + sq(dy));

    if(d < radius) {
      return true;
    }
    return false;
  }

  void display() {
    fill(1,0,0);
    stroke(1,0,0);
    circle(this.point.x, this.point.y, radius);
  }
}