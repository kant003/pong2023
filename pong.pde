import java.awt.Color;

abstract class Raquet{
  protected float x=0;
  protected float y=height/2;
  protected int w=10;
  protected int h=100;
  private float vy = 0;
  //private Color c=Color.WHITE;
  protected final static int WALL_SEPARATION=50;
  public int points=0;
  
  public Raquet(){}
  public void draw(){
     rect(x,y, w,h);
  }
  public void updatePosition(){
    y += vy;
  }
  public void limitOutScreen(){
  }
  public void moveUp(){
    vy=-10;
  }
  public void moveDown() {
    vy=+10;
  }
  public void stop(){
    vy=0;
  }
}

class RaquetL extends Raquet{
  public RaquetL(){
    x=0+WALL_SEPARATION;
    //y=height/2
  }
}
class RaquetR extends Raquet{
  public RaquetR(){
    x=width - w  - WALL_SEPARATION;
    //y=height/2
  }
}

class Ball{
  private float x = width/2;
  private float y = height/2;
  private int w = 20; // Lado
  private float vx = 3;
  private float vy = 3;
  //private Color c = Color.WHITE;
  public void Ball(){  }
  public void draw() {}
  public void updatePosition() {}
  private boolean hasCollionLeftWall() { return false; }
  private boolean hasCollionRightWall() { return false; }
  private boolean hasCollionTopWall() { return false; }
  private boolean hasCollionDownWall() { return false; }
  public void controlCollisionTopBottomWall() { }
  public boolean controlCollisionLeftWall() {return false;}
  public boolean controlCollisionRightWall() {return false;}
  
  public void controlCollisionLeftRaquet() {}
  public void controlCollisionRightRaquet() {}
}



Ball ball;
RaquetL raquetL;
RaquetR raquetR;

public void setup() {
  size(640,480);
  fill(255,255,255);
  stroke(255,255,255);
  
  raquetL = new RaquetL();
  
}

public void draw(){
  background(0);
  raquetL.draw();
  raquetL.updatePosition();
}

public void keyPressed(){
  if(key == 'w') raquetL.moveUp();
  if(key == 's') raquetL.moveDown();
}
public void keyReleased(){
  if(key == 'w' || key == 's') raquetL.stop();
  
}
public void reset(){
}
