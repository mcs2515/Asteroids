class Bullets
{
  PVector position;
  float radius;
  boolean colliding;
  boolean active;
  PVector velocity;
  
  //constructor
  Bullets()
  {
    // Instantiate vectors and fields
    position = new PVector( player.position.x, player.position.y );
    radius = 5;
    colliding = false;
    velocity= new PVector(0,0);
    active=false;
  }  
    
  //move the bullets on screen if active, else keep updating its position and direction
  void Update()
  { 
    if(position.x > width || position.x < 0 || position.y > height || position.y < 0)
    {
      active=false;     
    }
     
     //move bullets when active
    if(active)
    {
     position.add(velocity);
    }
    //else keep updating bullets position and direction
    else
    {
     velocity= player.direction.copy().mult(5);
     position = player.position.copy();
    }
  } 

  //Displays the bullets if they are active
  void Display()
  {
    if(active)
    {
      ellipse(position.x, position.y, radius*2, radius*2);
    }    
    //println("bullet active: " + active);
    //println("bullet x: " + position.x+ " bullet y: " + position.y);
  } 
}