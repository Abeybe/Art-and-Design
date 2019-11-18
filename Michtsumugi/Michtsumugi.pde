//
//This pde file is not visible
//

void settings(){
  size(0,0);
}//settings

void setup(){
  surface.setVisible(false);
  colorMode(HSB,360,100,100,100);
  
  String[] args={"Screen"};
  PApplet screen1=new Screen("Taro");
  PApplet.runSketch(args,screen1);
  PApplet screen2=new Screen("Jiro");
  PApplet.runSketch(args,screen2);
}//setup

void draw(){
  
}//draw
