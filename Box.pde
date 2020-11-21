class Box{
  Body body;
  float w, h;
  
  Box(float x, float y){
   w = 50;
   h = 50;
   
   makeBody(new Vec2(x,y));
  }
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    fill(127, 100, 0, 50);
    noStroke();
    rectMode(CENTER);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    rect(0,0,w,h);
    popMatrix();
    
  }
  
  void makeBody(Vec2 center){
    //define
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);
    //shape
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);  
    ps.setAsBox(box2dW, box2dH);
    //fixture
    body.createFixture(ps,1.0);
    
    //velocity?
    body.setLinearVelocity(new Vec2(random(-2, 2), random(-2,2)));
    body.setAngularVelocity(random(-PI, PI));
  }
  
  boolean contains(float x1, float y1){
    //create vector of mouse location
    Vec2 worldPoint = box2d.coordPixelsToWorld(x1,y1);
    //get the list of fixture attached to this body!
    Fixture f = body.getFixtureList();
    // this is test the containment of the fixture within the body
    boolean inside = f.testPoint(worldPoint);
    // if so return true!
    return inside;
  }
  
  void applyForce(Vec2 force){
    //vector of center
    Vec2 pos = body.getWorldCenter();
    //applyForce function takes(force, where to apply);
    body.applyForce(force, pos);
    
  }
}
