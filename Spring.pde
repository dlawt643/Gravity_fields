class Spring {
  
  MouseJoint mouseJoint;
  
  Spring(){
    //at first it doesn't exist
    mouseJoint = null;
  }
  
  void display(){
    if(mouseJoint != null){
      Vec2 v1 = new Vec2(0,0);
      mouseJoint.getAnchorA(v1);
      Vec2 v2 = new Vec2(0,0);
      mouseJoint.getAnchorB(v2);
      
      v1 = box2d.coordWorldToPixels(v1);
      v2 = box2d.coordWorldToPixels(v2);
      
      stroke(0);
      strokeWeight(1);
      line(v1.x,v1.y,v2.x,v2.y);
    }
  }
  
  void update(float x, float y) {
    //setting a target to mouse location if it exist
    if(mouseJoint != null) {
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }
  
  void bind(float x, float y, Box box) {
    MouseJointDef md = new MouseJointDef();
    //fake ground body for simplicity
    md.bodyA = box2d.getGroundBody();
    //receiving the body of item you want to move
    md.bodyB = box.body;
    //making a vector of the mouse location
    Vec2 mp = box2d.coordPixelsToWorld(x,y);
    //setting target for box
    md.target.set(mp);
    
    //paramters of force and damping
    md.maxForce = 1000.0 * box.body.m_mass;
    md.frequencyHz = 5.0;
    md.dampingRatio = 0.9;
    
    mouseJoint = (MouseJoint) box2d.world.createJoint(md);
  }
  
  void destroy(){
    //getting rid of mouse when its released
    if(mouseJoint != null){
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }
  
  
}
