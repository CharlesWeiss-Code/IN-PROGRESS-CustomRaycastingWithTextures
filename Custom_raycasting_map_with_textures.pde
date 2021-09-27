
player p;
int[][] map;
ArrayList<boundary> highlighted = new ArrayList<boundary>();
ArrayList<boundary> boundaries = new ArrayList<boundary>();
ArrayList<wall> walls = new ArrayList<wall>();
ArrayList<boundary> readyToDelete = new ArrayList<boundary>();
ArrayList<wall> rayWalls = new ArrayList<wall>();

miniMap miniMap;
PVector[] previousMousePos;
int highlightedSquaresNum;
int clickNum = 0;
PVector p1, p2;
PVector UsableMousePos;
int cols, rows;
int scl = 40;
int index = 0;
int tracker = 0;
int wallsCount = 0;
void setup() {
  miniMap = new miniMap();
  p = new player(800/2, 400/2, 800/4, 400/2, PI/3);
  size(800, 400);
  cols = (800/2)/scl;
  rows = 400/scl;
  map = new int[cols][rows];
  previousMousePos = new PVector[2];
  addBorderWalls();
}

void draw() {
  background(51);
  miniMapStuff();
  playerStuff();
  boundaryStuff();
  //if (previousMousePos[0] != null) {
  //  ellipse(previousMousePos[0].x,previousMousePos[0].y,16,16);
  //}
}

void boundaryStuff() {
  for (boundary b : boundaries) {
    b.show();
  }
}

void miniMapStuff() {
  miniMap.correctUsableMousePos();
  middleLine();
  //drawGrid();
  miniMap.showHighlightedSquare();
  miniMap.correctUsableMousePos();
  miniMap.showHighlightedSquares();
  miniMap.usablePoints();
  miniMap.identifyHighlightedSquares();
}

void middleLine() {
  stroke(255);
  line (width/2, 0, width/2, height);
}


void keyPressed() {
  miniMap.selectSquareColor();
  if (keyCode == BACKSPACE) {
    miniMap.deleteHighlighted();
    p1 = null;
    p2 = null;
    clickNum ++;
  }

  if (key == 'w' || key == 'W') {
    p.backward = false;
    p.forward = true;
  } else if (key == 's' || key == 'S') {
    p.forward = false;
    p.backward = true;
  } 
  if (key == 'a' || key == 'A') {
    p.right = false;
    p.left = true;
  } else if (key == 'd' || key == 'D') {
    p.left = false;
    p.right = true;
  }
}


void keyReleased() {
  if (key == 'w' || key == 'W') {
    p.forward = false;
  } else if (key == 's' || key == 'S') {
    p.backward = false;
  } 
  if (key == 'a' || key == 'A') {
    p.left = false;
  } else if (key == 'd' || key == 'D') {
    p.right = false;
  }
  if (keyCode == BACKSPACE) {
    clickNum++;
  }
}

void mousePressed() {
  miniMap.fillEverySquare();
  miniMap.p1 = new PVector(int(UsableMousePos.x/scl)*scl, int(UsableMousePos.y/scl)*scl);
  clickNum++;
  if (index > previousMousePos.length-1) {
    for (int i = 0; i < previousMousePos.length; i++) {
      previousMousePos[i] = null;
    }
    index = 0;
  }
  previousMousePos[index] = miniMap.p1;

  index++;
}

void mouseReleased() {
clickNum++;

  miniMap.p2 = new PVector(UsableMousePos.x + scl, UsableMousePos.y + scl);
} 

void playerStuff() {
  p.miniMapShow(); 
  p.update();
  p.showView();
}

void addBorderWalls() {
  rayWalls.add(new wall(0, 0, width, 0, 420, 1));
  rayWalls.add(new wall(width/2, 0, width/2, height, 420, 1));
  rayWalls.add(new wall(width/2, height, 0, height, 420, 1));
  rayWalls.add(new wall(0, height, 0, 0, 420, 1));
}
