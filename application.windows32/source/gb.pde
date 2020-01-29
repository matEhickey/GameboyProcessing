import java.util.*;


class GB{
  private Afficheur afficheur;
  private Theme theme;
  private ModeGest modes;
  private ArrayList <CanvasButton> buttons;
  
  public GB(){
    this.theme = new Theme("Gameboy.jpg");
    this.afficheur = new Afficheur(30,45,410,410);
    //this.mode = new ModeAccueil("Menu principal",afficheur);
    this.modes = new ModeGest(afficheur);
    
    this.buttons = new ArrayList<CanvasButton>() ;
    
    this.buttons.add(new CanvasButton( "←",40,568,50,52,false));
    this.buttons.add(new CanvasButton( "→", 140,568,50,52,false));
    this.buttons.add(new CanvasButton( "↑", 90,518,50,50,false));
    this.buttons.add(new CanvasButton( "↓", 90,620,50,50,false));
    
    this.buttons.add(new CanvasButton( "B", 309,567,55,55,false));
    this.buttons.add(new CanvasButton( "A", 388,532,55,55,false));
    
    this.buttons.add(new CanvasButton( "clearLog", 290,770,20,20,true));
    this.buttons.add(new CanvasButton( "affColor", 410,770,20,20,true));
    this.buttons.add(new CanvasButton( "btnColor", 450,770,20,20,true));
    
    this.buttons.add(new CanvasButton( "select", 162,695,65,55,false));
    this.buttons.add(new CanvasButton( "start", 240,695,65,55,false));
  }
  
  public void show(){
      this.theme.show();
  //afficheur.show();
      try{
        this.modes.show();
      } 
      catch(Exception e) {
        Debugger.disp("modegest.show()  : "+e.toString());
      }
      //Affichage bouttons
      Iterator<CanvasButton> it = this.buttons.iterator() ;
      CanvasButton ite;
      while(it.hasNext()){
        ite = it.next();
        ite.show();
      }
      this.showDebugger();
  }
  
  private void showDebugger(){
      //affichage debugger
      fill(Debugger.textColor.r,Debugger.textColor.g,Debugger.textColor.b);
      ArrayList<Message> messages = (ArrayList)Debugger.getMessages();
      Iterator <Message> itS = messages.iterator();
      Message mess = null;
      while(itS.hasNext()){
        mess = itS.next();
        text(mess.message,mess.x,mess.y);
      }
  }
  
  public void event(int mouseX, int mouseY){
    Iterator<CanvasButton> it = this.buttons.iterator() ;
    CanvasButton ite;
    CanvasButton clicked =null;
    while (it.hasNext() ) {
      ite = it.next() ;
      if(ite.pressed(mouseX, mouseY )){
        clicked = ite;
      }
    }
    if(clicked != null) {
        //Debugger.disp("clicked : "+clicked);
        if(clicked.name == "bgColor"){
          Color.bgColor = new Color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
        }
        else if(clicked.name == "affColor"){
          Color.affColor = new Color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
        }
        else if(clicked.name == "btnColor"){
          Color.btnColor = new Color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
        }
        
        else if(clicked.name =="clearLog"){ Debugger.clear(); }
        //else if(clicked.name =="start"){ Debugger.disp("click start");  }
        //else if(clicked.name =="select"){ Debugger.disp("click select");  }
        
        try{ this.modes.event(clicked.name); } 
        catch(Exception e) { Debugger.disp("modegest.event():  "+e.toString()); }
     } 
  }
}



GB gb;
void setup() {
  size(480,800);
  gb = new GB();
}

void draw() {
  clear();
  gb.show();
}

void mousePressed() {
  gb.event(mouseX,mouseY);
}

void clear(){
  background(Color.bgColor.r ,Color.bgColor.g,Color.bgColor.b);
}