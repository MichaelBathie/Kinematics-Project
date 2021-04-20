boolean checkBounds(float x, float y) {
  float dx = abs(x - mouseX);
  float dy = abs(y - mouseY);

  float d = sqrt(sq(dx) + sq(dy));

  if(d < 50) {
    return true;
  }
  return false;
}

void mouseDragged() {
  if(checkBounds(endEffector.x, endEffector.y)) {
    endEffector.x = mouseX;
    endEffector.y = mouseY;
  } 
}