// TessUpdate, by Andres Colubri
// The begin/endTessallation API in Processing 4
// enables dynamic modification of PShape objects.

PShape group;

int numBoxes = 100000;
float boxSize = 2;

PMatrix3D mat = new PMatrix3D();
  
int fcount, lastm;
float frate;
int fint = 3;  
  
void setup() {
  size(600, 600, P3D);
  noSmooth();

  noStroke();
  group = createShape(GROUP);
    
  for (int i = 0; i < numBoxes; i++) {
    PShape s = createShape(BOX, boxSize, boxSize, boxSize);
    s.setFill(#F5CB40);
    s.translate(random(-width/2, width/2), random(-height/2, height/2), random(-1000, 1000));
    group.addChild(s);
  } 
}
  
void draw() {
  background(0);
  lights();
  PVector v = new PVector();

  // PShape.set*() calls between beginTessellation() and endTessellation
  // will modify the tessellated geometry directly, so this should result
  // better performance for shapes that change dynamically during drawing
  group.beginTessellation(TRIANGLES);
  // getChildCount() returns number of vertices in the tessellated geometry,
  // which could be different from the original number of vertices in the shape.
  for (int ci = 0; ci < group.getChildCount(); ci++) {
    PShape child = group.getChild(ci);
    float rx = random(-1, 1);
    float ry = random(-1, 1);
    float rz = random(-1, 1);        
    for (int vi = 0; vi < child.getVertexCount(); vi++) {
      child.getVertex(vi, v);
      v.x += rx;
      v.y += ry;
      v.z += rz;
      child.setVertex(vi, v.x, v.y, v.z);
    }
  }
  group.endTessellation();

  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.001);
  rotateX(frameCount * 0.001);
  shape(group);
    
  String txt = String.format("FPS: %6.2fps", frameRate);
  surface.setTitle(txt);
}
