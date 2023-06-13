void setup() {
  size(1200, 600);
  strokeWeight(5);
  noFill();
}
PVector pos = new PVector(450, 300);
float a = 0, fov = QUARTER_PI, d = .01, i, j;



void draw() {
  //maze
  background(0);
  rect(0, 0, 600, 600);
  rect(100, 100, 400, 300);
  line(200, 100, 200, 350);
  rect(300, 200, 100, 100);
  rect(250, 550, 150, 50);
  line(250, 550, 250, 500);
  
  stroke(0, 0, 0);
  line(500, 200, 500, 300);
  stroke(255, 255, 255, 40);
  
  
  //field of view calculator
  for(float k=-.5; k<.5; k+=d) {
    i = k * fov + a;
    j = 0;
    while(get(int(cos(i) * j + pos.x), int(sin(i) * j + pos.y)) != color(255) && outofBound(int(cos(i) * j + pos.x), int(sin(i) * j + pos.y))) {
      j += 3;
    }
    //wall placement
    rect(k * 600 + 900, 300 - atan(100/j) * 200, d, atan(100/j) * 400);
    
    //line field of view
    stroke(255, 255, 255, 40);
    line(cos(i) * j + pos.x, sin(i) * j + pos.y, pos.x, pos.y);
    stroke(255, 255, 255, 255);
  }
  
  point(pos.x, pos.y);
  
  //player movement
  if(keyPressed) {
    switch(key) {
      case 'z' :
        pos.y = pos.y + sin(a) * 2;
        pos.x = pos.x + cos(a) * 2;
        break;
      case 's' :
        pos.y = pos.y - sin(a) * 2;
        pos.x = pos.x - cos(a) * 2;
        break;
      case 'q' :
        a -= abs(fov / (15 + fov));
        break;
      case 'd' :
        a += abs(fov / (15 + fov));
        break;
      case 'a' :
        fov -= .1;
        break;
      case 'e' :
        fov += .1;
        break;
    }
  }
}

//put a wall if the view leaves the map
boolean outofBound(float x,float y) {
  if(x > width || x < 0 || y > height || y < 0) {
    return false;
  }
  return true;
}
