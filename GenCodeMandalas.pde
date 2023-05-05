String version = "_v11_";

import processing.svg.*;
import controlP5.*;

boolean record;

//ControlP5 cp5;
//Accordion accordion;

String seed = "";

int anz, depth;
int sides;
int transparency, triangle_angle, triangle_height;
float angle;
PVector center;
PTree tree;

boolean light, style, animate, animate_record;

void setup() {
  fullScreen();
  setupGui();
  background(0);

  anz = 3;
  center = new PVector(width / 2, height / 2);
  tree = new PTree(center, center, 0);

  light = true;
  style = true;
  animate = false;

  String seed = "F9FD82430B45EC422DD8B76CD78BE1D2CEF5E5ECC8E3915B6D26575D110";
  applySeed(seed);
  myTextfield.setText(seed);
}

void draw() {
  handleRecording();
  handleAnimation();

  updateTreeParameters();
  renderTree();
  myTextfield.setText(generateMandalaHexCode());
}

void keyPressed() {
  record = true;
  if (key == 'a') {
    animate = true;
    record = true;
  }
}

void applySeed(String seed) {
  color_1 = unhex(seed.substring(00, 06));
  color_2 = unhex(seed.substring(06, 12));
  color_3 = unhex(seed.substring(12, 18));
  color_4 = unhex(seed.substring(18, 24));
  color_5 = unhex(seed.substring(24, 30));
  color_6 = unhex(seed.substring(30, 36));
  color_7 = unhex(seed.substring(36, 42));
  color_8 = unhex(seed.substring(42, 48));

  anz = unhex(seed.substring(48, 49));
  depth = unhex(seed.substring(49, 50));
  sides = unhex(seed.substring(50, 52));
  transparency = unhex(seed.substring(52, 54));
  triangle_angle = unhex(seed.substring(54, 57));
  triangle_height = unhex(seed.substring(57, 59));
}

void handleRecording() {
  if (record) {
    if (animate) {
      cp5.hide();
      saveFrame(generateFilePath(".png"));
    } else {
      beginRecord(SVG, generateFilePath(".svg"));
    }
  }
}

void handleAnimation() {
  if (animate) {
    triangle_angle = (triangle_angle + 1) % 4096;
    cp5.get("sli_triangle_angle").setValue(triangle_angle);
    myTextfield.setText(generateMandalaHexCode());
  }
}

void updateTreeParameters() {
  tree.setTransparency(int(transparency));
  tree.setAngle(map(triangle_angle, 0, 4095, -PI + 0.00000012, PI));
  tree.setTriangleHeight(map(triangle_height, 0, 255, -1, 1));
}

void renderTree() {
  if (light) background(255);
  else background(0);

  pushMatrix();
  translate(width / 2, height / 2);
  angle = TWO_PI / (anz + 5);
  PVector positions[] = new PVector[2];
  PVector pos = new PVector(0, -1);
  pos = pos.mult(sides);
  for (int i = 0; i < 2; i++) {
    pos.rotate(angle);
    positions[i] = pos.copy();
  }
  tree.init(positions[0], positions[1], depth + 5);
  for (int i = 1; i <= anz + 5; i++) {
    tree.display(style);
    rotate(angle);
  }
  popMatrix();

  if (record) {
    endRecord();
    if (!animate) record = false;
    else {
      if (triangle_angle == 4095) record = false;
    }
  }
}

String generateFilePath(String extension) {
  return "generated/" +
    hex(color_1, 6) + hex(color_2, 6) + hex(color_3, 6) + hex(color_4, 6) +
    hex(color_5, 6) + hex(color_6, 6) + hex(color_7, 6) + hex(color_8, 6) +
    hex(anz, 1) + hex(depth, 1) + hex(sides, 2) + hex(transparency, 2) +
    hex(triangle_angle, 3) + hex(triangle_height, 2) + extension;
}
