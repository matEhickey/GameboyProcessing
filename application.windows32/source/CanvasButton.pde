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
  void show() {
    if(this.display){
      fill(Color.btnColor.r,Color.btnColor.g,Color.btnColor.b);
      rect(this.x,this.y,this.sX,this.sY) ;
      if(this.name.length()<3){
      fill(Color.txtBtnColor.r,Color.txtBtnColor.g,Color.txtBtnColor.b);
        text(this.name,(this.x+this.x+this.sX)/2 -5,(this.y+this.y+this.sY)/2 +5) ;
      }
    }
  }
  Boolean pressed(int x,int y) {
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