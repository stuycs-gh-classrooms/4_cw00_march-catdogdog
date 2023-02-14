
int DOT_RESOLUTION = 20;
String PICFILE = "us-temps.png";

PImage art;
boolean showDots;
int resolution;

/*================================
  You should leave setup alone, with the exception
  of changing the size if not using the provided boats.jpg
  imgage.
================================*/
void setup() {
  size(770, 550);
  showDots = false;
  resolution = DOT_RESOLUTION;
  art = loadImage(PICFILE);
  art.loadPixels();
}//setup

/*================================
  You should leave draw alone.
================================*/
void draw() {
  background(255);
  image(art, 0, 0);
  if (showDots) {
    dots(art, resolution);
  }
}//draw


/*================================
  keyPressed
  `r`: reset back to the original image.
  `g`: grayScale the image
  `e`: perform edge detection on the image (this will be added tomorrow)
================================*/
void keyPressed() {
  if (key == 'h') {
    art = highlightRed(art);
  }
  else if (key == 'd') {
    showDots = !showDots;
  }//edge detect
  else if (key == 'r') {
    art = loadImage(PICFILE);
    art.loadPixels();
  }//reset image
}//keyPressed


/*================================
  Returns the grayScale value of a color
================================*/
int calculateGray(color c) {
  int g = int((red(c) + green(c) + blue(c)))/3;
  return g;
}//calculateGray
/*================================
  Returns the correct pixel index for img based on the provided x and y values.
================================*/
int getIndexFromXY(int x, int y, PImage img) {
  return y * img.width + x;
}//getIndexFromXY


PImage highlightRed(PImage img) {
  PImage newImg = new PImage(img.width, img.height);
  for (int p=0; p<newImg.pixels.length; p++) {
    color c = img.pixels[p];
    float red_percentage = red(c) / (red(c) + green(c) + blue(c));
    if (red_percentage > .4) {
      newImg.pixels[p] = color((1-red_percentage)*255, 0, 0);
    }
    else {
      newImg.pixels[p] = color(calculateGray(c));
    }
  }
  newImg.updatePixels();
  return newImg;
}//higlightRed



void dots(PImage img, int resolution) {
  for (int i=0; i<img.width; i+=resolution) {
    for (int j=0; j<img.height; j+=resolution) {
      int p_index = j*img.width + i;
      color c = img.pixels[p_index];
      float red_percentage = red(c) / (red(c) + green(c) + blue(c));
      if (red_percentage < .33) {
        fill(color(0, 0, 255));
      }
      else {
        fill(color(255, 0 ,0));
      }
      circle(i, j, resolution/2);
    }
  }
}//dots
