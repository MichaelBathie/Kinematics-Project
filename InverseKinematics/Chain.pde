class Chain {

  PVector originalPoints[];
  PVector forward[];
  PVector backward[];
  PVector startPoint;
  float len[];
  EndEffector endPoint;

  PVector demo[];
  int demoCounter;

  Chain parent = null;
  int whichBranch;

  float delta = 0.01; //if our calculated endpoint and actual end effector are "close enough"
  int maxIterations = 10; //if we go through 10 iterations just stop and say it's good enough 
  float constraintAngle = 45;

  //standard constructor for creating the chain
  Chain(PVector points[], EndEffector endPoint) {
    this.startPoint = new PVector(points[0].x, points[0].y);

    forward = new PVector[points.length];
    originalPoints = new PVector[points.length];
    backward = new PVector[points.length];
    len = new float[forward.length - 1];
    
    for(int i = 0; i < points.length; i++) {
      this.forward[i] = new PVector(points[i].x, points[i].y);
      this.originalPoints[i] = new PVector(points[i].x, points[i].y);
    }

    for(int i = 0; i < len.length; i++) {
      len[i] = lengthBtwPoints(this.forward[i], this.forward[i+1]);
    }

    this.endPoint = endPoint;
  }

  //for branch like structures
  Chain(PVector points[], EndEffector endPoint, Chain parent, int whichBranch) {
    this.startPoint = new PVector(points[0].x, points[0].y);

    forward = new PVector[points.length];
    backward = new PVector[points.length];
    len = new float[forward.length - 1];
    
    for(int i = 0; i < points.length; i++) {
      this.forward[i] = new PVector(points[i].x, points[i].y);
    }

    for(int i = 0; i < len.length; i++) {
      len[i] = lengthBtwPoints(this.forward[i], this.forward[i+1]);
    }

    this.endPoint = endPoint;

    this.parent = parent;
    this.whichBranch = whichBranch;
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
    if(parent != null) {startPoint = parent.forward[whichBranch];}
    if(!reachable()) {notReachable(); return;}

    for(int i = 0; i < maxIterations; i++) {
      backwards();
      forwards();

      if(lengthBtwPoints(forward[forward.length-1], endPoint.point) < delta) {
        break;
      }
    }
    //done enough iterations
  }

  void forwards() {
    PVector temp = new PVector(0,0);

    forward[0] = startPoint;
    temp.x = backward[1].x - forward[0].x;
    temp.y = backward[1].y - forward[0].y;

    for(int i = 1; i < forward.length; i++) {
      forward[i] = getFabrikPoint(forward[i-1], temp, len[i-1]);

      if(i != forward.length-1) {
        temp.x = backward[i+1].x - forward[i].x;
        temp.y = backward[i+1].y - forward[i].y;
      }
    }
  }

  void backwards() {
    PVector temp = new PVector(0,0);

    backward[backward.length-1] = endPoint.point;
    temp.x = forward[backward.length-2].x - backward[backward.length-1].x;
    temp.y = forward[backward.length-2].y - backward[backward.length-1].y;

    for(int i = backward.length - 2; i > -1; i--) {
      backward[i] = getFabrikPoint(backward[i+1], temp, len[i]);

      if(i != 0) {
        temp.x = forward[i-1].x - backward[i].x;
        temp.y = forward[i-1].y - backward[i].y;
      }
    }
  }

  void notReachable() {
    PVector startToEnd = new PVector(endPoint.point.x - startPoint.x, endPoint.point.y - startPoint.y);    

    forward[0] = startPoint;
    for(int i = 1; i < forward.length; i++) {
      forward[i] = getFabrikPoint(forward[i-1], startToEnd, len[i-1]);
    }
  }

  //simple reachability check, may expand on later
  boolean reachable() {
    boolean canReach = false;
    float max = lengthBtwPoints(startPoint, endPoint.point);
    float chainSum = 0;

    for(int i = 0; i < forward.length - 1; i++) {
      chainSum += lengthBtwPoints(forward[i], forward[i+1]);
    }

    if(chainSum >= max) {
      canReach = true;
    }

    return canReach;
  }

  void display() {
    for(int i = 0; i < forward.length; i++) {
      circle(forward[i].x, forward[i].y, 30);

      if(i+1 < forward.length) {
        line(forward[i].x, forward[i].y, forward[i+1].x, forward[i+1].y);
      }
    }
  }

  void displayMob() {
    circle(forward[forward.length-1].x, forward[forward.length-1].y, 30);
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

  float angleBetweenLinesInRad(PVector line1Start, PVector line1End, PVector line2Start, PVector line2End) {
    float a = line1End.x - line1Start.x;
    float b = line1End.y - line1Start.y;
    float c = line2End.x - line2Start.x;
    float d = line2End.y - line2Start.y;

    float atanA = atan2(a, b);
    float atanB = atan2(c, d);

    return atanA - atanB;
  }
}