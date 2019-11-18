//
//Phone Screen
//

class Screen extends PApplet{
  String userName;  
  Map map;
  
  void settings(){
    size(450,800);
  }//Screen settings
  
  void setup(){
    
    map=new Map(this);
    
  }//Screen setup
  
  void draw(){
    background(0);
    
    map.draw();
    
  }//Screen draw
}//Screen
