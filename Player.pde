  
class Player
{
  //variables
  PShape ship;
  float radius;
  PVector direction;
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector deceleration;

  float maxSpeed;
  float accelRate;
  float bulletTimer;
  
  boolean colliding;
  int respawnTimer;
  
  int health;
  PShape hearts;
  float heartX;
  String lives;
  String restore;
  String died;
  
  int level;
  float currentScore;
  float highScore;
  String cScore;
  String hScore;
  
  //initialize variables
  Player()
  {
    stroke(255);
    strokeWeight(3);
    fill(0);
    ship= createShape(TRIANGLE, 18, 0, -12, 12, -12, -12);
    health=3;
    colliding= false;
    respawnTimer=0; 
    
    direction= new PVector(1,0);
    position= new PVector(width/2, height/2);
    acceleration= new PVector(0,0);
    deceleration= new PVector(0,0);
    velocity= new PVector(0,0);
    radius=6;
    accelRate=.05;
    maxSpeed=5;    
    bulletTimer=5;
       
    died="You died.";
    restore= "Restoring Ship!";
    cScore= "Current Score:";
    hScore= "High Score:";
    highScore=0;
    currentScore=0;
    level=1;
    
    //create hearts
    fill(255,0,0);
    stroke(0);
    strokeWeight(5);
    hearts= createShape();
    heartX=70;
    lives= "Lives:";
    
    //create the ship
    hearts.beginShape();    
      hearts.vertex(0,0);     
      hearts.vertex(20,-20);
      hearts.vertex(40,-20);
      hearts.vertex(50,0);
      hearts.vertex(50,20);
      hearts.vertex(0,60);
      hearts.vertex(-50,20);
      hearts.vertex(-50,0);
      hearts.vertex(-40,-20); 
      hearts.vertex(-20,-20);    
    hearts.endShape(CLOSE);
  }
  
  //keep player on screen
  void Wrap()
  {
    if(position.x > width){
      position.x = 0;
    }
    else if(position.x < 0){
      position.x = width;
    }
    else if(position.y > height){
      position.y = 0;
    }
    else if(position.y < 0){
      position.y = height;
    }
  }
  
  //rotate player depending on keypress
  void Turn()
  {
    //counterclockwise if using left arrow
    if(im.isKeyPressed(37))
    {
      direction.rotate(radians(-4));
    }
    //clockwise if using right arrow
    else if(im.isKeyPressed(39)){
      direction.rotate(radians(4));
    }
  }
  
  //resets player stuff
  void Reset()
  {
    if(currentScore> highScore)
    {
      highScore= currentScore;
    }    
    
    //currentScore=0;
    direction= new PVector(1,0);
    position= new PVector(width/2, height/2);
    acceleration= new PVector(0,0);
    deceleration= new PVector(0,0);
    velocity= new PVector(0,0);
    bulletTimer=5;    
    colliding= false;
    respawnTimer=0;
    
  }
  
  //turn the bullets on when player uses spacebar
  void Shoot()
  {    
    if(key==' ' && keyPressed)
    {
      bulletTimer++;
      
      for(Bullets o: ammo)
      {
        if(bulletTimer>5)   
        {
          if(!o.active )
          {
            o.active=true;
            bulletTimer=0;
            break;
          }
        }
      }   
    } 
    //println("bulletTimer: " + timer);
  }
  
  //reduce hp, reset position and velocity
  void TakeHit()
  {
    if(colliding)
    {
      respawnTimer++;
      
      //println("Respawn timer: " + respawnTimer);
      //println("player HP: " + health);
      
      //display texts
      if(health>0)
      {
        fill(1);
        stroke(255);
        rect((width/2)-80, (height/2)-110, 190, 55);
        fill(255);
        text(restore, (width/2)-58, (height/2)-75);
      }
     //display text
      else
      {
        fill(1);
        stroke(255);
        rect((width/2)-80, (height/2)-110, 190, 55);
        fill(255);
        text(died, (width/2)-30, (height/2)-75);
      }
      //reduce hp
      if(respawnTimer>1 && respawnTimer<=2)
      {
        health--; 
      }
  
      //wait a bit before respawning
      if(respawnTimer>90)
      { 
        position.x= width/2;
        position.y= height/2;
        velocity.x= 0;
        velocity.y= 0;
        colliding=false;
        respawnTimer=0;
      }
    }
  }
  
  //Move the ship's position using acceleration, deceleration, velocity, position
  void Update()
  {
    //if ship is colliding with an asteroid
    if(!colliding)
    {
      //move ship forward with up arrow
      if(im.isKeyPressed(38))
      {
        acceleration= PVector.mult(direction, accelRate);    
      }
      
      //else decelerate
      deceleration= velocity.copy();
      deceleration.mult(-1);
      deceleration.normalize();
      deceleration.mult(.02);
        
      acceleration= PVector.add(deceleration, acceleration);
      
      velocity.add(acceleration);
      velocity.limit(maxSpeed);
      position.add(velocity);
      
      //reset acceleration
      acceleration.mult(0);
    }
  }
  
  //draws the ship to screen and calls the move() method
  void Display()
  {      
    if(!colliding)
    {
      // Draw ship in the proper heading angle
      pushMatrix();
        translate(position.x, position.y);
        rotate(direction.heading());
        shape(ship); 
        stroke(0);
      popMatrix();
    }

    //display health //<>//
    textSize(20);
    fill(255);
    text(lives, 20, 45);
    
    for(int i=0; i<health; i++)
    {     
      pushMatrix();
        scale(.45);
        translate(heartX*i+100, 180);
        shape(hearts);
      popMatrix();
    }
    
    //display score
    text(cScore, (width/2)-150, 45);
    text(int(currentScore), width/2, 45);
    
    text(hScore, width-230, 45);
    text(int(highScore), width-120, 45);
    
    text("Level: "+ level, (width/2)-30, height-20);
    println("Level: "+ level);
    //line(position.x, position.y, position.x + (direction.x*50),  position.y + (direction.y*50));
  }  //<>//
}