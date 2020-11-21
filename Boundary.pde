class Boundary {
  Body b;
  float x, y;
  float w,h;
  
  Boundary(float x_, float y_, float w_, float h_, float a){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    //shape
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);
    
    //define
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    //fixture
    b.createFixture(ps, 1.0);
  }
  
  void display(){
    fill(0);
    stroke(0);
    rectMode(CENTER);
    
    float a = b.getAngle();
    
    pushMatrix();
    translate(x,y);
    rotate(-a);
    rect(0,0,w,h);
    popMatrix();
  }
}
