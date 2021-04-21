class Chain {

  PVector forward[];
  PVector backward[];
  PVector startPoint;
  EndEffector endPoint;

  PVector demo[];
  int demoCounter;

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

  //simply using this for a static demo, going to be assuming a lot of stuff
  Chain(PVector points[], EndEffector endPoint, String demonstration) {
    this.startPoint = new PVector(points[0].x, points[0].y);

    demo = new PVector[12];
    if(points.length != 4) {
      print("number of points in the demo isn't 4!!");
    }
    for(int i = 0; i < points.length; i++) {
      demo[i] = points[i];
    }
    
    this.endPoint = new EndEffector(endPoint.point.x,  endPoint.point.y, endPoint.radius);

    demoCounter = 0;
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

  void fabrikDemo() {

  }

  void increaseCount() {
    this.demoCounter = (this.demoCounter + 1) % 12;
  }
}