class Theme{
  private String bgFile;
  private PImage bgImg;
  
  public Theme(String bgFile){
    this.bgFile = bgFile;
    this.bgImg = loadImage(this.bgFile);
  }
  public void show(){
    image(bgImg,0,0,width,height);
  }
}