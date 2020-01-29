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
    
    abstract void show();
    
    abstract void event(String button);
    
    
}