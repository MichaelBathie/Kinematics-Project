class Chain {

  PVector forward[];
  PVector backward[];
  PVector startPoint;
  EndEffector endPoint;

  float delta = 0.01; //if our calculated endpoint and actual end effector are "close enough"
  int maxIterations = 10; //if we go through 10 iterations just stop and say it's good enough 

  Chain(PVector points[], EndEffector endPoint) {
    this.startPoint = new PVector(points[0].x, points[0].y);

    forward = new PVector[points.length];
    backward = new PVector[points.length];
    
    for(int i = 0; i < points.length; i++) {
      this.forward[i] = points[i];
    }

    this.endPoint = new EndEffector(endPoint.point.x,  endPoint.point.y, endPoint.radius);
  }

  void fabrik() {
    if(!reachable()) {return;}

    for(int i = 0; i < maxIterations; i++) {
      backwards();
      forwards();

      //check distance with delta
    }
    //done enough iterations
  }

  void forwards() {

  }

  void backwards() {

  }

  boolean reachable() {
    return true;
  }

  void display() {

  }
}