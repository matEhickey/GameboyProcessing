
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