void setup() {
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
  line(values[0],values[1],values[2],values[3]);
  //line(100+m, 100, 25+m, 200); //<>//
  //image(photo, m, 0);
  //println(values[0], values[1], values[2], values[3]);
  line(500, 100, 700, 500);
  if ((values[0] >= 500 && values[2] <= 700) && (values[1] >=100 && values[3] <=500)) { //<>//
    println("hit!");
    m=0;
  }
  //if(values[0] >= 500 && values[2] <= 700) println("ciao");
}

void getPosition() {
}
//PImage photo;

void draw() {
  background(255);
  fire();
  //image(photo, 0, 0);
  //println(photo.width);
  //println(photo.height);
}
