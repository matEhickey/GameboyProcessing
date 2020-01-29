static class Color{
  static Color GRAY = new Color(198,198,198);
  static Color DARKGRAY = new Color(130,130,130);
  static Color BLUE = new Color(0,0,255);
  static Color WHITE = new Color(255,255,255);
  
  static Color btnColor = Color.DARKGRAY;
  static Color txtBtnColor = Color.WHITE;
  
  static Color txtColor = Color.WHITE;
  
  
  static Color affTheme1 = new Color(81,100,21);
  
  static Color bgColor = Color.GRAY;
  static Color affColor = Color.affTheme1;
  
  
  public int r;
  public int g;
  public int b;
  public Color(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
}