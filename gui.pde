Textfield myTextfield;

String textValue = "testtest";

String color_wheel_plug = null;
void gui() {

  cp5 = new ControlP5(this);

  Group g1 = cp5.addGroup("Colors")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(180)
    ;
  cp5.addColorWheel("color_1", 20, 10, 60 )
    .moveTo(g1)
    .setRGB(color_1);
  cp5.addColorWheel("color_2", 20, 90, 60 )
    .moveTo(g1)
    .setRGB(color_2);
  cp5.addColorWheel("color_3", 100, 10, 60 )
    .moveTo(g1)
    .setRGB(color_3);
  cp5.addColorWheel("color_4", 100, 90, 60 )
    .moveTo(g1)
    .setRGB(color_4);
  cp5.addColorWheel("color_5", 180, 10, 60 )
    .moveTo(g1)
    .setRGB(color_5);
  cp5.addColorWheel("color_6", 180, 90, 60 )
    .moveTo(g1)
    .setRGB(color_6);
  cp5.addColorWheel("color_7", 260, 10, 60 )
    .moveTo(g1)
    .setRGB(color_7);
  cp5.addColorWheel("color_8", 260, 90, 60 )
    .moveTo(g1)
    .setRGB(color_8);

  Group g2 = cp5.addGroup("Settings")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(200)
    ;

  cp5.addBang("b_shuffle")
    .setPosition(10, 20)
    .setSize(40, 50)
    .moveTo(g2)
    ;

  cp5.addSlider("sli_depth")
    .setPosition(70, 50)
    .setSize(100, 20)
    .setRange(0, 15)
    .setValue(5)
    .moveTo(g2)
    ;

  cp5.addSlider("sli_size")
    .setPosition(70, 80)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(75)
    .moveTo(g2)
    ;

  cp5.addSlider("sli_anz")
    .setPosition(70, 20)
    .setSize(100, 20)
    .setRange(0, 15)
    .setValue(5)
    .moveTo(g2)
    ;

  cp5.addSlider("sli_transparency")
    .setPosition(70, 110)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(5)
    .moveTo(g2)
    ;

  cp5.addSlider("sli_triangle_angle")
    .setPosition(70, 140)
    .setSize(100, 20)
    .setRange(0, 4095)
    .setValue(0)
    .moveTo(g2)
    ;

  cp5.addSlider("sli_triangle_height")
    .setPosition(70, 170)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(0)
    .moveTo(g2)
    ;

  // group number 3, contains a radiobutton
  Group g3 = cp5.addGroup("Generate")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
    ;

  cp5.addBang("random_colors")
    .setPosition(10, 20)
    .setSize(40, 50)
    .moveTo(g3)
    ;

  cp5.addBang("all_random")
    .setPosition(100, 20)
    .setSize(40, 50)
    .moveTo(g3)
    ;

  cp5.addBang("light")
    .setPosition(190, 20)
    .setSize(40, 50)
    .moveTo(g3)
    ;

  cp5.addBang("style")
    .setPosition(280, 20)
    .setSize(40, 50)
    .moveTo(g3)
    ;

  cp5.addBang("animate")
    .setPosition(10, 90)
    .setSize(40, 50)
    .moveTo(g3)
    ;

  myTextfield = cp5.addTextfield("hex")
    .setPosition(20, height-80)
    .setSize(200, 40)
    .setAutoClear(false)
    ;

  cp5.addBang("seed")
    .setPosition(240, height-80)
    .setSize(80, 40)
    ;    
  accordion = cp5.addAccordion("acc")
    .setPosition(40, 40)
    .setWidth(350)
    .addItem(g1)
    .addItem(g2)
    .addItem(g3)
    ;

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.open(0, 1, 2);
    }
  }
  , 'o');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.close(0, 1, 2);
    }
  }
  , 'c');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setWidth(300);
    }
  }
  , '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setPosition(0, 0);
      accordion.setItemHeight(190);
    }
  }
  , '2'); 
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.ALL);
    }
  }
  , '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.SINGLE);
    }
  }
  , '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      cp5.remove("myGroup1");
    }
  }
  , '0');

  accordion.open(0, 1, 2);
  accordion.setCollapseMode(Accordion.MULTI);
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
