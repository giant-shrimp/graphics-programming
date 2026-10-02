// グローバル変数
int count = 0;
// -----
void setup() {
  frameRate(60);
  size(400, 400, P3D);
  colorMode(HSB, 100);
  smooth();
  noStroke();
}
// -----
void draw() {
  background(0);
  camera(0, 0, width, 0, 0, 0, 0, 1, 0);
  lights();
  drawObj();
  count ++;
}
// -----
void drawObj() {
  for(int i = 0; i < 10 ; i++){
    for(int j = 0; j < 10 ; j++){
      float y = 25 * (j-5);
      float x = 100 * sin( 2 * PI * i/10 + count*2*PI/360 );
      float z = 100 * cos( 2 * PI * i/10 + count*2*PI/360 );
      pushMatrix();
      translate(x, y, z);
      fill(i*10, j*10, 100, 50);
      box(20);
      popMatrix();
    }
  }
}
// -----
