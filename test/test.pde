void setup() { //<>// //<>//
  size(1280, 720);
  surface.setLocation(0, 0);
  //photo = loadImage("idle.gif");
  //photo.resize(105,105);
}
int m=0;
void fire() {
  m +=4;
  int [] values={m+100, 100, m+25, 200};
  strokeWeight(2);
  line(values[0], values[1], values[2], values[3]);
  //line(100+m, 100, 25+m, 200);
  //image(photo, m, 0);
  //println(values[0], values[1], values[2], values[3]);
  line(500, 100, 700, 500);
  if ((values[0] >= 500 && values[2] <= 700) && (values[1] >=100 && values[3] <=500)) {
    println("hit!");
    m=0;
  }
  //if(values[0] >= 500 && values[2] <= 700) println("ciao");
}

void getPosition() {
}
//PImage photo;
double angle;
float x = 500+700/2;
float y = 100+500/2;

void draw() {
  background(255);
  //fire(); // to experiment collision detection
  //image(photo, 0, 0);
  //println(photo.width);
  //println(photo.height);


  angle = Math.atan2(mouseY - y, mouseX - x);
  
  float angleF=(float)angle;
  rotate(angleF);
  println(mouseX,mouseY);
  line(500, 100, 700, 500);


  ////translate(width/2, height/2);
  //rotate(1);
  //rect(-104, -104, 208, 208);


  //println(angle);
}
