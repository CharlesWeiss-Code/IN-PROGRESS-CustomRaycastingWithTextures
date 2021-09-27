class wall {
  PVector a = new PVector(0, 0);
  PVector b = new PVector(0, 0);
  int texture;
  int ID;

  wall(PVector p1, PVector p2, int value, int tracking) {
    a = new PVector(p1.x, p1.y);
    b = new PVector(p2.x, p2.y);
    texture = value;
    ID = tracking;
  }
  wall(float x1, float y1, float x2, float y2, int value, int tracking) {

    a.x = x1;
    a.y = y1;
    b.x = x2;
    b.y = y2;
    texture = value;
    ID = tracking;
  }

  void show() {
    push();
    strokeWeight(10);
    stroke(0, 0, 255);
    line(a.x, a.y, b.x, b.y);
    pop();
  }
}
