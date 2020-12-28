//Here, I want a list of objects of <type circle>, and the list is called circles
ArrayList <Circle> circles;

//this class stores an x and a y
//possible spots the the packing algorithm can pick from
ArrayList<PVector> spots;
float centerrange = 1;
int imageNumber = 0;

PImage img;

PImage[] imgs = new PImage[17];

void setup (){
  size(600, 600);
  
  //Image Array
  imgs[0] = loadImage("1.jpg");  // Assign value to first element in the array
  imgs[1] = loadImage("2.jpg"); // Assign value to second element in the array
  imgs[2] = loadImage("3.jpg");  // Assign value to third element in the array
  imgs[3] = loadImage("4.jpg");  // Assign value to first element in the array
  imgs[4] = loadImage("5.jpg"); // Assign value to second element in the array
  imgs[5] = loadImage("6.jpg");  // Assign value to third element in the array
  imgs[6] = loadImage("7.jpg");  // Assign value to third element in the array
  imgs[7] = loadImage("8.jpg");  // Assign value to first element in the array
  imgs[8] = loadImage("9.jpg"); // Assign value to second element in the array
  imgs[9] = loadImage("10.jpg");  // Assign value to third element in the array
  imgs[10] = loadImage("11.jpg");  // Assign value to third element in the array
  imgs[11] = loadImage("12.jpg");  // Assign value to third element in the array
  imgs[12] = loadImage("13.jpg");  // Assign value to first element in the array
  imgs[13] = loadImage("14.jpg"); // Assign value to second element in the array
  imgs[14] = loadImage("15.jpg");  // Assign value to third element in the array
  imgs[15] = loadImage("16.jpg"); // Assign value to second element in the array
  imgs[16] = loadImage("17.jpg");  // Assign value to third element in the array
  
  //DELAY TO TAKE SCREENVIDEO
  //delay(5000);
  
  //name the new array
  //spots = new ArrayList<PVector>();  

  //prints how many elements are in the array
  //println(spots.size());
  circles = new ArrayList<Circle>();      //this bit of code actually states that we want to create a new array
}

void draw (){
  background(0);
  img = imgs[imageNumber];
   
   //SPEED
   int total = 40;
   int count = 0;
   int attempts = 0;
   
   //this limits the amount of circles drawn at once to the total
   while(count < total){
     
  //create function new circle
  //if the new circle is not null, add another circle element to the array
   Circle newC = newCircle();
   if (newC != null){
    circles.add(newC); 
    count++;
   }
   attempts ++;
   
   //this if statement breaks the infinite loop. numbers of attempts are the amount of times circles try to generate themselves
   if (attempts > 400){
      circles.clear();
      
      //IF SCREEN GOES BLACK AND CIRCLES RESET, MOVE TO NEXT IMAGE IN THE ARRAY
      imageNumber++;
      
      if (imageNumber == imgs.length){
        imageNumber = 0;
      }
      break;
     }
   }
   
  
//FOR EVERY CIRCLE, CALL SHOW AND GROW

  for(Circle c : circles) {
     if (c.growing){
        //grow if and only if the boolean returns false 
         if (c. edges()) {
            c.growing = false;
          } else {
            for(Circle other : circles){
              //as long as the object it's checking IS NOT itself
              if ( c!= other){
                float d = dist(c.x, c.y, other.x, other.y);
                //EDGE CONTROL
                if (d-2 < c.r + other.r){
                  c.growing = false;
                  break;
                }
                }
            }
         }
     }
    c.show();
    c.grow();
  }
}


//FUNCTION RETURNS NEW CIRCLES

  Circle newCircle(){
    
    //create a random x y
    float xmin = 0;
    float xmax = 0;
    xmin = max(width/2-centerrange/2,1);
    xmax = min(width/2+centerrange/2,width);
    
    float x = random(xmin,xmax);
    
    float ymin = 0;
    float ymax = 0;
    ymin = max(height/2-(sqrt(sq(centerrange/2)-sq(x-width/2))),1);
    ymax = min(height/2+(sqrt(sq(centerrange/2)-sq(x-width/2))), height);
    
    float y = random(ymin,ymax);
    
    centerrange = centerrange + 0.1;
    
    println(centerrange);
    
    if (centerrange > 2000){
      centerrange = 1;
      background(0);
    }
  
    boolean valid = true;                //for every circle in all the circles, is it a point inside another circle
    for(Circle c : circles){             //what is the distance between x, y, and that circle's x y (remember (x,y) is where we start new circles from)
      float d = dist(x, y, c.x, c.y);    //if the distance you just calculated is less then that circle's radius, it is inside an existing circle, the circle is no longer valid and you shouldn't draw it
      if (d < c.r) {
        valid = false;
        break; //end loop
      }
    }
    if (valid){  //if the random x, y position is not inside another circle, add a new circle
        int index = int(x) + int(y) * img.width;
    
    //if the function finds a new unused x, y, fantastic, if not, it's null and doesn't draw it
      return new Circle (x, y, img.pixels[index]);
      } else {
        return null;
      }
  }
