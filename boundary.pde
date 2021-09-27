class boundary {
  float r;
  PVector pos;
  int colorRadius = 200;
  PVector p1, p2, p3, p4 = new PVector(0, 0);
  ArrayList<wall> myWalls = new ArrayList<wall>();
  int texture;
  int tracker;

  boundary(float radius, float x, float y, int value, int identification) {
    texture = value;
    r = radius;
    pos = new PVector(x, y);
    tracker = identification;

    p1 = new PVector(pos.x, pos.y);
    p2 = new PVector(pos.x+r*2, pos.y);
    p3 = new PVector(pos.x+r*2, pos.y+r*2);
    p4 = new PVector(pos.x, pos.y+r*2);

    myWalls.add(new wall(p1, p2, texture, tracker));
    myWalls.add(new wall(p2, p3, texture, tracker));
    myWalls.add(new wall(p3, p4, texture, tracker));
    myWalls.add(new wall(p4, p1, texture, tracker));

    rayWalls.add(new wall(p1, p2, texture, tracker));
    rayWalls.add(new wall(p2, p3, texture, tracker));
    rayWalls.add(new wall(p3, p4, texture, tracker));
    rayWalls.add(new wall(p4, p1, texture, tracker));
  }
  void show() {
    push();
    if (texture == 1) {
      stroke(0);
      fill(255,255,255,50);
    } else if (texture == 2) { 
      fill(0, 255, 0,50);
    } else if (texture == 3) 
      fill(0, 0, 128,50);
    beginShape();
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);
    vertex(p4.x, p4.y);
    endShape(CLOSE);
    pop();
  }
}
