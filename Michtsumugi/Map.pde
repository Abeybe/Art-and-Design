//Application 
//piece of processing function is need "p." before this.
//(rect,line,stroke,image...)

float cell=0;
int split=4;

String[] directions={"N","E","S","W"};

class Map{
  Screen p;
  PImage grand;
  Object home;
  Item[] items=new Item[4];
  Road[] roads=new Road[4];
  boolean[] cells;//fill cells
  PVector cellNum;
  Map(Screen _p){
    grand=loadImage("img/grand"+"_"+rndStr("red","green")+".png");
    p=_p;
    width=p.width;
    height=p.height;
    cell=width/split;
    cellNum=new PVector(split,split*height/width,split*split*height/width);

    cells=new boolean[(int)cellNum.z];
    
    home=new Object("home",rndStr("red","green","blue"),new PVector(cell,cell),new PVector(cell,cell));
    
    int num0=(int)random(directions.length);
    roads[0]=new Road(directions[num0]);
    int num1=(int)random(directions.length);
    while(num0==num1)num1=(int)random(directions.length);
    roads[1]=new Road(directions[num1]);

    items[0]=new Car();

    System.out.print(
      "\nuser name : "+p.userName
      +"\nscreen size : "+width+"x"+height
      +"\ncell number : "+(int)cellNum.x+"x"+(int)cellNum.y+" "+(int)cellNum.z+"cells"
      +"\nhome type : "+home.type
      +"\nroad : "+roads[0].dir+","+roads[1].dir
      +"\ncar position : "+items[0].pos.x+","+items[0].pos.y
      +"\ncar type : "+items[0].type
      +"\n");
    
  }//Map constructor  
  void draw(){
    p.image(grand,0,0,width,height);
    
    p.stroke(0);p.strokeWeight(1);
    for(int w=0;w<width;w+=width/split)p.line(w,0,w,height);
    for(int h=0;h<height;h+=width/split)p.line(0,h,width,h);
    p.noStroke();
    home.draw();
    for(int i=0;i<roads.length && roads[i]!=null;i++){
      roads[i].draw();
    }
    for(int i=0;i<items.length && items[i]!=null;i++){
      items[i].draw();
    }

  if(p.keyPressed){
    for(int i=0;i<cells.length;i++){
      System.out.print((cells[i])?"1 ":"0 ");
      if(i%split==split-1)System.out.print("\n");
    }
    System.out.print("\n\n");
  }

  }//Map draw
  
  // inner class

  class Road extends Object{
    String dir;
    Road(String _dir){
      super("road",null,null,null);
      dir=_dir;
      pos=new PVector(2*cell,2*cell);
      switch(dir){
        case "N":
          pos.add(0,cell);
          size=new PVector(cell,-3*cell);
        break;
        case "E":
          size=new PVector(2*cell,cell);
        break;
        case "S":
          size=new PVector(cell,6*cell*height/width);
        break;
        case "W":
          pos.add(cell,0);
          size=new PVector(-3*cell,cell);
        break;
        default:break;
      }
      fillCells(this);      
    }
  }
  
  class Car extends Item{
    float rot=0;
    float startRot=0;
    PVector startPos;
    Car(){
      super("car",rndStr("red","green","blue"),null,new PVector(cell,cell));
      switch(roads[0].dir){
        case "N":
          pos=new PVector(2*cell,0);
          rot=0;
        break;
        case "E":
          pos=new PVector(split*cell,2*cell);
          rot=PI/2;
        break;
        case "S":
          pos=new PVector(2*cell,split*height/width*cell);
          rot=PI;
        break;
        case "W":
          pos=new PVector(0,2*cell);
          rot=PI*3/2;
        break;
        default:break;
      }
      startPos=pos.copy();  
      startRot=rot;    
    }
    void move(){
      if(pos.x<-cell || width+cell<pos.x || pos.y<-cell || height+cell<pos.y){
        pos=startPos.copy();
        rot=startRot;
      }
      
      pos.add(-sin(rot),cos(rot));
      
      PVector step=pos.copy().add(-sin(rot),cos(rot));
      if(pos2cell(step)>=0 && cells[pos2cell(step)]==false){
        step=pos.copy().add(-sin(rot+PI/2),cos(rot+PI/2));
        if(pos2cell(step)>=0 && cells[pos2cell(step)]==false)rot+=PI/2;
        else{
          step=pos.copy().add(-sin(rot-PI/2),cos(rot-PI/2));
          if(pos2cell(step)>=0 && cells[pos2cell(step)]==false)rot-=PI/2;
        }
      }
    }
    void draw(){
      move();
      p.translate(pos.x+size.x/2,pos.y+size.y/2);
      p.rotate(rot);
      if(image!=null)p.image(image,0,0,size.x,size.y);
      else{
        fill(0,128);p.rect(0,0,size.x,size.y);noFill();
      }
    }
  }

  class Object extends Item{
    Object(String _name,String _type,PVector _pos,PVector _size){
      super(_name,_type,_pos,_size);
    }//Map Object C
  }//Map Object
  class Item{
    PVector pos,size;
    String name;
    String type;
    PImage image;
    Item(String _name,String _type,PVector _pos,PVector _size){
      name=_name;type=_type;
      try{
        String fileName=(type!=null)?name+"_"+type:name;
        image=loadImage("img/"+fileName+".png");
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

  String rndStr(String... str){
    return str[(int)random(str.length)];
  } 
  int pos2cell(PVector pos){
    int cn=int(pos.x/cell)+split*int(pos.y/cell);
    return (cn<0 || cellNum.z<=cn)?-1:cn;
  }
  PVector cell2pos(int num){
    return new PVector(num%cellNum.x,num/cellNum.y);
  }
  void fillCells(Item item){
    PVector dir=new PVector((item.size.x>=0)?1:-1,(item.size.y>=0)?1:-1);
    for(int x=(dir.x>0)?0:-1;(dir.x>0)?x<item.size.x/cell:item.size.x/cell<=x;x+=dir.x){
      for(int y=(dir.y>0)?0:-1;(dir.y>0)?y<item.size.y/cell:item.size.y/cell<=y;y+=dir.y){
        int num=int(item.pos.x/cell)+x+split*(int(item.pos.y/cell)+y);
        if(0<=num && num<cellNum.z)cells[num]=true;
      }
    }
  }
}//Map