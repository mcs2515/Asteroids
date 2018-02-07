
class Asteroids
{
  PVector position;
  float radius;
  color randomColor;
  PShape rock;
  PVector direction;
  float speed;
  PVector velocity;
  float rotate;
  int random;
    
  //constructor
  Asteroids(float size)
  {        
    position = new PVector( (int)random(50, 600), (int)random(50, 600) );
    direction= new PVector(random(-1, 1), random(-1, 1));  
    velocity=new PVector(0,0);
    rotate= random(-2,2);
    speed= random(0, 3);
    radius = size;

    stroke(255);
    strokeWeight(3);
    fill(0);
    rock= createShape();
    
    //create asteroid shapes
    rock.beginShape();    
      rock.vertex(random(radius-10, radius+10), random(-10, 10));     
      rock.vertex(random(radius-25, radius), random(radius, radius+25));

      rock.vertex(random(-10, 10), random(radius-10, radius+10)); 
      rock.vertex(random(-radius, -radius+25), random(radius, radius-25));
     
      rock.vertex(random(-radius-10, -radius+10), random(-10,10));
      rock.vertex(random(-radius, -radius+25), random(-radius-25, -radius));

      rock.vertex(random(-10, 10), random(-radius-10, -radius+10));
      rock.vertex(random(radius-25, radius), random(-radius+25, -radius));
    rock.endShape(CLOSE);
  }
  
  //creates more asteroids in place of the destroyed parent
  void MakeBabies()
  { 
    for(int i=0; i<2; i++)
    {
    //make the new baby rock
    babyRocks.add(new Asteroids(random(21,30)));
    babyRocks.get(babyRocks.size() - 1).position = position.copy();
    babyRocks.get(babyRocks.size() - 1).position.add(random(-25,25),random(-25,25));
    //babyRocks.get(babyRocks.size() - 1).radius= random(5,10);
    babyRocks.get(babyRocks.size() - 1).velocity= velocity.copy();
    babyRocks.get(babyRocks.size() - 1).velocity.add(random(-2,2),random(-2,2));
    babyRocks.get(babyRocks.size() - 1).direction= direction.copy();
    }
  }
  
  //moves all asteroids on screen
  void Update()
  {
      velocity= PVector.mult(direction, speed);
      position.add(velocity);
  }
  
  //keeps asteroids on screen
  void Wrap()
  {
    if(position.x > width+50){
      position.x = 0;
    }
    else if(position.x < -50){
      position.x = width;
    }
    else if(position.y > height+50){
      position.y = 0;
    }
    else if(position.y < -50){
      position.y = height;
    }
  }
  
  //display the asteroids
  void Display()
  {    
      pushMatrix();
        rock.rotate(radians(rotate));
      popMatrix();
     
      //drawing collision circle
      //ellipse(position.x, position.y, radius*2, radius*2);
  
      shape(rock, position.x, position.y);
      //line(position.x, position.y, position.x + (direction.x*50),  position.y + (direction.y*50));
  }
}