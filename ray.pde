class ray {
  PVector pos;
  float dirAngle;
  PVector dir = PVector.fromAngle(dirAngle);
  PVector closest = null;
  int count = 0;

  ray(float d, float x, float y) {
    pos = new PVector(x, y);
    dirAngle = d ;
  }

  PVector collideWithBoundary(ArrayList<wall> b) {
    dir = PVector.fromAngle(dirAngle);
    pos.set(p.miniMapPos);
    float record = 999999999;
    for (wall w : b) {
      PVector intPoint = null;
      float intPointx;
      float intPointy;

      float x1 = w.a.x;
      float y1 = w.a.y;
      float x2 = w.b.x;
      float y2 = w.b.y;

      float x3 = pos.x;
      float y3 = pos.y;
      float x4 = pos.x + dir.x;
      float y4 = pos.y + dir.y;
      float den = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));
      if (den == 0) {
        return null;
      }

      float t = (((x1 -x3) * (y3-y4)) - ((y1 - y3) * (x3 - x4)))/den;
      float u = -(((x1-x2) * (y1-y3)) - ((y1 - y2) * (x1 - x3)))/den;
      if (t >= 0 && t <= 1 && u <= 1) {
        intPointx = x1 + t * (x2 - x1);
        intPointy = y1 + t * (y2 - y1); 
        intPoint = new PVector (intPointx, intPointy);
      } 
      if (intPoint != null) {
        float d = PVector.dist(pos, intPoint);
        if (d < record) {
          record = d;
          closest = intPoint;
        }
      }
      if (closest != null) {
        push();
        p.scene.add(record);
        stroke(255, 0, 0);
        line(pos.x, pos.y, closest.x, closest.y);
        pop();
      }
    }
     return closest;
  }

  void show() {
    push();
    dir.setMag(100);
    if (closest != null) {
      ellipse(closest.x, closest.y, 16, 16);
      line(pos.x, pos.y, closest.x, closest.y);
    }
    pop();
  }
}
