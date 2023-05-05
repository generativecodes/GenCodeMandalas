class PTree {
  ArrayList<PShape> shapes;
  PVector[] rootPoints;
  int transparency;
  float angle, triangleHeight;
  Node root;

  PTree(PVector rootA, PVector rootB, int depth) {
    shapes = new ArrayList();
    rootPoints = new PVector[2];
    this.rootPoints[0] = rootA;
    this.rootPoints[1] = rootB;
    transparency = 255/2;
    angle = PI/2;
    triangleHeight = sqrt(3)/2;
    root = new Node(false, rootA, rootB, depth, this);
  }

  void init(PVector rootA, PVector rootB, int depth) {
    shapes = new ArrayList();
    rootPoints = new PVector[2];
    this.rootPoints[0] = rootA;
    this.rootPoints[1] = rootB;
    root = new Node(false, rootA, rootB, depth, this);
  }

  void display(boolean stroke) {
    for (PShape s : shapes) {
      if (style) {
        fill(0);
        noStroke();
      } else {
        stroke(0);
        noFill();
        if (light) s.setStroke(0);
        else s.setStroke(255);
      }
      shape(s);
    }
  }
  void setTransparency(int transparency) {
    this.transparency = transparency;
  }

  void setAngle(float angle) {
    this.angle = angle;
  }

  void setTriangleHeight(float h) {
    this.triangleHeight = h;
  }
}
