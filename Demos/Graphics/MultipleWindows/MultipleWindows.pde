// MultipleWindows, by Andres Colubri
// Adapted from a PixelFlow example by Thomas Diewald
// Demonstration of a multiple window sketch with OpenGL 
// (P2D or P3D) renderers, including resource sharing
// across windows. 

ChildApplet childA;
ChildApplet childB;
ChildApplet childC;

PShape pointer;

void setup() {
  size(400, 300, P2D);
  println("Creating window 1");
  
  // This PShape can be shared across all windows
  pointer = createShape(ELLIPSE, 0, 0, 20, 20);
  
  childA = new ChildApplet(2, 500, 0, 400, 300);
  childA.bckColor = color(227, 173, 37);
  
  // Change location of parent window after creating child window.
  surface.setLocation(100, 0);
}

void draw() {
  background(32);

  fill(160);
  textAlign(CENTER, CENTER);
  text("MAIN window", width/2, height/2);

  translate(mouseX, mouseY);
  shape(pointer);

  String txt = String.format("Window 1   %6.2fps", frameRate);
  surface.setTitle(txt);
}

public void keyPressed() {
  if (childB == null) {
    childB = new ChildApplet(3, 500, 353, 400, 300);
    childB.bckColor = color(137, 227, 37);
  } else if (childC == null) {
    childC = new ChildApplet(4, 100, 353, 400, 300);
    childC.bckColor = color(51, 157, 209);
  }
}

class ChildApplet extends PApplet {
  int id, vx, vy, vw, vh;
  int bckColor;

  ChildApplet(int id, int vx, int vy, int vw, int vh) {
    super();
    this.id = id;
    this.vx = vx;
    this.vy = vy;
    this.vw = vw;
    this.vh = vh;

    PApplet.runSketch(new String[] { this.getClass().getName() }, this);
  }

  void settings() {
    size(vw, vh, P2D);
    smooth(0);
    println("Creating window "+ id);
  }

  void setup() {
    surface.setLocation(vx, vy);
    surface.setResizable(true);
  }

  void draw() {
    background(bckColor);
    textAlign(CENTER, CENTER);
    text("CHILD window "+ id, width/2, height/2);

    translate(mouseX, mouseY);
    shape(pointer);

    String txt = String.format("Window %d   %6.2fps", id, frameRate);
    surface.setTitle(txt);
  }
}
