// GUI Elements
ControlP5 cp5;
Accordion accordion;
Textfield myTextfield;

String textValue = "testtest";
String color_wheel_plug = null;

void setupGui() {
  cp5 = new ControlP5(this);

  Group colorsGroup = createColorsGroup();
  Group settingsGroup = createSettingsGroup();
  Group generateGroup = createGenerateGroup();

  setupAccordion(colorsGroup, settingsGroup, generateGroup);
  setupHexInput();
  setupSeedButton();
}

Group createColorsGroup() {
  Group g1 = cp5.addGroup("Colors")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(180);

  for (int i = 0; i < 8; i++) {
    cp5.addColorWheel("color_" + (i + 1), 20 + 80 * (i % 4), 10 + 80 * (i / 4), 60)
      .moveTo(g1)
      .setRGB(color(0));
  }

  return g1;
}

Group createSettingsGroup() {
  Group g2 = cp5.addGroup("Settings")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(200);

  cp5.addBang("b_shuffle")
    .setPosition(10, 20)
    .setSize(40, 50)
    .moveTo(g2);

  createSlider(g2, "sli_depth", 70, 50, 0, 15, 5);
  createSlider(g2, "sli_size", 70, 80, 0, 255, 75);
  createSlider(g2, "sli_anz", 70, 20, 0, 15, 5);
  createSlider(g2, "sli_transparency", 70, 110, 0, 255, 5);
  createSlider(g2, "sli_triangle_angle", 70, 140, 0, 4095, 0);
  createSlider(g2, "sli_triangle_height", 70, 170, 0, 255, 0);

  return g2;
}

void createSlider(Group parentGroup, String name, int x, int y, int min, int max, int value) {
  cp5.addSlider(name)
    .setPosition(x, y)
    .setSize(100, 20)
    .setRange(min, max)
    .setValue(value)
    .moveTo(parentGroup);
}

Group createGenerateGroup() {
  Group g3 = cp5.addGroup("Generate")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150);

  cp5.addBang("random_colors")
    .setPosition(10, 20)
    .setSize(40, 50)
    .moveTo(g3);

  cp5.addBang("all_random")
    .setPosition(100, 20)
    .setSize(40, 50)
    .moveTo(g3);

  cp5.addBang("light")
    .setPosition(190, 20)
    .setSize(40, 50)
    .moveTo(g3);

  cp5.addBang("style")
    .setPosition(280, 20)
    .setSize(40, 50)
    .moveTo(g3);

  cp5.addBang("animate")
    .setPosition(10, 90)
    .setSize(40, 50)
    .moveTo(g3);

  return g3;
}

void setupAccordion(Group colorsGroup, Group settingsGroup, Group generateGroup) {
  accordion = cp5.addAccordion("acc")
    .setPosition(40, 40)
    .setWidth(350)
    .addItem(colorsGroup)
    .addItem(settingsGroup)
    .addItem(generateGroup);

  setupAccordionKeys();

  accordion.open(0, 1, 2);
  accordion.setCollapseMode(Accordion.MULTI);
}

void setupAccordionKeys() {
  cp5.mapKeyFor(createControlKey(() -> accordion.open(0, 1, 2)), 'o');
  cp5.mapKeyFor(createControlKey(() -> accordion.close(0, 1, 2)), 'c');
  cp5.mapKeyFor(createControlKey(() -> accordion.setWidth(300)), '1');
  cp5.mapKeyFor(createControlKey(() -> {
    accordion.setPosition(0, 0);
    accordion.setItemHeight(190);
  }), '2');
  cp5.mapKeyFor(createControlKey(() -> accordion.setCollapseMode(ControlP5.ALL)), '3');
  cp5.mapKeyFor(createControlKey(() -> accordion.setCollapseMode(ControlP5.SINGLE)), '4');
  cp5.mapKeyFor(createControlKey(() -> cp5.remove("myGroup1")), '0');
}

ControlKey createControlKey(Runnable action) {
  return new ControlKey() {
    public void keyEvent() {
      action.run();
    }
  };
}

void setupHexInput() {
  myTextfield = cp5.addTextfield("hex")
    .setPosition(20, height - 80)
    .setSize(400, 40)
    .setAutoClear(false);
}

void setupSeedButton() {
  cp5.addBang("seed")
    .setPosition(440, height - 80)
    .setSize(80, 40);
}

public void b_shuffle() {
  cp5.get("sli_anz").setValue((int)random(0, 15));
  cp5.get("sli_depth").setValue((int)random(0, 15));
  cp5.get("sli_transparency").setValue((int)random(1, 255));
  cp5.get("sli_triangle_angle").setValue((int)random(0, 4095));
  cp5.get("sli_triangle_height").setValue((int)random(0, 255));
}

public void sli_anz(int theValue) {
  int step = abs(anz-theValue);
  if (theValue > anz) sides += step;
  if (theValue < anz) sides -= step;
  cp5.get("sli_size").setValue(sides);
  anz = theValue;
}

public void sli_depth(int theValue) {
  depth = theValue;
}

public void sli_size(int theValue) {
  sides = theValue;
}

public void sli_transparency(int theValue) {
  transparency = theValue;
}

public void sli_triangle_angle(int theValue) {
  triangle_angle = theValue;
}

public void sli_triangle_height(int theValue) {
  triangle_height = theValue;
}

public void random_colors() {
  cp5.get(ColorWheel.class, "color_1").setRGB(color(random(255), random(255), random(255)));
  cp5.get(ColorWheel.class, "color_2").setRGB(color(random(255), random(255), random(255)));
  cp5.get(ColorWheel.class, "color_3").setRGB(color(random(255), random(255), random(255)));
  cp5.get(ColorWheel.class, "color_4").setRGB(color(random(255), random(255), random(255)));
  cp5.get(ColorWheel.class, "color_5").setRGB(color(random(255), random(255), random(255)));
  cp5.get(ColorWheel.class, "color_6").setRGB(color(random(255), random(255), random(255)));
  cp5.get(ColorWheel.class, "color_7").setRGB(color(random(255), random(255), random(255)));
  cp5.get(ColorWheel.class, "color_8").setRGB(color(random(255), random(255), random(255)));
}

public void all_random() {
  random_colors();
  b_shuffle();
}

public void light() {
  light = !light;
}

public void style() {
  style = !style;
}

public void animate() {
  animate = !animate;
}

public void seed() {
  applySeed(myTextfield.getText());
}

public String generateMandalaHexCode() {
  String hexCode = "";
  for (int i = 1; i <= 8; i++) {
    ColorWheel cw = cp5.get(ColorWheel.class, "color_" + i);
    int colorValue = cw.getRGB();
    hexCode += String.format("%02x%02x%02x", (colorValue >> 16) & 0xFF, (colorValue >> 8) & 0xFF, colorValue & 0xFF);
  }

  hexCode += String.format("%01x", anz);
  hexCode += String.format("%01x", depth);
  hexCode += String.format("%02x", sides);
  hexCode += String.format("%02x", transparency);
  hexCode += String.format("%03x", triangle_angle);
  hexCode += String.format("%02x", triangle_height);

  return hexCode;
}
