class player {
  PVector pos;
  PVector miniMapPos;
  int r = scl/2;
  boolean forward, backward, left, right;
  float dirAngle = 0;
  PVector dir;
  float fov;
  float speed = 2;
  float fovTop;
  float fovBot;
  PVector vel;
  float turningSens = .05;
  ArrayList<ray> rays = new ArrayList<ray>();
  ArrayList<Float> scene = new ArrayList<Float>();
  ArrayList<PVector> intPoints = new ArrayList<PVector>();

  player(float realX, float realY, float miniMapX, float miniMapY, float viewAngle) {
    pos = new PVector(realX, realY);
    miniMapPos = new PVector(miniMapX, miniMapY);
    fov = viewAngle;
    fovTop = fov/2;
    fovBot = -fov/2;
    generateRays();
  }

  void miniMapShow() {
    PVector a = PVector.fromAngle(fovTop);
    PVector b = PVector.fromAngle(fovBot);
    a.setMag(40);
    b.setMag(40);
    dir = PVector.fromAngle(dirAngle);
    dir.setMag(40);
    push();
    fill(0, 255, 255);
    stroke(255, 255, 0);
    ellipse(miniMapPos.x, miniMapPos.y, r, r);
    translate(miniMapPos.x, miniMapPos.y);
    beginShape();
    stroke(255);
    vertex(0, 0);
    vertex(a.x, a.y);
    vertex(b.x, b.y);
    endShape(CLOSE);
    pop();
  }

  void update() {
    scene.clear();
    for (ray r : rays) {
      //intPoints.add(r.collideWithBoundary(rayWalls));
      
    }
    dirAngle = dir.heading();
    if (forward) {
      vel = PVector.fromAngle(dirAngle);
      vel.setMag(speed);
      miniMapPos.add(vel);
    } else if (backward) {
      vel = PVector.fromAngle(dirAngle+PI);
      vel.setMag(speed);
      miniMapPos.add(vel);
    }
    if (left) {
      for (ray r : rays) {
        r.dirAngle-=turningSens;
      }
      dirAngle-=turningSens;
      fovTop -=turningSens;
      fovBot -=turningSens;
    } else if (right) {
      for (ray r : rays) {
        r.dirAngle+=turningSens;
      }
      dirAngle+=turningSens;
      fovTop +=turningSens;
      fovBot +=turningSens;
    }
  }

  void generateRays() {
    for (float i = -fov/2; i < fov/2; i+=.1) {
      rays.add(new ray(i, miniMapPos.x, miniMapPos.y));
    }
  }
  
  void showView() {
    for (int i = 0; i < scene.size(); i++) {
      float sceneW = width/2;
      float rectW = sceneW/scene.size();
      float h = map(scene.get(i),0,height*sqrt(2),255,0);
      rectMode(CENTER);
      stroke(h);
      rect(1+i*rectW+width/2,height/2,rectW,h);
    }
  }
}
