
ArrayList<Bullets> ammo;

class BulletManager
{  
  //constructor
  BulletManager()
  {
    ammo= new ArrayList<Bullets>();
    
    //create 5 ammo 
    for(int i=0; i<5; i++)
    {
      ammo.add(new Bullets());
    }
  }
  
  // Handles displaying of all ammo in the array
  void DrawBullets()
  {
    for(Bullets o : ammo)
    {
      o.Update();
      o.Display();
    }
  }
}