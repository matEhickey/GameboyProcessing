class Plateformer extends Jeu{
    
    private List<FallingObject> objects;
    public Boolean pressed ;
    
    private Player player;
    public Timer timer;
  
    public Plateformer(String name, String logo, String description, Afficheur afficheur,ModeJeu mode){
      super(name, logo, description, afficheur, mode);
    }
    
    public void init(){ 
      this.objects = new ArrayList<FallingObject>();
      int i = 0;
      for(i = 0; i < 10; i++){
        objects.add(new FallingObject(this.afficheur.x(0)+(int)(Math.random()*this.afficheur.lenX()),(int)(this.afficheur.y(0)-Math.random()*200),this.afficheur));
      }
      
      this.player = new Player(this.afficheur.x(0)+(this.afficheur.lenX()/2),this.afficheur.maxY()-20,10);
      this.pressed = false;
      this.timer = new Timer(this.afficheur.maxX()-50,this.afficheur.maxY()+15);
    }
    
    public void show(){
      //fill(255,170,170);
      //noStroke();
      //rect(this.afficheur.x(0)-1,this.afficheur.y(0)-1,2,2);
      //rect(this.afficheur.maxX()-1,this.afficheur.maxY()-1,2,2);
      
      fill(255,255,170);
      text("Return with <select>",this.afficheur.x(50),this.afficheur.maxY()+15);
      
      Iterator<FallingObject> it = this.objects.iterator();
      FallingObject obj = null;
      while (it.hasNext()){
        obj = it.next();
        obj.show();
        obj.update();
      }
      if(this.pressed){ this.player.deplace(); }
      this.player.show();
      
      this.timer.show();
      
    }
    public void event(String button){ 
      //Debugger.disp(this.name+"<TestJeu>.event("+button+")");
      if(button == "select"){
        this.mode.closeJeu();
      }
      else{
        //Debugger.disp("plateformer1.event("+button+")");
        
        
        if(button == "↑" || button == "↓" || button == "→" || button == "←"){
          this.pressed = true;
          //this.player.deplace(button);
          this.player.directionPressed = button;
        }
        
      }
    }
    
    public void released(){ 
      if(this.pressed){
        //Debugger.disp("plateformer1.released()");
      }
      this.pressed = false;
    }
    
    
    
    
    
    
    
    
    //-----------------------------------------------------
    
    class Player{
      public int x;
      public int y;
      public int size;
      public String directionPressed;
      public int vitesse;
      
      public Player(int x, int y , int size){
        this.x = x;
        this.y = y;
        this.size = size;
        this.vitesse = 2;
      }
      
      public void show(){
        ellipse(this.x-(this.size/2),this.y-(this.size/2),this.size,this.size);
      }
      
      public void deplace(){
        if(directionPressed == "↑"){
          this.y -=vitesse;
          
        }else if(directionPressed == "↓"){
          this.y +=vitesse;
          
        }else if(directionPressed == "→"){
          this.x +=vitesse;
          
        }else if(directionPressed == "←"){
          this.x -=vitesse;
          
        }
      }
      
    }
    
    class Timer{
       private long t0;
       private int x;
       private int y;
       public Timer(int x, int y){
         t0 = System.currentTimeMillis();
         this.x = x;
         this.y = y;
       }
       
       public String getTime(){
         return(String.valueOf((System.currentTimeMillis()-t0)/1000));
       }
       
       public void show(){
         text(this.getTime(), this.x, this.y);
       }
    }
    
    
    
    
    //---------------------------------------------------------
    
    class FallingObject{
      public int x;
      public int y;
      private int y0;
      public int size;
      private float vitesse;
      
      private Afficheur afficheur;
      
      public FallingObject(int x,int y, Afficheur afficheur){
        this.x = x;
        this.y0 = y;
        this.afficheur = afficheur;
        this.vitesse = 2;
        this.raz();
        
      }
      
      public void show(){
        Boolean display = false;
        if((this.x > this.afficheur.x(0))&&(this.x+this.size < this.afficheur.maxX())){
          if((this.y > this.afficheur.y(0))&&(this.y+this.size < this.afficheur.maxY())){
            display = true;
          }
        }
        
        if(display){
          rect(this.x, this.y, this.size, this.size);
        }
      }
      
      public void raz(){
        this.x += (int)((Math.random()-0.5)*100);
        this.y = this.y0;
        this.size = Math.random()>0.5?6:12;
        //this.vitesse = this.vitesse*0.6;
      }
      
      public void update(){
        this.vitesse += 0.01;
        this.y += vitesse;
        if(this.y > this.afficheur.maxY()){
          this.raz();
        }
      }
      
      
    }
}