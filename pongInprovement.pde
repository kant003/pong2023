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
    if(y<0) y=0;
    if(y+h> height)  y = height - h;
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
  private float x;
  private float y;
  private int w = 20; // Lado
  private float vx;
  private float vy;
  //private Color c = Color.WHITE;
  public Ball(){  
    reset();
  }
  public void draw() {
    square(x,y, w);
  }
  
  public void reset()
  {
    x=width/2;
    y=height/2;
    
    vx=3;
    vy=3;
    
    
    float M=0;
    float N=360;
    float anguloGrados = (float)(Math.random()*(N-M+1)+M);
    double anguloRadianes = (anguloGrados * Math.PI)/180;
    vx = (float)Math.cos(anguloRadianes) * 5;
    vy = (float)Math.sin(anguloRadianes) * 5;
  }
  
  
  public void updatePosition() {

    x += vx;
    y += vy;
  }
  private boolean hasCollionLeftWall() { 
    return x<0;
  }
  private boolean hasCollionRightWall() { 
    return x+w > width;
  }
  private boolean hasCollionTopWall() { 
    return y<0;
  }
  private boolean hasCollionDownWall() { 
    return y+w > height; 
  }
  public void controlCollisionTopBottomWall() { 
    if(hasCollionTopWall() || hasCollionDownWall()){
      vy *= -1;
    }
  }
  public boolean controlCollisionLeftWall() {
    if(hasCollionLeftWall()){
      vx *= -1; // TODO se puede eliminar en un futuro
      return true;
    }
    return false;
  }
  public boolean controlCollisionRightWall() {
    if(hasCollionRightWall()){
      vx *= -1; // TODO se puede eliminar en un futuro
      return true;
    }
    return false;
  }
  
  public void controlCollisionLeftRaquet(Raquet r) {
    if(x <= r.x+r.w && x+w >r.x ){
      if(y+w > r.y  &&  y < r.y+r.h ){
        vx *= -1;
        x=r.x+r.w;
        // incremento dificulta
        vx = vx * 1.1;
        vy = vy * 1.1; 
      }
    }
    
  }
  public void controlCollisionRightRaquet(Raquet r) {
    if(x+w >= r.x && x < r.x+r.w){
      if(y+w > r.y  &&  y < r.y+r.h ){
        vx *= -1;
        x=r.x-w;
         // incremento dificulta
        vx = vx * 1.1;
        vy = vy * 1.1; 
      }
    }
  }
}

private float previousMilli=millis();


ArrayList<Ball> balls;


RaquetL raquetL;
RaquetR raquetR;

public void setup() {
  size(640,480);
  fill(255,255,255);
  stroke(255,255,255);
  textSize(30);
  raquetL = new RaquetL();
  raquetR = new RaquetR();
  balls = new ArrayList<Ball>();
  
}

public void draw(){
  background(0);
  raquetL.draw();
  raquetR.draw();
  for(Ball ball : balls)  ball.draw();
  
  rect(width/2,0, 3,height);
  text(raquetL.points, 40,40);
  text(raquetR.points, width-80,40);
  
  
  raquetL.updatePosition();
  raquetR.updatePosition();
  for(Ball ball : balls)  ball.updatePosition();
  
  raquetL.limitOutScreen();
  raquetR.limitOutScreen();
  
  for(Ball ball : balls)  ball.controlCollisionTopBottomWall();
  
  for(Ball ball : balls)  {
    if(ball.controlCollisionLeftWall()){
      raquetR.points++;
      //reset();
      balls.remove(ball);
      break;
    }
    if(ball.controlCollisionRightWall()){
      raquetL.points++;
      //reset();
      balls.remove(ball);
      break;
    }
 
  
    ball.controlCollisionLeftRaquet(raquetL);
    ball.controlCollisionRightRaquet(raquetR);
  
  }
}

public void keyPressed(){
  if(key == 'w') raquetL.moveUp();
  if(key == 's') raquetL.moveDown();
  
  if(keyCode == UP) raquetR.moveUp();
  if(keyCode == DOWN) raquetR.moveDown();
  
  if(key == 'n') balls.add(new Ball());
  
  System.out.println(keyCode);
}
public void keyReleased(){
  if(key == 'w' || key == 's') raquetL.stop();
  if(keyCode == UP || keyCode == DOWN) raquetR.stop();
  
}
public void reset(){
  
  for(Ball ball : balls)  ball.reset();
  
}
