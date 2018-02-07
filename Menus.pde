
class Menus
{
  String title;
  String credits;
  String retry;
  String choice;
  String directions;
  String start;
  String gameOver;
  String nextLevel;
  float waiting;
  String done;
  
  Menus()
  {
    title= "Asteroids";
    credits= "by: Megan Smith";
    retry= "RETRY?";
    choice= "Y/N";
    directions="     Use the UP, LEFT, and RIGHT arrow keys to move forward and turn your ship. Use SPACEBAR to shoot bullets to destory asteroids and gain points! Be careful-if your ship takes too many hits, it's GAMEOVER!";
    start= "Press 'S' to start the game!";
    gameOver= "GAME OVER";
    nextLevel= "Ready for Level: ";
    done="Well done!";
    waiting=0;
  }
  
  //shows up after player dies, sets appropriate menuMode based on user input
  void Retry()
  {
    stars.Display();
    fill(255);
    textSize(52);
    text(gameOver, (width/2)-135, (height/2)-80);
    textSize(45);
    text(retry, (width/2)-70, (height/2)+30);
    textSize(28);
    text(choice, (width/2)-25, (height/2)+80);
    
    //retart game if y
    if(im.isKeyPressed(89) || im.isKeyPressed(121))
    {
      //change menuMode='g'
      //and reset everything
      player.Reset();
      player.currentScore=0;
      player.health=3;
      player.level=1;
      rockManager.Reset((int)random(3,8));
      stars.Reset();
      StartGame();
      menuMode='g';
    }
    //else return to main menu if n
    else if(im.isKeyPressed(78) || im.isKeyPressed(110))
    {
      //change menuMode='m'
      menuMode='m';
      //MainMenu();
    }
  }
  
  void NextLevel()
  {
    stars.Display();
    fill(255);
    textSize(52);
    text(nextLevel + player.level+ "?", (width/2)-235, (height/2)-60);
    textSize(38);
    text(choice, (width/2)-45, (height/2)+50);
    
    //retart game if y
    if(im.isKeyPressed(89) || im.isKeyPressed(121))
    {
      //change menuMode='g'
      //and reset everything
      player.Reset();
      rockManager.Reset((int)random(3,8));
      stars.Reset();
      menuMode='g';
    }
    //else return to main menu if n
    else if(im.isKeyPressed(78) || im.isKeyPressed(110))
    {
      //change menuMode='m'
      menuMode='m';
    }
  }
  
  //start the game when menuMode= 'g'
  void StartGame()
  {
    //draw background, asteroids, bullets and player to screen
    stars.Display();
    rockManager.DrawObstacles();
    bullets.DrawBullets();
    collisionManager.DetectCollision();
    
    player.Display();
    player.Update();
    player.TakeHit();
    player.Wrap();
    player.Turn();
    player.Shoot();
    
    if(player.health<=0)
    {

      waiting++;
      
      if(waiting>100)
      {
        menuMode='r';
        waiting=0;
      }
    }    
    
    if(rocks.size()==0 && babyRocks.size()==0)
    {
      fill(1);
      stroke(255);
      rect((width/2)-85, (height/2)-110, 190, 55);
      fill(255);
      text(done, (width/2)-40, (height/2)-75);
      waiting++;
      
      if(waiting>100)
      {
        player.level++;
        menuMode= 'n';
        waiting=0;
      }
    }
    
    println("Level: "+ player.level);
    /*println("parent rock size: " + rocks.size());
    println("baby rock size: " + babyRocks.size());
    println("menu mode: " + menuMode);*/
  }
  
  //draw text and asteroids to screen
  void MainMenu()
  {
    stars.Display();
    
    //display asteroids and text
    rockManager.DrawObstacles();
    textSize(52);
    text(title, (width/2)-120, (height/2)-100);
    textSize(20);
    text(credits, (width/2)-90, (height/2)-70);
    textSize(16);
    
    fill(0);
    stroke(255);
    rect((width/2)-240, (height/2), 490, 155);
    
    fill(255);
    strokeWeight(3);   
    text(directions, (width/2)-210, (height/2)+30, 450,150);
    textSize(20);
    text(start, (width/2)-110, (height/2)+200);
    
    //change menuMode= 'g'
    if(im.isKeyPressed(115) || im.isKeyPressed(83))
    {     
      //reset everything
      rockManager.Reset((int)random(3,8));
      stars.Reset();
      player.Reset();
      menuMode='g';
    }
    
    //println("menu mode: " + menuMode);
  }
}