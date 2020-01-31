import java.util.*;

class ScreenCoords{
  public int left, top, w, h;
  
  public ScreenCoords(int marginWidth, int marginHeight, int w, int h) {
    this.left = marginWidth;
    this.top = marginHeight;
    this.w = w;
    this.h = h;
  }
}



class GB{
  private Afficheur afficheur;
  private Theme theme;
  private ModeGest modes;
  private ArrayList <CanvasButton> buttons;
  
  public GB(ScreenCoords sc){
    this.theme = new Theme("Gameboy.png", sc);
    
    this.afficheur = new Afficheur(
      (int)(sc.left + (sc.w * 0.1)), 
      (int)(sc.top + (sc.h * 0.1)), 
      (int)(sc.h / 2.35), 
      (int)(sc.h / 2.35)
    );
    
    //this.mode = new ModeAccueil("Menu principal",afficheur);
    this.modes = new ModeGest(afficheur);
    
    this.buttons = new ArrayList<CanvasButton>() ;
    
    int btnSize = (int)(sc.w * 0.12);
    this.buttons.add(new CanvasButton( "←", 
      (int)(sc.left + (sc.w * 0.07)),  
      (int)(sc.top + (sc.h * 0.71)),  
      btnSize, btnSize, false));
      
    this.buttons.add(new CanvasButton( "→", 
      (int)(sc.left + (sc.w * 0.29)),  
      (int)(sc.top + (sc.h * 0.71)),   
      btnSize, btnSize, false));
      
    this.buttons.add(new CanvasButton( "↑", 
      (int)(sc.left + (sc.w * 0.18)),  
      (int)(sc.top + (sc.h * 0.65)),  
      btnSize, btnSize, false));
      
    this.buttons.add(new CanvasButton( "↓", 
      (int)(sc.left + (sc.w * 0.18)),  
      (int)(sc.top + (sc.h * 0.77)),  
      btnSize, btnSize, false));
    
    this.buttons.add(new CanvasButton( "B", 
      (int)(sc.left + (sc.w * 0.645)),  
      (int)(sc.top + (sc.h * 0.71)),  
      btnSize, btnSize, false));
      
    this.buttons.add(new CanvasButton( "A", 
      (int)(sc.left + (sc.w * 0.81)),  
      (int)(sc.top + (sc.h * 0.665)),  
      btnSize, btnSize, false));
    
    int ssBtnSize = (int)(sc.w * 0.15);
    this.buttons.add(new CanvasButton( "select", 
      (int)(sc.left + (sc.w * 0.34)),  
      (int)(sc.top + (sc.h * 0.86)),
      ssBtnSize, ssBtnSize, false));
      
    this.buttons.add(new CanvasButton( "start", 
      (int)(sc.left + (sc.w * 0.5)),  
      (int)(sc.top + (sc.h * 0.86)),
      ssBtnSize, ssBtnSize, false));
    
    
    int optBtnSize = (int)(sc.w * 0.05);
    int optBtnZ = (int)(sc.top + (sc.h * 0.95));
    this.buttons.add(new CanvasButton( "clearLog", 
      (int)(sc.left + (sc.w * 0.7)),  
      optBtnZ, 
      optBtnSize, optBtnSize, true));
    this.buttons.add(new CanvasButton( "affColor", 
      (int)(sc.left + (sc.w * 0.8)),  
      optBtnZ, 
      optBtnSize, optBtnSize, true));
    this.buttons.add(new CanvasButton( "btnColor", 
      (int)(sc.left + (sc.w * 0.9)),  
      optBtnZ, 
      optBtnSize, optBtnSize, true));
  }
  
  public void show(){
      this.theme.show();
      
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
  
  public void released(){
    this.modes.released();
  }
}



GB gb;
void setup() {
  // size(480,800,P3D);
  fullScreen(P3D);
  textSize((int)(height*0.012));
  
  int marginWidth = (int)(0.025*width);
  int w = (int)(width - 2*marginWidth) ;
    
  int h = (int)(width / (9.0f/16));
  int marginHeight = (int)((height-h)/2);
  
  ScreenCoords sc = new ScreenCoords(marginWidth, marginHeight, w, h);
  gb = new GB(sc);
}

void draw() {
  clear();
  gb.show();
}

void mousePressed() {
  gb.event(mouseX,mouseY);
}

void mouseReleased(){
  //Debugger.disp("mouseReleased() , "+mouseX+"  "+mouseY);
  gb.released();
}

void clear(){
  background(Color.bgColor.r ,Color.bgColor.g,Color.bgColor.b);
}