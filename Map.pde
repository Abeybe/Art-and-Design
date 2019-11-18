//
//Application 
//piece of processing function is need "p." before this.
//(rect,line,stroke,image...)

float cell=0;
int split=4;

String[] directions={"N","E","S","W"};

class Map{
  PApplet p;
  color bgColor=color(128);
  Object home;
  Item[] items=new Item[4];
  Road[] roads=new Road[4];
  Map(PApplet _p){
    p=_p;
    width=p.width;
    height=p.height;
    cell=width/split;
    bgColor=color(random(360),50,90);
    
    home=new Object("home",new PVector(cell,cell),new PVector(cell,cell));
    
    int num0=(int)random(directions.length);
    roads[0]=new Road(directions[num0]);
    int num1=(int)random(directions.length);
    while(num0==num1)num1=(int)random(directions.length);
    roads[1]=new Road(directions[num1]);
    
  }//Map constructor  
  void draw(){
    p.fill(bgColor);p.noStroke();p.rect(0,0,width,height);noFill();
    
    p.stroke(0);p.strokeWeight(1);
    for(int w=0;w<width;w+=width/split)p.line(w,0,w,height);
    for(int h=0;h<height;h+=width/split)p.line(0,h,width,h);
    p.noStroke();
    
    home.draw();
    for(int i=0;i<roads.length && roads[i]!=null;i++){
      roads[i].draw();
    }
    
  }//Map draw
  
  class Road extends Object{
    Road(String dir){
      super("road",null,null);
      pos=new PVector(2*cell,2*cell);
      switch(dir){
        case "N":
          size=new PVector(cell,-2*cell);
        break;
        case "E":
          size=new PVector(-2*cell,cell);
        break;
        case "S":
          size=new PVector(cell,6*cell*height/width);
        break;
        case "W":
          size=new PVector(-2*cell,cell);
        break;
        default:break;
      }
    }
  }
  
  class Object extends Item{
    Object(String _name,PVector _pos,PVector _size){
      super(_name,_pos,_size);
    }//Map Object C
  }//Map Object
  class Item{
    PVector pos,size;
    String name;
    PImage image;
    Item(String _name,PVector _pos,PVector _size){
      name=_name;
      try{
        image=loadImage("img/"+name+".png");
      }catch(Exception e){}
      pos=_pos;size=_size;
    }//Map Item C
    void draw(){
      if(image!=null)p.image(image,pos.x,pos.y,size.x,size.y);
      else{
        fill(0,128);p.rect(pos.x,pos.y,size.x,size.y);noFill();
      }
    }//Map Item draw
  }//Map Item
}//Map
