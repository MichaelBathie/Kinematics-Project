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
      this.forward[i] = new PVector(points[i].x, points[i].y);
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
      this.demo[i] = new PVector(points[i].x, points[i].y);
    }
    
    this.endPoint = new EndEffector(endPoint.point.x,  endPoint.point.y, endPoint.radius);

    this.demoCounter = 0;
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
    float lengths[] = {
      lengthBtwPoints(demo[0], demo[1]),
      lengthBtwPoints(demo[1], demo[2]),
      lengthBtwPoints(demo[2], demo[3])
    };
    PVector temp = new PVector(0, 0);
    PVector newPoints;

    /*======= BACKWARDS ========*/

    demo[4] = new PVector(endPoint.point.x, endPoint.point.y); //p3'
    temp.x = demo[2].x - demo[4].x;
    temp.y = demo[2].y - demo[4].y;
    newPoints = getFabrikPoint(demo[4], temp, lengths[2]); 

    demo[5] = new PVector(newPoints.x, newPoints.y); //p2'
    temp.x = demo[1].x - demo[5].x;
    temp.y = demo[1].y - demo[5].y;
    newPoints = getFabrikPoint(demo[5], temp, lengths[1]); 
    
    demo[6] = new PVector(newPoints.x, newPoints.y); //p1'
    temp.x = startPoint.x - demo[6].x;
    temp.y = startPoint.y - demo[6].y;
    newPoints = getFabrikPoint(demo[6], temp, lengths[0]); 

    demo[7] = new PVector(newPoints.x, newPoints.y); //p0'

    /*======= BACKWARDS ========*/

    /*======= FORWARDS ========*/

    demo[8] = new PVector(startPoint.x, startPoint.y); //p0''
    temp.x = demo[6].x - demo[8].x;
    temp.y = demo[6].y - demo[8].y;
    newPoints = getFabrikPoint(demo[8], temp, lengths[0]); 
    
    demo[9] = new PVector(newPoints.x, newPoints.y); //p1''
    temp.x = demo[5].x - demo[9].x;
    temp.y = demo[5].y - demo[9].y;
    newPoints = getFabrikPoint(demo[9], temp, lengths[1]); 

    demo[10] = new PVector(newPoints.x, newPoints.y); //p2''
    temp.x = demo[4].x - demo[10].x;
    temp.y = demo[4].y - demo[10].y;
    newPoints = getFabrikPoint(demo[10], temp, lengths[2]); 

    demo[11] = new PVector(newPoints.x, newPoints.y); //p3''

    /*======= FORWARDS ========*/
  }

  PVector getFabrikPoint(PVector fix, PVector vector, float l) {
    PVector workingVector = new PVector(vector.x, vector.y);

    workingVector.normalize(); 
    workingVector.mult(l);

    workingVector.x += fix.x;
    workingVector.y += fix.y;

    return workingVector;
  }

  float lengthBtwPoints(PVector point1, PVector point2) {
    float dx = abs(point2.x - point1.x);
    float dy = abs(point2.y - point1.y);

    return sqrt(sq(dx) + sq(dy));
  }

  void increaseCount() {
    this.demoCounter = (this.demoCounter + 1) % 16;
  }

  void debug() {
    for(int i = 0; i < demo.length; i ++) {
      print(demo[i].x + " " + demo[i].y + " \n");
    }
  }
}