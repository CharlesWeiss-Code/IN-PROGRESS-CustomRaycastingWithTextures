class miniMap {
  PVector p1, p2;
  void showHighlightedSquares() {
    if (clickNum == 4) {
      p1 = null; 
      p2 = null; 
      clickNum = 0; 
      highlighted.clear();
    }
    if (p1 != null && p2 != null) {
      fill(135, 206, 235); 
      rect(int(p1.x/scl)*scl, int(p1.y/scl)*scl, int((p2.x-p1.x)/scl)*scl, (int(p2.y-p1.y)/scl)*scl);
    }
  }


  void selectSquareColor() {
    usablePoints();
    if (key == '1') {
      if (highlightedSquaresNum > 1 && p1 != null && p2 != null) {
        for (int i = 0; i < (int(p2.x/scl)-int(p1.x/scl)); i++) {
          for (int j = 0; j < (int(p2.y/scl)-int(p1.y/scl)); j++) {
            boundaries.add(new boundary(scl/2, i*scl+p1.x, j*scl+p1.y, 1, tracker));
            tracker++;
          }
        }
      } else {
        map[int(UsableMousePos.x/scl)][int(UsableMousePos.y/scl)] = 1; 
        boundaries.add(new boundary(scl/2, int(UsableMousePos.x/scl)*scl, int(UsableMousePos.y/scl)*scl, 1, tracker));
        tracker++;
      }
    } else if (key == '2') {
      if (highlightedSquaresNum > 1 && p1 != null && p2 != null) {
        for (int i = 0; i < (int(p2.x/scl)-int(p1.x/scl)); i++) {
          for (int j = 0; j < (int(p2.y/scl)-int(p1.y/scl)); j++) {
            boundaries.add(new boundary(scl/2, i*scl+p1.x, j*scl+p1.y, 2, tracker));
            tracker++;
          }
        }
      } else {
        map[int(UsableMousePos.x/scl)][int(UsableMousePos.y/scl)] = 2; 
        boundaries.add(new boundary(scl/2, int(UsableMousePos.x/scl)*scl, int(UsableMousePos.y/scl)*scl, 2, tracker));
        tracker++;
      }
    } else if (key == '3') {
      if (highlightedSquaresNum > 1 && p1 != null && p2 != null) {
        for (int i = 0; i < (int(p2.x/scl)-int(p1.x/scl)); i++) {
          for (int j = 0; j < (int(p2.y/scl)-int(p1.y/scl)); j++) {
            boundaries.add(new boundary(scl/2, i*scl+p1.x, j*scl+p1.y, 3, tracker));
            tracker++;
          }
        }
      } else {
        map[int(UsableMousePos.x/scl)][int(UsableMousePos.y/scl)] = 3; 
        boundaries.add(new boundary(scl/2, int(UsableMousePos.x/scl)*scl, int(UsableMousePos.y/scl)*scl, 3, tracker));
        tracker++;
      }
    } else if (key == '0' || keyCode == BACKSPACE) {
      boundary remove = null; 
      map[int(UsableMousePos.x/scl)][int(UsableMousePos.y/scl)] = 0; 
      for (int i = boundaries.size()-1; i >= 0; i--) {
        if (int(boundaries.get(i).pos.x/scl)*scl == int(UsableMousePos.x/scl)*scl && int(boundaries.get(i).pos.y/scl)*scl == int(UsableMousePos.y/scl)*scl) {
          remove = boundaries.get(i);
        }
      }
      boundaries.remove(remove);
    }
  }
  void usablePoints() {
    float p1TempY;
    float p1TempX;
    if (p1 != null & p2 != null) {
      if (p1.x < p2.x && p1.y > p2.y) {
        p1TempY = p1.y;
        p1.y = p2.y-scl;
        p2.y = p1TempY+scl*2;
      } else if (p1.x > p2.x && p1.y > p2.y) {
        p1TempY = p1.y;
        p1TempX = p1.x;
        p1.x = p2.x-scl;
        p2.x = p1TempX + scl*2;
        p1.y = p2.y - scl;
        p2.y = p1TempY + scl*2;
      } else if (p1.x > p2.x && p1.y < p2.y) {
        p1TempX = p1.x;
        p1.x = p2.x - scl;
        p2.x = p1TempX + scl*2;
      } else if (p1.x < p2.x && p1.y < p2.y) {
      }
    }
  }

  void correctUsableMousePos() {
    UsableMousePos = new PVector(0, 0); 
    UsableMousePos.x = constrain(mouseX, 0, (cols-1)*scl); 
    UsableMousePos.y = constrain(mouseY, 0, (rows-1)*scl);
  }


  void drawGrid() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        noFill();
        rect(x*scl, y*scl, scl, scl);
      }
    }
  }

  void deleteHighlighted() {
    if (highlighted.size() > 0) {
      for (int i = highlighted.size()-1; i >=0; i--) {
        map[int(highlighted.get(i).pos.x/scl)][int(highlighted.get(i).pos.y/scl)] = 0;
        for (int j = boundaries.size()-1; j >=0; j--) {
          if (int(boundaries.get(j).pos.x/scl)*scl == int(highlighted.get(i).pos.x/scl)*scl && int(boundaries.get(j).pos.y/scl)*scl == int(highlighted.get(i).pos.y/scl)*scl) {
            boundaries.get(j).myWalls.clear();
            boundaries.remove(boundaries.get(j));
          }
        }
      }
    }
    for (int i = 0; i < previousMousePos.length-1; i++) {
      previousMousePos[i] = null;
    }
    p1 = null;
    p2 = null;
  }

  void showHighlightedSquare() {
    push();
    fill(255, 0, 0);
    rect(int(UsableMousePos.x/scl)*scl, int(UsableMousePos.y/scl)*scl, scl, scl);
    pop();
  }

  void identifyHighlightedSquares() {
    fillEverySquare();
    PVector p1Temp; 
    float p1Tempy; 
    if (p1 != null && p2 != null) {
      if (p2.x < p1.x) {
        p1Temp = new PVector(p1.x, p1.y); 
        p1 = p2; 
        p2 = p1Temp;
      } 
      if (p1.y > p2.y) {
        p1Tempy = p1.y; 
        p1.y = p2.y; 
        p2.y = p1Tempy;
      } 

      if (p1.x+1 != p2.x && p1.y+1 != p2.y) {
        for (boundary b : boundaries) {
          if (b.pos.x >= p1.x && b.pos.x <= p2.x && b.pos.y >= p1.y && b.pos.y <= p2.y) {
            highlighted.add(b);
          }
        }
      }
      highlightedSquaresNum = (int(p2.x/scl)-(int(p1.x/scl)))*(int(p2.x/scl)-(int(p1.x/scl)));
    }
  }

  void fillEverySquare() {
    if (previousMousePos[0] != null &&  previousMousePos[1] != null) {
      if (int(previousMousePos[0].x/scl)*scl == int(previousMousePos[1].x/scl)*scl && int(previousMousePos[0].y/scl)*scl == int(previousMousePos[1].y/scl)*scl) {        
        clickNum = 3;
        p1 = new PVector(0, 0);
        p2 = new PVector(cols*scl, rows*scl);
      }
    }
  }
}
