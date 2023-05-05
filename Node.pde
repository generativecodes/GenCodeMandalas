class Node {
  boolean isTriangle;
  PVector a, b;
  PShape shape;
  color col;
  PTree tree;
  int depth;
  Node leftChild;
  Node midChild;
  Node rightChild;

  Node(boolean isTriangle, PVector a, PVector b, int depth, PTree tree) {
    this.isTriangle = isTriangle;
    this.a = a;
    this.b = b;
    this.tree = tree;
    this.depth = depth;

    if (depth <= 0) {
      shape = null;
      this.leftChild = this.midChild = this.rightChild = null;
    } else if (isTriangle) {
      initTriangle(a, b, depth);
    } else {
      initQuad(a, b, depth);
    }
  }

  void initQuad(PVector a, PVector b, int depth) {
    if (depth <= 0) return;

    PVector side = PVector.sub(b, a).rotate(-PI / 2);
    PVector c = PVector.add(b, side);
    PVector d = PVector.add(a, side);

    this.shape = createShape(QUAD, a.x, a.y, b.x, b.y, c.x, c.y, d.x, d.y);
    setColor(depth);
    tree.shapes.add(this.shape);

    this.leftChild = null;
    this.midChild = new Node(true, c, d, depth - 1, this.tree);
    this.rightChild = null;
  }

  void initTriangle(PVector a, PVector b, int depth) {
    if (depth <= 0) return;

    PVector c = calculateThirdPoint(a, b, tree.angle, tree.triangleHeight);

    this.shape = createShape(TRIANGLE, a.x, a.y, b.x, b.y, c.x, c.y);
    setColor(depth);
    tree.shapes.add(this.shape);

    this.leftChild = new Node(false, b, c, depth - 1, this.tree);
    this.midChild = null;
    this.rightChild = new Node(false, c, a, depth - 1, this.tree);
  }

  void setColor(int num) {
    this.col = getColor(num);
    this.shape.setFill(color(red(this.col),
                             green(this.col),
                             blue(this.col),
                             this.tree.transparency));
  }

  PVector calculateThirdPoint(PVector a, PVector b, float angle, float height) {
    PVector mid = PVector.lerp(a, b, 0.5);
    PVector c = PVector.sub(b, a);
    c.mult(height);
    c.rotate(angle % PI);
    return PVector.add(c, mid);
  }
}
