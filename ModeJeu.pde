class ModeJeu extends Mode{
  
  private CatalogueJeux catalogue;
  public Jeu jeu;
  
  public ModeJeu(String name,Afficheur afficheur, ModeGest owner){
    super(name, afficheur, owner) ;
    this.catalogue = new CatalogueJeux(this.afficheur,this);
  }
  
  public void init(){ /*NTD*/ }
  
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
        this.jeu.init();
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
  
  public void released(){
    if(jeu != null){ this.jeu.released(); }
  }
  
}