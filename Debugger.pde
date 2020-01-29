import java.util.*;

static class Debugger{
  private List <Message> messages;
  static Debugger instance = null;
  static int x = 60;
  static int y = 80;
  static int maxLen = 18;
  static Color textColor = new Color(255,0,0);
  
  Debugger(){
    this.messages = new ArrayList<Message>();
  }
  
  public void addMessage(Message message){
    this.messages.add(message);
    if(this.messages.size() > Debugger.maxLen){
      this.messages.remove(0);
    }
  }
  
  public List<Message> getMess(){
    Iterator<Message> itM = this.messages.iterator();
    Message mess = null;
    int i = 0;
    while(itM.hasNext()){
      mess = itM.next();
      mess.x = Debugger.x;
      mess.y = Debugger.y+(i*20);
      i++;
    }
    return(this.messages);
  }
  
  public static void clear() {
    Debugger.getDebugger().empty();
  }
  
  public void empty() {
    this.messages.clear();
  }
  
  
  
  private static Debugger getDebugger(){
    if(instance == null){
      instance = new Debugger();
    }
    return instance;
  }
  
  public static void disp(String message){
    Debugger debug = Debugger.getDebugger();
    Message mess = new Message(message);
    debug.addMessage(mess);
  }
  public static List<Message> getMessages(){
    Debugger debug = Debugger.getDebugger();
    return(debug.getMess());
  }
  
}

static class Message{
  public String message;
  public int x;
  public int y;
  public Message(String message){
    this.message = message;
  }
}