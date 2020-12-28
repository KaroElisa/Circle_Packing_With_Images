//what is a class?
//a template for making objects

class Circle{
 //what does every circle have? two center coordinates and a radius
 float x;
 float y;
 float r;
 float colorShift = 0;
 
 color c;
 
 boolean growing = true;
 
 
 //this is a constructor function
 Circle(float x_, float y_, color c_){
   //you are telling the circle that x gets this particular value and y gets this particular value
   //the underscore allows you to differentiate between x and x_
   x = x_;
   y= y_;
   //controlscircle size
   r = 2;
   c = c_;
}

//this function increases the radius so that it grows with every run through the loop
void grow(){
  if (growing){
  r = r + 1;
  }
}

//true or false: has the circle reached the edges of the screen? If it has, stop it
boolean edges() {
  //if any of these are true, return true
  return(x + r > width || x - r < 0 || y + r > height || y - r < 0);
  }
  

//you need this to see the circle
void show(){
  
  stroke (255);
  noStroke();
  fill(c);
  ellipse(x, y, r*2, r*2);
  
  if ( r > 13){
    r = 13;
  }
}
}
