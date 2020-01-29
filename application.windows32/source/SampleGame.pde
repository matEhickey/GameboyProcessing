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
      else if(button == "←"){
        if(this.x < 10){ this.x = 0; }
        else { this.x-=10;}
      }
      else if(button == "→"){
        if(this.afficheur.x(this.x)+10>this.afficheur.maxX()){ this.x = this.afficheur.maxX()-50; }
        else{ this.x+=10; }
      }
      
      else if(button == "↑"){
        if(this.y < 10){ this.y = 0; }
        else { this.y-=10;}
      }
      else if(button == "↓"){
        if(this.afficheur.y(this.y)+10>this.afficheur.maxY()){ this.y = this.afficheur.maxY()-65; }
        else{ this.y+=10; }
      }
      
    }
    
}