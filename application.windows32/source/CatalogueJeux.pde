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
      this.addJeu(new SampleGame("Sample Game", "logo.jpg","Il s'agit d'un exemple d'un composant dirigé par les flèches", this.afficheur, this.mode));
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
      
      text("↑",x+40,y+142);
      text("↓",x+40,y+158);
    }
    
    public void event(String button){
      //Debugger.disp(button);  
          if(button == "↓"){
            if(this.indexSelec>=this.jeux.size()-1){ this.indexSelec = 0; }
            else{this.indexSelec+=1;}
            
          }else if(button == "↑"){
            if(this.indexSelec<=0){ this.indexSelec = this.jeux.size()-1; }
            else{
              this.indexSelec-=1;
            }
          }
    }
    
}