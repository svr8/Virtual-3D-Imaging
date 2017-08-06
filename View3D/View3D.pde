
PImage img;           //stores images
int c = 0;            //stores index
String ini = "X";     //stores initial file name
float zoom = 1;       //stores zoom value
float angle = 0.0;    //stores angle of rotation
int x = 0, y = 0;     //coordinates of location of image in pixels

void setup()
{
  size(1280, 720);   //window size
  frameRate(30);     //rate at which images on screen
}
void draw()
{
  background(255);    //bacground color in rgb 
  
  img = loadImage(ini+c+".png"); //name of image file to be loaded
  
  //Instructions for rotating image around center:
  translate(width/2, height/2);  
  rotate(angle*TWO_PI/360);
  translate(-img.width/2, -img.height/2);
  
  scale(zoom);      // zoom in and out according to user input
  image(img, x, y); //display the image
}
void keyPressed()
{
  switch(key)
  {
    case 'a': {  
                
                 ini="X";  //X is name of file in set 1
                 c--;      //change the image
                 break;  
              }
    case 'd': {  
                ini="X";  //X is name of file in set 1
                c++;      //change the image
                break;  
              }
    case 'w': {  
                ini = "Y"; //Y is the name of file in set 2
                c++;      //change the image       
                break;  
              }
    case 's': {  
                ini = "Y"; //Y is the name of file in set 2
                c--;       //change the image
                break; 
              }
    
    case 'i': angle++; break; //increase andgle
    case 'k': angle--; break; //decrease angle
    
    case '+': zoom+=0.1; break; //zoom in
    case '-': zoom-=0.1; break; //zoom out
    
    case 'j': x++; break; //move the image right
    case 'g': x--; break; //move the image left
    case 'h': y--; break; //move the image up    
    case 'y': y++; break; //move the image down
  }  
  //prevent the name of file from being out of reach
  if(c<0) c=0;
  else if(c>359) c=359;
}
