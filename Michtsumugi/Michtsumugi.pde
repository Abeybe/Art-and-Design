//
//This pde file is not visible
//

void settings(){
  size(0,0);
}//settings

void setup(){
  surface.setVisible(false);
  colorMode(HSB,360,100,100,100);
  
  String[] args={"Taro"};
  PApplet screen1=new Screen();
  PApplet.runSketch(args,screen1);
  args[0]="Jiro";
  PApplet screen2=new Screen();
  PApplet.runSketch(args,screen2);
}//setup

void draw(){
  
}//draw
