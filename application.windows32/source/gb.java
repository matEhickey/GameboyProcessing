import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class gb extends PApplet {




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
    
    this.buttons.add(new CanvasButton( "\u2190",40,568,50,52,false));
    this.buttons.add(new CanvasButton( "\u2192", 140,568,50,52,false));
    this.buttons.add(new CanvasButton( "\u2191", 90,518,50,50,false));
    this.buttons.add(new CanvasButton( "\u2193", 90,620,50,50,false));
    
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
public void setup() {
  
  gb = new GB();
}

public void draw() {
  clear();
  gb.show();
}

public void mousePressed() {
  gb.event(mouseX,mouseY);
}

public void clear(){
  background(Color.bgColor.r ,Color.bgColor.g,Color.bgColor.b);
}

public class Afficheur{
  private int x;
  private int y;
  private int sX;
  private int sY;
  
  public Afficheur(int x, int y, int sX, int sY){
    this.x = x;
    this.y = y;
    this.sX = sX;
    this.sY = sY;
  }
  
  public void background(int r, int g, int b){
    Color.bgColor = new Color(r,g,b);
  }
  
  public void show(){
    fill(Color.affColor.r,Color.affColor.g,Color.affColor.b);
    rect(x,y,sX,sY);
    rect(this.x+20,this.y+20,this.lenX(),this.lenY());
  }
  
  public int x(int x){ return(x+this.x+20); }
  public int y(int y){ return(y+this.y+20); }
  public int lenX(){ return(this.sX-40); }
  public int lenY(){ return(this.sY-40); }
  public int maxX() { return(this.x+20+this.lenX());}
  public int maxY() { return(this.y+20+this.lenY());}
}
class CanvasButton {
  private int x,y;
  private int sX, sY;
  public String name;
  public Boolean display;
  
  CanvasButton (String name, int x, int y) {
    this.x= x;
    this.y= y;
    this.sX=50;
    this.sY=50;
    this.name = name;
    this.display = true;
  }
  CanvasButton (String name, int x, int y , int sX, int sY, Boolean display){
    this(name, x, y);
    this.sX = sX;
    this.sY = sY;
    this.display = display;
  }
  public void show() {
    if(this.display){
      fill(Color.btnColor.r,Color.btnColor.g,Color.btnColor.b);
      rect(this.x,this.y,this.sX,this.sY) ;
      if(this.name.length()<3){
      fill(Color.txtBtnColor.r,Color.txtBtnColor.g,Color.txtBtnColor.b);
        text(this.name,(this.x+this.x+this.sX)/2 -5,(this.y+this.y+this.sY)/2 +5) ;
      }
    }
  }
  public Boolean pressed(int x,int y) {
    if((x>this.x)&&(x<this.x+this.sX)) {
      if((y>this.y)&&(y<this.y+this.sY)){
        return(true) ;
      }
    }
    return(false) ;
  }
  
  public String toString(){
    return(this.name.toUpperCase());
  }
}
class CatalogueJeux{
    public List<Jeu> jeux;
    public Afficheur afficheur;
    private int indexSelec;
    private ModeJeu mode;
    
    
        
    public CatalogueJeux(Afficheur afficheur, ModeJeu mode){
      this.afficheur = afficheur;
      this.jeux = new ArrayList<Jeu>();
      this.indexSelec = 0;
      this.mode = mode;
      
      this.initGames();
    }
    
    public void initGames(){
      this.addJeu(new SampleGame("Sample Game", "logo.jpg","Il s'agit d'un exemple d'un composant dirig\u00e9 par les fl\u00e8ches", this.afficheur, this.mode));
      this.addJeu(new TestJeu("Test1", "logo.jpg","Ce jeu est un template", this.afficheur, this.mode));
      this.addJeu(new TestJeu("Test2", "logo.jpg","Ce jeu est un deuxieme template", this.afficheur, this.mode));
    }
    
    public void addJeu(Jeu jeu){
      this.jeux.add(jeu);
    }
    
    public Jeu getJeu(){
     return(jeux.get(this.indexSelec)); 
    }
    
    public void show(){
      int x = this.afficheur.x(0);
      int y = this.afficheur.y(0);
      fill(Color.txtColor.r,Color.txtColor.g,Color.txtColor.b);
      text("Catalogue de jeux ("+this.jeux.size()+")",x+10,y+100);
      
      fill(Color.affColor.r,Color.affColor.g,Color.affColor.b);
      rect(x+30,y+120,this.afficheur.lenX()-60,50);
      
      fill(Color.txtColor.r,Color.txtColor.g,Color.txtColor.b);
      text(this.jeux.get(this.indexSelec).name,x+70,y+150);
      
      text(this.jeux.get(this.indexSelec).description,x+20,y+230);
      
      text("\u2191",x+40,y+142);
      text("\u2193",x+40,y+158);
    }
    
    public void event(String button){
      //Debugger.disp(button);  
          if(button == "\u2193"){
            if(this.indexSelec>=this.jeux.size()-1){ this.indexSelec = 0; }
            else{this.indexSelec+=1;}
            
          }else if(button == "\u2191"){
            if(this.indexSelec<=0){ this.indexSelec = this.jeux.size()-1; }
            else{
              this.indexSelec-=1;
            }
          }
    }
    
}
static class Color{
  static Color GRAY = new Color(198,198,198);
  static Color DARKGRAY = new Color(130,130,130);
  static Color BLUE = new Color(0,0,255);
  static Color WHITE = new Color(255,255,255);
  
  static Color btnColor = Color.DARKGRAY;
  static Color txtBtnColor = Color.WHITE;
  
  static Color txtColor = Color.WHITE;
  
  
  static Color affTheme1 = new Color(81,100,21);
  
  static Color bgColor = Color.GRAY;
  static Color affColor = Color.affTheme1;
  
  
  public int r;
  public int g;
  public int b;
  public Color(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
}


static class Debugger{
  private List <Message> messages;
  static Debugger instance = null;
  static int x = 60;
  static int y = 80;
  static int maxLen = 18;
  static Color textColor = new Color(255,0,0);
  
  Debugger(){
    this.messages = new ArrayList<Message>();
  }
  
  public void addMessage(Message message){
    this.messages.add(message);
    if(this.messages.size() > Debugger.maxLen){
      this.messages.remove(0);
    }
  }
  
  public List<Message> getMess(){
    Iterator<Message> itM = this.messages.iterator();
    Message mess = null;
    int i = 0;
    while(itM.hasNext()){
      mess = itM.next();
      mess.x = Debugger.x;
      mess.y = Debugger.y+(i*20);
      i++;
    }
    return(this.messages);
  }
  
  public static void clear() {
    Debugger.getDebugger().empty();
  }
  
  public void empty() {
    this.messages.clear();
  }
  
  
  
  private static Debugger getDebugger(){
    if(instance == null){
      instance = new Debugger();
    }
    return instance;
  }
  
  public static void disp(String message){
    Debugger debug = Debugger.getDebugger();
    Message mess = new Message(message);
    debug.addMessage(mess);
  }
  public static List<Message> getMessages(){
    Debugger debug = Debugger.getDebugger();
    return(debug.getMess());
  }
  
}

static class Message{
  public String message;
  public int x;
  public int y;
  public Message(String message){
    this.message = message;
  }
}
abstract class Jeu{
  
    protected String name;
    protected String logo;
    protected String description;
    protected Afficheur afficheur;
    protected ModeJeu mode;
  
    Jeu(String name, String logo, String description, Afficheur afficheur,ModeJeu mode){
      this.name = name;
      this.logo = logo;
      this.description = description;
      this.afficheur = afficheur;
      this.mode = mode;
    }
    
    public void showInCatalogue(){
      text(this.name,this.afficheur.x(50),this.afficheur.y(100));
      text(this.description,this.afficheur.x(50),this.afficheur.y(150));
    }
    
    public abstract void show();
    
    public abstract void event(String button);
    
    
}
abstract class Mode{
  public String name;
  public Afficheur afficheur;
  
  protected ModeGest owner;
  
  public Mode(String name, Afficheur afficheur, ModeGest owner) {
    this.name = name;
    this.afficheur=afficheur;
    this.owner = owner;
  }
  public abstract void show() ;
  public abstract void event(String button) ;
}

class ModeGest{
  private List<Mode> modes;
  private int index;
  private Afficheur afficheur;
  
  public ModeGest(Afficheur afficheur){
    this.afficheur = afficheur;
    
    this.modes = new ArrayList<Mode>();
    this.index = 0;
    
    this.modes.add(new ModeAccueil("accueil",afficheur, this));
    this.modes.add(new ModeParametre("params",afficheur,this));
    this.modes.add(new ModeJeu("jeux",afficheur,this));
  }
  
  public void show(){
    this.modes.get(index).show();
  }
  
  public void event(String button){
    this.modes.get(index).event(button);
  }
  
  public void setMode(String modeName){
    //find mode
    int mode = -1; //default
    Iterator<Mode> it = this.modes.iterator();
    Mode ite = null;
    int i = 0;
    while(it.hasNext()){
      ite = it.next();
      if(ite.name == modeName){
        mode = i;
      }
      i++;
    }
    //change index
    if(mode == -1){ Debugger.disp("mode "+modeName+" not found"); }
    else{ this.index = mode; }
  }
  
}



class ModeAccueil extends Mode{
  private List<PageAccueil> pages;
  private int index;
  
  public ModeAccueil(String name,Afficheur afficheur, ModeGest owner){
    super(name, afficheur, owner) ;
    pages = new ArrayList<PageAccueil>();
    this.index = 0;
    pages.add(new PageAccueil("Accueil",this.getMessageAccueil(),"\u2191 : Param\u00e8tres\n\u2193 : Jeux","accueil"));
    pages.add(new PageAccueil("Jeux",this.getMessageJeux(),"\u2191 : Accueil\n\u2193 : Param\u00e8tres","jeux"));
    pages.add(new PageAccueil("Parametres",this.getMessageParams(),"\u2191 : Jeux\n\u2193 : Accueil","params"));
  }
  
  public void show(){
    this.afficheur.show();
    //rect(this.afficheur.x(20),this.afficheur.y(20),this.afficheur.lenX()-40,this.afficheur.lenY()-40);
    
    fill(255,255,255);
    text("Menu principal",this.afficheur.x(10),this.afficheur.y(60));
    text("Page: "+this.pages.get(index).name,this.afficheur.x(20),this.afficheur.y(80));
    //text(this.getLogo(),this.afficheur.x(40),this.afficheur.y(100));
    
    text(this.pages.get(index).message,this.afficheur.x(20),this.afficheur.y(120));
    text(this.pages.get(index).footer,this.afficheur.x(180),this.afficheur.maxY()-50);
  }
  
  private String getMessageAccueil(){
    String chaine = "Vous voici dans le menu principal de la GB \n\n";
    chaine += "Vous pouvez naviguez dans les modes avec les touches \u2191 et \u2193\n";
    chaine += "Vous pouvez valider votre choix en appuyant sur A\n";
    chaine += "Vous pouvez a tout moment revenir en arri\u00e8re avec le boutton B\n\n";
    chaine += "Les 2 boutons en bas a droite permettent la customisation";
    return(chaine);
  }
  
  private String getMessageJeux(){
    String chaine = "Voici le mode jeu de la GB \n\n";
    chaine += "Appuyez sur A pour choisir ce mode \n";
    chaine += "Le syst\u00e8me est cens\u00e9 supporter plusieurs jeux \n";
    chaine += "Vous pouvez a tout moment revenir en arri\u00e8re avec le boutton B\n\n";
    return(chaine);
  }
  
  private String getMessageParams(){
    String chaine = "Voici le mode parametres de la GB \n\n";
    chaine += "Appuyez sur A pour choisir ce mode \n";
    chaine += "Vous pourrez y parametrer la console \n";
    chaine += "Vous pouvez a tout moment revenir en arri\u00e8re avec le boutton B\n\n";
    return(chaine);
  }
  
  public void event(String button){
    if(button == "\u2193"){
      if(this.index>=this.pages.size()-1){ this.index = 0; }
      else{this.index+=1;}
      
    }else if(button == "\u2191"){
      if(this.index<=0){ this.index = this.pages.size()-1; }
      else{
        this.index-=1;
      }
    }
    
    else if(button == "A"){
      //Debugger.disp("try to set mode "+this.pages.get(this.index).mode);
      this.owner.setMode(this.pages.get(this.index).mode);
    }
 } 
 
 
 
}

class PageAccueil{
  public String name;
  public String message;
  public String footer;
  public String mode;
  public PageAccueil(String name,String message,String footer,String mode){
    this.name = name;
    this.message =  message;
    this.footer = footer;
    this.mode = mode;
  }
}




class ModeParametre extends Mode{
  
  public ModeParametre(String name,Afficheur afficheur, ModeGest owner){
    super(name, afficheur, owner) ;
  }
  
  public void show(){
    //Debugger.disp("mode param");
    this.afficheur.show();
    //rect(this.afficheur.x(20),this.afficheur.y(20),this.afficheur.lenX()-40,this.afficheur.lenY()-40);
    fill(255,255,255);
    text("Param\u00e8tres",this.afficheur.x(10),this.afficheur.y(60));
    text("Appuyez sur B pour revenir au menu principal",this.afficheur.x(30),this.afficheur.maxY()-50);
    
    
  }
  
  
  public void event(String button){
    if(button == "B"){
      //Debugger.disp("Retour accueil");
      this.owner.setMode("accueil");
    }
  }
  
}
class ModeJeu extends Mode{
  
  private CatalogueJeux catalogue;
  public Jeu jeu;
  
  public ModeJeu(String name,Afficheur afficheur, ModeGest owner){
    super(name, afficheur, owner) ;
    this.catalogue = new CatalogueJeux(this.afficheur,this);
  }
  
  public void show(){
    //Debugger.disp("mode param");
    this.afficheur.show();
    
    fill(255,255,255);
    
    if(jeu == null){
      catalogue.show();
      text("Appuyez sur B pour revenir au menu principal",this.afficheur.x(30),this.afficheur.maxY()-50);
    }
    else{
      try{ jeu.show(); }
      catch(Exception e){ Debugger.disp("jeu.show() : "+e.toString());}
    }
    
    
    
    
  }
  
  public void closeJeu(){
    try{
      this.jeu = null;
    }
    catch(Exception e){ Debugger.disp("close jeu "+e.toString());}
    
  }
  
  public void event(String button){
    if(jeu == null){
      if(button == "A"){
        //Debugger.disp("Try to play : "+this.catalogue.getJeu().name);
        this.jeu = this.catalogue.getJeu();
        //this.owner.setMode("accueil");
      }
      else if(button == "B"){
        //Debugger.disp("Retour accueil");
        this.owner.setMode("accueil");
      }
      else{
        catalogue.event(button);
      }
    }
    else{
      try{
        jeu.event(button);
      } catch(Exception e){ Debugger.disp("jeu.event() : "+e.toString()); }
    }
  }
  
}
class TestJeu extends Jeu{
    
    public TestJeu(String name, String logo, String description, Afficheur afficheur,ModeJeu mode){
      super(name, logo, description, afficheur, mode);
    }
    
    public void show(){
      fill(255,270,170);
      text(this.description+"\nReturn with <select>",this.afficheur.x(50),this.afficheur.y(100));
    }
    public void event(String button){ 
      //Debugger.disp(this.name+"<TestJeu>.event("+button+")");
      if(button == "select"){
        this.mode.closeJeu();
      }
    }
    
}


class SampleGame extends Jeu{
    
    private int x;
    private int y;
    private int size;
    
    
  
    public SampleGame(String name, String logo, String description, Afficheur afficheur,ModeJeu mode){
      super(name, logo, description, afficheur, mode);
      
      this.x = 0;
      this.y = 0;
      this.size = 5;
    }
    
    public void show(){
      fill(255,270,170);
      
      ellipse(this.afficheur.x(this.x),this.afficheur.y(this.y),this.size,this.size);
      
      text("Return with <select>",this.afficheur.x(50),this.afficheur.maxY());
    }
    public void event(String button){ 
      //Debugger.disp(this.name+"<TestJeu>.event("+button+")");
      if(button == "select"){
        this.mode.closeJeu();
      }
      else if(button == "\u2190"){
        if(this.x < 10){ this.x = 0; }
        else { this.x-=10;}
      }
      else if(button == "\u2192"){
        if(this.afficheur.x(this.x)+10>this.afficheur.maxX()){ this.x = this.afficheur.maxX()-50; }
        else{ this.x+=10; }
      }
      
      else if(button == "\u2191"){
        if(this.y < 10){ this.y = 0; }
        else { this.y-=10;}
      }
      else if(button == "\u2193"){
        if(this.afficheur.y(this.y)+10>this.afficheur.maxY()){ this.y = this.afficheur.maxY()-65; }
        else{ this.y+=10; }
      }
      
    }
    
}
class Theme{
  private String bgFile;
  private PImage bgImg;
  
  public Theme(String bgFile){
    this.bgFile = bgFile;
    this.bgImg = loadImage(this.bgFile);
  }
  public void show(){
    image(bgImg,0,0,width,height);
  }
}
  public void settings() {  size(480,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "gb" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
