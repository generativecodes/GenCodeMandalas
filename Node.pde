class Node{
  boolean triangle;
  PVector a, b;
  PShape shape;
  color col;
  PTree tree;
  int depth;
  Node leftchild;
  Node midchild;
  Node rightchild;

  Node(boolean triangl, PVector a, PVector b, int depth, PTree tree){
    this.triangle = triangl;
    this.a = a;
    this.b = b;
    this.tree = tree;
    this.depth = depth;
    if(depth <= 0){
      shape = null;
      this.leftchild = this.midchild = this.rightchild = null;
    } else if(triangle){
      triaIni(a,b,depth);
    } else{
      quadIni(a,b,depth);
    }
  }

  void quadIni(PVector a, PVector b, int depth){
    if(depth <= 0) return;

    PVector side = PVector.sub(b,a).rotate(-PI/2);
    PVector c = PVector.add(b, side);
    PVector d = PVector.add(a, side);

    this.shape = createShape(QUAD,a.x,a.y,b.x,b.y,c.x,c.y,d.x,d.y);
    this.setColor(depth);
    this.tree.shapes.add(this.shape);

    this.leftchild = null;
    this.midchild = new Node(true,c,d,depth-1,this.tree);
    this.rightchild = null;
  }

  void triaIni(PVector a, PVector b, int depth){
    if(depth <= 0) return;

    PVector c = thirdPoint(a, b, tree.angle, tree.triangleHeight);

    this.shape = createShape(TRIANGLE,a.x,a.y,b.x,b.y,c.x,c.y);
    this.setColor(depth);
    this.tree.shapes.add(this.shape);

    this.leftchild = new Node(false,b,c,depth-1,this.tree);
    this.midchild = null;
    this.rightchild = new Node(false,c,a,depth-1,this.tree);
  }

  void setColor(int num){
    this.col = getColor(num);
    this.shape.setFill(color(red(this.col),
                             green(this.col),
                             blue(this.col),
                             this.tree.transparency));
  }

  PVector thirdPoint(PVector a, PVector b, float angle, float height){
    PVector mid = PVector.lerp(a,b,0.5);
    PVector c = PVector.sub(b,a);
    c.mult(height);
    c.rotate(angle%PI);
    return PVector.add(c,mid);
  }
}
