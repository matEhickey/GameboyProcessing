class TestJeu extends Jeu{
    
    public TestJeu(String name, String logo, String description, Afficheur afficheur,ModeJeu mode){
      super(name, logo, description, afficheur, mode);
    }
    
    public void init(){ /*NTD*/ }
    
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
    
    public void released(){}
    
}


class SampleGame extends Jeu{
    
    private List<BoxGame> boxes;
    private int indexBox;
    
    private String memoireButton;
    private List<CanvasButton> buttons;
    
    
    
  
    public SampleGame(String name, String logo, String description, Afficheur afficheur,ModeJeu mode){
      super(name, logo, description, afficheur, mode);
      
      
      this.buttons = new ArrayList<CanvasButton>();
      this.buttons.add(new CanvasButton( "x+",this.afficheur.x(20),this.afficheur.y(20),25,25,true));
      this.buttons.add(new CanvasButton( "x-",this.afficheur.x(60),this.afficheur.y(20),25,25,true));
      
      this.buttons.add(new CanvasButton( "y+",this.afficheur.x(20),this.afficheur.y(60),25,25,true));
      this.buttons.add(new CanvasButton( "y-",this.afficheur.x(60),this.afficheur.y(60),25,25,true));
      
      this.buttons.add(new CanvasButton( "z+",this.afficheur.x(20),this.afficheur.y(100),25,25,true));
      this.buttons.add(new CanvasButton( "z-",this.afficheur.x(60),this.afficheur.y(100),25,25,true));
      
      this.memoireButton = "None";
      
      
      this.boxes = new ArrayList<BoxGame>();
      this.boxes.add(new BoxGame());
      this.indexBox = 0;
    }
    
    public void init(){ /*NTD*/ }
    
    public void show(){
      
      this.checkCustomEvent();
      
      fill(255,270,170);
      
      //ellipse(this.afficheur.x(this.x),this.afficheur.y(this.y),this.size,this.size);
      
      text("Return with <select>",this.afficheur.x(50),this.afficheur.maxY()+15);
      
      Iterator<BoxGame> itbox = this.boxes.iterator();
      BoxGame iteBox = null;
      while(itbox.hasNext()){
        iteBox = itbox.next();
        iteBox.show();
      }
      
      
      //Affichage bouttons
      Iterator<CanvasButton> it = this.buttons.iterator() ;
      CanvasButton ite = null;
      while(it.hasNext()){
        ite = it.next();
        ite.show();
      }

    }
    
    
    
    
    public void event(String button){ 
      //Debugger.disp(this.name+"<TestJeu>.event("+button+")");
      if(button == "select"){
        this.mode.closeJeu();
      }
      else if(button == "←"){
        this.boxes.get(this.indexBox).rotationY -= 0.1;
      }
      else if(button == "→"){
        this.boxes.get(this.indexBox).rotationY += 0.1;
      }
      
      else if(button == "↑"){
        this.boxes.get(this.indexBox).rotationX += 0.1;
      }
      else if(button == "↓"){
        this.boxes.get(this.indexBox).rotationX -= 0.1;
      }
      else if(button == "A"){
        this.boxes.add(new BoxGame());
        this.indexBox++;
      }
      else if(button == "B"){
        this.boxes.add(new BoxGame(this.boxes.get(this.indexBox)));
        this.indexBox++;
      }
    }
    
    public void longEvent(String button){
      this.boxes.get(this.indexBox).longEvent(button);
    }
    
    public void released(){
      //Debugger.disp("released");
      this.memoireButton = "None";
    }
    
    private void checkCustomEvent(){
        if(mousePressed){
          Iterator<CanvasButton> it = this.buttons.iterator() ;
          CanvasButton ite;
          CanvasButton clicked = null;
          while(it.hasNext()){
            ite = it.next();
            if(ite.pressed(mouseX, mouseY)){
              clicked = ite;
            }
          }
          if(clicked != null) {
            if(this.memoireButton == "None"){
              this.event(clicked.name);
              this.memoireButton = clicked.name;
            }
            else{
              this.longEvent(clicked.name);
            }
          }
        }
    }
    
    
    
    class BoxGame{
      
      public int x;
      public int y;
      public int z;
      public float rotationX;
      public float rotationY;
      
      public BoxGame(){
        this.x = 240;
        this.y = 240;
        this.z = 50;
        this.rotationX = 0.0;
        this.rotationY = 0.0;
      }
      public BoxGame(BoxGame oth){
        this.x = oth.x;
        this.y = oth.y;
        this.z = oth.z;
        this.rotationX = oth.rotationX;
        this.rotationY = oth.rotationY;
      }
      
      public void longEvent(String button){
        if(button == "x+"){
          this.x += 1;
        }
        else if(button == "x-"){
          this.x -= 1;
        }
        else if(button == "y+"){
          this.y -= 1;
        }
        else if(button == "y-"){
          this.y += 1;
        }
        else if(button == "z+"){
          this.z -= 1;
        }
        else if(button == "z-"){
          this.z += 1;
        }
      }
      
      public void show(){
        pushMatrix();
        translate(this.x, this.y, this.z); 
        rotateX(this.rotationX);
        rotateY(this.rotationY);
        //noFill();
        box(50);
        popMatrix();
      }
      
      
      
      
    }
    
    
    
}