class Chain {

  //The set of original points in the chain, useful in some scenarios
  PVector originalPoints[];
  //This is where the points are stored initially, and after we perform the forward step in FABRIK
  PVector forward[];
  //Where we store the points after the backward step in FABRIK
  PVector backward[];
  //store our starting point as it's used often, and we need a copy of the original
  PVector startPoint;
  //Array holding the lengths between all connected points
  float len[];
  //The point we want our chain to reach
  EndEffector endPoint;

  //demo points
  PVector demo[];
  //counts which demo step we're on
  int demoCounter;

  //for branching, where we store a pointer to our parent in the hierarchy
  Chain parent = null;
  //which node on the parent branch are we attaching ourselves to
  int whichBranch;

  //if our calculated endpoint and actual end effector are "close enough"
  float delta = 0.01; 
  //if we go through 10 iterations just stop and say it's good enough
  int maxIterations = 10;  
  //on a constrained chain, lets constrain at 75 degrees
  float constraintAngle = 75;
  //distance from our startpoint to the end effector
  float max;
  //cumulative length of all segments. it would be the sum of len[]
  float chainSum;


/*=============== CONSTRUCTORS ===============*/


  //Standard for making a basic chain. Only takes a set of points and an endpoint
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



  //For branching. Takes in the points of the chain, the end point, which parent it is attached to, and which node on that parent
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



  //Constructor only used for the demo. Most values are assumed
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


/*=============== CONSTRUCTORS ===============*/



/*=============== FABRIK ===============*/



  void fabrik() {
    if(parent != null) {startPoint = parent.forward[whichBranch];}
    if(!reachable()) {
      if(programMode == mode.FOLLOW) {
        adjust();
      } else {
        notReachable(); 
        return;
      }
    }

    for(int i = 0; i < maxIterations; i++) {
      backwards();
      forwards();

      if(lengthBtwPoints(forward[forward.length-1], endPoint.point) < delta) {
        break;
      }
    }
    if(programMode == mode.CONSTRAINT)
      constraint();
    //done enough iterations

  }


  //forward part of FABRIK
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



  //backward part of FABRIK
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
    max = lengthBtwPoints(startPoint, endPoint.point);
    chainSum = 0;

    for(int i = 0; i < forward.length - 1; i++) {
      chainSum += lengthBtwPoints(forward[i], forward[i+1]);
    }

    if(chainSum >= max) {
      canReach = true;
    }

    return canReach;
  }



/*=============== FABRIK ===============*/



/*=============== ALTERING FABRIK ===============*/



  //buggy version of contraints, looks through the points in forward and constrains if their angle is too great
  void constraint() {
    PVector u;
    PVector b = new PVector(originalPoints[1].x - originalPoints[0].x, originalPoints[1].y - originalPoints[0].y);
    PVector c = new PVector(forward[1].x - forward[0].x, forward[1].y - forward[0].y);

    b.normalize();
    c.normalize();
    u = b.cross(c);
    float a = acos(b.dot(c));

    if(a > radians(constraintAngle)) {
      if(u.z <= 0) {
        b.rotate(radians(-1*constraintAngle));
      } else {
        b.rotate(radians(constraintAngle));
      }
      forward[1] = getFabrikPoint(forward[0], b, len[0]); 
    }


    for(int i = 1; i < forward.length - 1; i++) {
      b = new PVector(forward[i].x - forward[i-1].x, forward[i].y - forward[i-1].y);
      c = new PVector(forward[i+1].x - forward[i].x, forward[i+1].y - forward[i].y);
      b.normalize();
      c.normalize();
      u = b.cross(c);
      a = acos(b.dot(c));

      if(a > radians(constraintAngle)) {
        //we're constrained! lets change the stroke
        stroke(1,0,0);
        if(u.z <= 0) {
          b.rotate(radians(-1*constraintAngle));
        } else {
          b.rotate(radians(constraintAngle));
        }
        forward[i+1] = getFabrikPoint(forward[i], b, len[i]); 
      }
    }
  }


  //adjust our start point to allow it to follow the end effector when reachability checks fail  
  void adjust() {
    PVector sToE = new PVector(endPoint.point.x - startPoint.x, endPoint.point.y - startPoint.y);
    sToE.normalize();

    float distance = max - chainSum;

    sToE.mult(distance);
    sToE.x += startPoint.x;
    sToE.y += startPoint.y;

    startPoint = sToE;
  }




/*=============== ALTERING FABRIK ===============*/




/*=============== DISPLAY METHODS ===============*/



  void display() {
    for(int i = 0; i < forward.length; i++) {
      circle(forward[i].x, forward[i].y, 30);

      if(i+1 < forward.length) {
        line(forward[i].x, forward[i].y, forward[i+1].x, forward[i+1].y);
      }
    }
  }



  void displayMob(int x) {
    if(x == 0) {
      stroke(0,0,0.3);
      fill(0,0,0.3);
    }
    else if(x == 1) {
      stroke(0,0.3,0);
      fill(0,0.3,0);
    }
    else {
      stroke(0.3,0.3,0);
      fill(0.3,0.3,0);
    }
    circle(forward[forward.length-1].x, forward[forward.length-1].y, 30);
  }

  void displayTent() {
    for(int i = 0; i < forward.length; i ++) {
      if(i+1 < forward.length) {
        if(i%2 == 0) {
          stroke(1,0,0);
        } else {
          stroke(1,1,0);
        }
        line(forward[i].x, forward[i].y, forward[i+1].x, forward[i+1].y);
      }
    }
  }



/*=============== DISPLAY METHODS ===============*/



/*=============== HELPER METHODS ===============*/


  
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



/*=============== HELPER METHODS ===============*/



/*=============== DEMO ===============*/



  //hard coded display for the demo
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
  


/*=============== DEMO ===============*/

}