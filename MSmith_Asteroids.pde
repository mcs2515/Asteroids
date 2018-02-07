
Player player;
AsteroidManager rockManager;
CollisionManager collisionManager;
BulletManager bullets;
InputManager im;
Menus menu;
StarsBackground stars;
char menuMode;

void setup()
{
  size(1000,800);
  player= new Player();
  rockManager= new AsteroidManager((int)random(3,8));
  collisionManager= new CollisionManager();
  bullets= new BulletManager();
  im= new InputManager();
  menu= new Menus();
  stars= new StarsBackground();
  //change to skip menus
  menuMode= 'm';
}

void draw()
{
  background(1);
    
  if(menuMode=='m')
  {
    menu.MainMenu();
  }
  
  if(menuMode=='g')
  {
    menu.StartGame();  
  }
   
  if(menuMode=='r')
  {
    menu.Retry();
  }
  
  if(menuMode=='n')
  {
    menu.NextLevel();
  }    
  //println("Menu Mode: "+ menuMode);
}

void keyPressed() {
    im.recordKeyPress(keyCode);
}

void keyReleased() {
    im.recordKeyRelease(keyCode);
}