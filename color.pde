color 
  color_1 = #CC6666,  // red
  color_2 = #DE935F,  // orange
  color_3 = #F0C674,  // yellow
  color_4 = #B5BD68,  // green
  color_5 = #8ABEB7,  // cyan
  color_6 = #81A2BE,  // blue
  color_7 = #B294BB,  // purple
  color_8 = #A3685A;  // brown

color getColor(int num) {
  num = (num + 4)%8;
  switch(num) {
  case 0: 
    return color_1; // red
  case 1: 
    return color_2; // orange
  case 2: 
    return color_3; // yellow
  case 3: 
    return color_4; // green
  case 4: 
    return color_5; // cyan
  case 5: 
    return color_6; // blue
  case 6: 
    return color_7; // purple
  case 7: 
    return color_8; // brown
  default: 
    return 0;
  }
}
