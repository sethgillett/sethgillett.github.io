// NEXT CHECK COLLISIONS

float walkSpeed = 5; // walkSpeed = 5 units/s
float cameraY;
//float cameraZ;
PVector cPos;

int unitSize;

boolean w, a, s, d;

String map;

Tile [] mapTiles;

class Tile {
  PVector pos;
  color c;
  Tile(int x, int z) {
    this.pos = new PVector(x*unitSize, 0, z*unitSize);
    this.c = lerpColor(color(255,0,0),color(0,0,255),x/13f);
    this.c = lerpColor(this.c, color(0,255,0), z/13f);
  }
  public void display() {
    fill(c);
    pushMatrix();
    translate(pos.x,0,pos.z);
    box(unitSize);
    popMatrix();
  }
}

void setup() {
  size(1000, 700, P3D);
  
  map = "0000000000000011101011111001010100000100101011111110010000000001001111111010100100010101010011101010101001000101010100101110111010010100000001001011111111100000000000000";
  
  PVector start = new PVector(5, 0, -1);
  PVector end = new PVector(9, 0, 5);

  unitSize = 150;
  
  int gridS = 13;
  
  mapTiles = new Tile [169];
  
  int c=0;
  for (char t : map.toCharArray()) {
    if (t == '0') {
      mapTiles[c] = new Tile(c%gridS,(int) c/gridS);
      //print(1);
    } else {
      mapTiles[c] = null;
      //print(0);
    }
    if (c%13 == 0) {
      //println();
    }
    c++;
  }

  colorMode(RGB);
  cPos = new PVector(start.x*unitSize, 0, start.z*unitSize);

  cameraY = PI/2;
}

void drawMap() {
  for (Tile t : mapTiles) {
    if (t != null) t.display();
  }
}



void draw() {
  background(0,0,20);
  stroke(255);
  lights();
  
  beginCamera();
  //camera(100,1200,100,650,0,650,0,-1,0);
  camera(0, 0, 0, 1, 0, 0, 0, 1, 0);
  translate(cPos.x, 0, cPos.z);
  rotateY(cameraY);
  endCamera();
  
  drawMap();
  
  beginShape();
  fill(100,0,0);
  vertex(0,75,0);
  fill(0,100,0);
  vertex(0,75,13*unitSize);
  fill(0,100,0);
  vertex(13*unitSize,75,13*unitSize);
  fill(0,0,100);
  vertex(13*unitSize,75,0);
  endShape();

  if (keyPressed) {
    PVector dir;
    if (a) cameraY += PI/60;
    if (d) cameraY -= PI/60;
    dir = PVector.fromAngle(cameraY+PI/2);
    dir.mult(walkSpeed);
    dir.x = -dir.x;
    dir.z = dir.y;
    dir.y = 0;
    if (w) cPos.sub(dir);
    if (s) cPos.add(dir);
  }
}

void keyPressed() {
  if (key=='w') w = true;
  else if (key=='s') s = true;
  else if (key=='a') a = true;
  else if (key=='d') d = true;
}

void keyReleased() {
  if (key=='w') w = false;
  else if (key=='s') s = false;
  else if (key=='a') a = false;
  else if (key=='d') d = false;
}