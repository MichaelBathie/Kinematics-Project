class Chain {

  PVector points[];
  PVector startPoint;
  EndEffector endPoint;

  Chain(PVector points[], EndEffector endPoint) {
    this.startPoint = points[0];

    for(int i = 0; i < points.size(); i++) {
      this.points[i] = points[i];
    }

    this.endPoint = new EndEffector(endPoint.point.x,  endPoint.point.y, endPoint.radius);
  }
}