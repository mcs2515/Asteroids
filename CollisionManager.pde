
class CollisionManager
{
  float xComp;
  float yComp;
  float xBaby;
  float yBaby;
  float xBullet;
  float yBullet;
  float distanceBullet;
  float distance;
  float distanceBaby;
  int remove;
  int removeBaby;
  
  CollisionManager()
  {
    xComp=0;
    yComp=0;
    distance=0;
    xBaby=0;
    yBaby=0;
    distanceBaby=0;
    remove=-1;
    removeBaby=-1;
  }
  
  //checks the ships and bullets collision agaisnt all objects in both rocks lists and babyRocks
  void DetectCollision()
  {
//--asteroids in rocks list------------------------------------------------------------------------------------------------------------------------------------------
    //detect collision for the parent rocks;
    for(int j=0; j< rocks.size(); j++)
    {
      xComp= sq(player.position.x- rocks.get(j).position.x);
      yComp= sq(player.position.y- rocks.get(j).position.y);
      
      distance= sqrt(xComp+ yComp);
      
      //check the radii of both the player and asteroids against the distance between them
      if((player.radius + rocks.get(j).radius) > distance)
      { 
        player.colliding=true;
      }      
               
      //check the radii of both the bullets and asteroids against the distance between them
      for(int i=0; i< ammo.size(); i++)
      {        
        xBullet= sq(ammo.get(i).position.x- rocks.get(j).position.x);
        yBullet= sq(ammo.get(i).position.y- rocks.get(j).position.y);
            
        distanceBullet= sqrt(xBullet+ yBullet);
        
        if((ammo.get(i).radius + rocks.get(j).radius) > distanceBullet)
        {
          if(ammo.get(i).active==true)
          {   
            remove=j;
            player.currentScore+=(50*random(1.2,1.5));
            rocks.get(j).MakeBabies();
            ammo.get(i).active=false;
            //rocks.add(new Asteroids());
          }
        }
      }
    }   
    //remove the parent rock from list
    if(remove!=-1)
    {
      rocks.remove(remove); 
      remove=-1;
    }

//--asteroids in babyRocks list--------------------------------------------------------------------------------------------------------------------------------------
    //detect collision for the baby rocks;
    for(int k=0; k<babyRocks.size(); k++)
    {

      xBaby= sq(player.position.x- babyRocks.get(k).position.x);
      yBaby= sq(player.position.y- babyRocks.get(k).position.y);
      
      distanceBaby= sqrt(xBaby+ yBaby);
      
      //check the radii of both the player and asteroids against the distance between them
      if((player.radius + babyRocks.get(k).radius) > distanceBaby)
      { 
        player.colliding=true;
      }  
          
      //check the radii of both the bullets and baby asteroids against the distance between them
      for(int i=0; i< ammo.size(); i++)
      {        
        xBullet= sq(ammo.get(i).position.x- babyRocks.get(k).position.x);
        yBullet= sq(ammo.get(i).position.y- babyRocks.get(k).position.y);
            
        distanceBullet= sqrt(xBullet+ yBullet);
        
        if((ammo.get(i).radius + babyRocks.get(k).radius) > distanceBullet)
        {        
          if(ammo.get(i).active==true)
          { 
            removeBaby=k;
            ammo.get(i).active=false;
            player.currentScore+=(50*random(1.5,1.9));
          }
        }
      }
    }    
    //remove the baby rock from list
    if(removeBaby!=-1)
    {
      babyRocks.remove(removeBaby); 
      removeBaby=-1;
    }    
  }    
}