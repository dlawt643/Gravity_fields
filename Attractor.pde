class Attractor {
 Body body;
 float r;
 
 Attractor(float r_, float x, float y){
   r = r_;
   
   BodyDef bd = new BodyDef();
   bd.type = BodyType.STATIC;
   bd.position.set(box2d.coordPixelsToWorld(x,y));
   body = box2d.createBody(bd);
   
   CircleShape cs = new CircleShape();
   cs.m_radius = box2d.scalarPixelsToWorld(r);
   
   body.createFixture(cs, 1.0);
 }
 
 Vec2 Attract(Box b){
   Float G = 1000.0;
   
   Vec2 pos = body.getWorldCenter();
   Vec2 boxPos = b.body.getWorldCenter();
   
   Vec2 force = pos.sub(boxPos);
   float distance = force.length();
   distance = constrain(distance,1,5);
   force.normalize();
   float strength = (G * 1 * b.body.m_mass) / (distance * distance);
   force.mulLocal(strength);
   return force;
 }
 
 void display(){
   Vec2 pos = box2d.getBodyPixelCoord(body);
   float a = body.getAngle();
   
   pushMatrix();
   translate(pos.x, pos.y);
   rotate(-a);
   fill(127);
   noStroke();
   ellipse(0,0,r*2, r*2);
   popMatrix();
   
 }
 
}
