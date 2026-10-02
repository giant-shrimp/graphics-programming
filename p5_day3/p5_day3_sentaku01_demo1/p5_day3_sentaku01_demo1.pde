// グローバル変数
int count = 0;
// -----
void setup() {
  size(400, 400, P3D);
  colorMode(HSB, 100);
}
// -----
void draw() {
  background(0);
  frameRate(60);
  drawChequerFloor();
}
// -----
void drawChequerFloor() {
  float s = 20;
  for(int i = 0; i < 20 ; i++){
    for(int j = 0; j < 20 ; j++){
      if( i%2 == j%2 ){
        fill(192);
      }else fill(64);
      float y = height;
      float x = 20*i;
      float z = -20*j;
      stroke(255);
      beginShape();
      vertex(x, y, z);
      vertex(x+s, y, z);
      vertex(x+s, y, z+s);
      vertex(x, y, z+s);
      endShape();
    }
  }
}
// -----
