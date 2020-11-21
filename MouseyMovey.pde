// learning mouse Joints and kinematic joints
// danny lawton

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Boundary> bounds;
ArrayList<Box> boxes;
Box b1;
Spring spring;
ArrayList<Attractor> as;

void setup(){
  size(640, 640);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  bounds = new ArrayList<Boundary>();
  bounds.add(new Boundary(0, height/2, 20, height, 0));
  bounds.add(new Boundary(width, height/2, 20, height, 0));
  bounds.add(new Boundary(width/2, height, width, 20, 0));
  bounds.add(new Boundary(width/2, 0, width, 20, 0));
  
  boxes = new ArrayList<Box>();
  
  for (int i = 0; i < 5; i++){
    float x = i * 50 + 50;
    float y = random(height);
    boxes.add(new Box(x,y));
    
  }
  
  spring = new Spring();
  
  as = new ArrayList<Attractor>();
  as.add(new Attractor(50, width/2, height/2));
  as.add(new Attractor(25, 100, 100));
  as.add(new Attractor(30, 400, 100));
}

void mouseReleased(){
  spring.destroy();
}

void mousePressed(){
  
  for(int i = 0; i < boxes.size(); i++){
    Box a = boxes.get(i);
    if(a.contains(mouseX, mouseY)){
      spring.bind(mouseX, mouseY, a);
    } 
  }
  
  //if(b1.contains(mouseX, mouseY)){
  //  spring.bind(mouseX, mouseY, b1);
  //}
}

void draw(){
  background(255);
  box2d.step();
  
  for(Attractor ad : as){
    ad.display();
  }
  
  for(Boundary bou : bounds){
    bou.display();
  }
  
  for(Box bo : boxes){
    bo.display();
    for (int i = 0; i < as.size(); i++){
      Attractor a = as.get(i);
    Vec2 force = a.Attract(bo);
    bo.applyForce(force);
    }
    
    Vec2 wind = new Vec2(100, 0);
    bo.applyForce(wind);
  }
  
  spring.update(mouseX,mouseY);
}
