// GetTessGroups, by Andres Colubri
// The getTessellation() function in Processing 4 returns a group shape 
// where the first shape contains only the fill geometry, the second, 
// the stroke lines, and third, only the points (if any).

PShape box;
PShape tess;

boolean onlyStrokeLines = false;

void setup() {  
  size(600, 600, P3D);
  
  strokeWeight(5);
  box = createShape(BOX, 200);
  
  tess = box.getTessellation();
}

void draw() {
  background(180);
  lights();
  
  translate(width/2, height/2);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  for (int i = 0; i < tess.getChildCount(); i++) {    
    if (!onlyStrokeLines || i == 1) {
      shape(tess.getChild(i));
    }
  }
}

void keyPressed() {
  onlyStrokeLines = !onlyStrokeLines;
}