abstract class Mode{
  public String name;
  public Afficheur afficheur;
  
  protected ModeGest owner;
  
  public Mode(String name, Afficheur afficheur, ModeGest owner) {
    this.name = name;
    this.afficheur=afficheur;
    this.owner = owner;
  }
  abstract void show() ;
  abstract void event(String button) ;
  
  abstract void released();
  
  abstract void init();
}

class ModeGest{
  private List<Mode> modes;
  private int index;
  private Afficheur afficheur;
  
  public ModeGest(Afficheur afficheur){
    this.afficheur = afficheur;
    
    this.modes = new ArrayList<Mode>();
    this.index = 0;
    
    this.modes.add(new ModeAccueil("accueil",this.afficheur, this));
    this.modes.add(new ModeParametre("params",this.afficheur,this));
    this.modes.add(new ModeJeu("jeux",this.afficheur,this));
  }
  
  public void show(){
    this.modes.get(this.index).show();
  }
  
  public void event(String button){
    this.modes.get(this.index).event(button);
  }
  
  public void released(){
    this.modes.get(this.index).released();
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
    else{ 
      this.index = mode;
      this.modes.get(this.index).init();
    }
  }
  
}



class ModeAccueil extends Mode{
  private List<PageAccueil> pages;
  private int index;
  
  public ModeAccueil(String name,Afficheur afficheur, ModeGest owner){
    super(name, afficheur, owner) ;
    pages = new ArrayList<PageAccueil>();
    this.index = 0;
    pages.add(new PageAccueil("Accueil",this.getMessageAccueil(),"↑ : Paramètres\n↓ : Jeux","accueil"));
    pages.add(new PageAccueil("Jeux",this.getMessageJeux(),"↑ : Accueil\n↓ : Paramètres","jeux"));
    pages.add(new PageAccueil("Parametres",this.getMessageParams(),"↑ : Jeux\n↓ : Accueil","params"));
  }
  
  public void init(){ /*NTD*/ }
  
  public void show(){
    this.afficheur.show();
    //rect(this.afficheur.x(20),this.afficheur.y(20),this.afficheur.lenX()-40,this.afficheur.lenY()-40);
    
    fill(255,255,255);
    text("Menu principal",this.afficheur.x(10),this.afficheur.y(60));
    text("Page: "+this.pages.get(index).name,this.afficheur.x(20),this.afficheur.y(110));
    //text(this.getLogo(),this.afficheur.x(40),this.afficheur.y(100));
    
    text(this.pages.get(index).message,this.afficheur.x(20),this.afficheur.y(150));
    text(this.pages.get(index).footer,this.afficheur.x(180),this.afficheur.maxY()-50);
  }
  
  private String getMessageAccueil(){
    String chaine = "";
    chaine += "Vous pouvez naviguez dans les modes avec les touches ↑ et ↓\n";
    chaine += "Vous pouvez valider votre choix en appuyant sur A\n";
    chaine += "Vous pouvez a tout moment revenir en arrière avec le boutton B\n\n";
    chaine += "Les 2 boutons en bas a droite permettent la customisation";
    return(chaine);
  }
  
  private String getMessageJeux(){
    String chaine = "";
    chaine += "Appuyez sur A pour choisir ce mode \n";
    chaine += "Le système est censé supporter plusieurs jeux \n";
    chaine += "Vous pouvez a tout moment revenir en arrière avec le boutton B\n\n";
    return(chaine);
  }
  
  private String getMessageParams(){
    String chaine = "";
    chaine += "Appuyez sur A pour choisir ce mode \n";
    chaine += "Vous pourrez y parametrer la console \n";
    chaine += "Vous pouvez a tout moment revenir en arrière avec le boutton B\n\n";
    return(chaine);
  }
  
  public void event(String button){
    if(button == "↓"){
      if(this.index>=this.pages.size()-1){ this.index = 0; }
      else{this.index+=1;}
      
    }else if(button == "↑"){
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
  
  public void released(){ /*NTD*/ }
  
  
 
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
  
  public void init(){ /*NTD*/ }
  
  public void show(){
    //Debugger.disp("mode param");
    this.afficheur.show();
    //rect(this.afficheur.x(20),this.afficheur.y(20),this.afficheur.lenX()-40,this.afficheur.lenY()-40);
    fill(255,255,255);
    text("Paramètres",this.afficheur.x(10),this.afficheur.y(60));
    text("Appuyez sur B pour revenir au menu principal",this.afficheur.x(30),this.afficheur.maxY()-50);
    
    
  }
  
  
  public void event(String button){
    if(button == "B"){
      //Debugger.disp("Retour accueil");
      this.owner.setMode("accueil");
    }
  }
  
  public void released(){ /*NTD*/ }
  
}