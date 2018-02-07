
ArrayList <Asteroids> rocks;
ArrayList <Asteroids> babyRocks;

class AsteroidManager
{   
  //constructor
  AsteroidManager(int size)
  {   
    rocks= new ArrayList <Asteroids>();
    babyRocks= new ArrayList<Asteroids>();
    
    //make asteroid objects
    for(int i=0; i<size; i++)
    {
      rocks.add (new Asteroids(random(40,80))); 
    }    
    
    //println("List Size: " + rocks.size());
  }
  
  //makes a new list of asteroids
  void Reset(int size)
  {    
    rocks= new ArrayList<Asteroids>();
    babyRocks= new ArrayList<Asteroids>(); 
    
    for(int i=0; i<size; i++)
    {
      rocks.add (new Asteroids(random(40,80))); 
    }       
    //println("List Size: " + rocks.size());
  }
  
  //display all asteroids in array
  void DrawObstacles()
  {        
    //display parents
    for(Asteroids o : rocks)
    {
      o.Display();
      o.Wrap(); 
      o.Update();
    }
    
    if(babyRocks.size()>0)
    {
      //display babies
      for(Asteroids o: babyRocks)
      {
        o.Display();
        o.Wrap(); 
        o.Update();
      }
    }
  }
}