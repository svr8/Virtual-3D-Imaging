// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

import processing.video.*;

PFont font;
String msg = "Click when Ready!";

Capture cam; //captures images from the camera
int brightness = 150; //default brightness

PImage img;
PImage X[] =  new PImage[360];
PImage Y[] =  new PImage[360];

int arr = 0, c = 0;//arr stores the clicks and c the array, index
boolean start = false;// checks capturing

void setup() {
  size(640, 480);
  
  font = loadFont("Consolas-48.vlw"); //Replace the font with your selected font. Do include the extension .vlw
  textFont(font, 20);
  fill(0, 0, 0); //set font color in RGB format
  
  cam = new Capture(this, 640, 480, 30); //set the camera resolution to 640x480 and frameRate to 30fps
  cam.start();   //activate the camera
}

void draw() {
  if(cam.available()==true && arr<3) //cam.avaialbe() checks if there are any bytes available to read from camera
                                     //also check if the number of clicks do not exceed 2
  {
    cam.read(); //capture the imagees
  }
  img = cam;           // store image from camera in variable
  image(cam, 0, 0);    //display camera image on window  
  Brighten();          //brighten the image for better visibility
  
  if(start)
  {
  if(arr == 1)              //check if user has clicked once
  {
    X[c] = get();           //capture the screen
    println("X"+c+" saved");//display status in console
    c++;                    //update index
    
  }
  if(arr == 2)               //checked if the user has clicked twice
  {
    Y[c] = get();            // capture the screen
    println("Y"+c+" saved"); //display status in console
    c++;                     //update index
  }
  }
  if(arr == 3)           //check if the user has clicked thrice
  {
    saveImages(X, "X"); // save images set X to data folder
    saveImages(Y, "Y"); // save images set Y to data folder
    arr++;              // update click so saving process is not repeated
    msg = "Done!";      // Display status
  }
  if(c>359) { start = false; msg = "Click when ready"; } //check if the number of images captured do not exceed the array size, ie, 360
 text(msg, width/2-80, height-20);                       //display required messages
}
void saveImages(PImage pic[], String ini)
{
  for(int i = 0;i<360; i++)  //loop runs 360 times
    pic[i].save(ini+i+".png"); // PImage_Variable.save("nameOfFile") saves images
}

void mousePressed() //called when mouse buttons are pressed
{
  msg = ""; //clear text on screen so that the text is not saved in the images
  arr++; //update number of clicks
  c = 0; //reset array index
  start = true; //to begin capturing
}
void keyPressed() // called when keyboard buttons are pressed
{
  //brightness variable stores the amount of brightness
  if(key == 'w') brightness++; //Press 'w' to increase brightness
  else if(key == 's') brightness--; //Press 's' to decrease brightness
  if(brightness<0) brightness =0; //avoid unnecessary reduction
}
void Brighten() 
{
   loadPixels();

  // We must also call loadPixels() on the PImage since we are going to read its pixels.  img.loadPixels(); 
  for (int x = 0; x < img.width; x++ ) {
    for (int y = 0; y < img.height; y++ ) {

      // Calculate the 1D pixel location
      int loc = x + y*img.width;

      // Get the R,G,B values from image
      float r = red (img.pixels[loc]);
      float g = green (img.pixels[loc]);
      float b = blue (img.pixels[loc]);

      // We calculate a multiplier ranging from 0.0 to 8.0 based on mouseX position. 
      // That multiplier changes the RGB value of each pixel.      
      float adjustBrightness = ((float) brightness / width) * 8.0; 
      r *= adjustBrightness;
      g *= adjustBrightness;
      b *= adjustBrightness;

      // The RGB values are constrained between 0 and 255 before being set as a new color.      
      r = constrain(r,0,255); 
      g = constrain(g,0,255);
      b = constrain(b,0,255);

      // Make a new color and set pixel in the window
      color c = color(r,g,b);
      pixels[loc] = c;
    }
  }
  updatePixels(); 
}