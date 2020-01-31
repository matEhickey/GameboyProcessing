class Theme{
  private String bgFile;
  private PImage bgImg;
  private ScreenCoords sc;
  
  public Theme(String bgFile, ScreenCoords sc){
    this.bgFile = bgFile;
    this.bgImg = loadImage(this.bgFile);
    this.sc = sc;
  }
  public void show(){
    image(bgImg, sc.left, sc.top, sc.w, sc.h);
  }
}