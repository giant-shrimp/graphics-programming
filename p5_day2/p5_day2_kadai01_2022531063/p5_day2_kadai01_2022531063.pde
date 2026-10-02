// グローバル変数
int useRing = 0;// 着目するリングの番号
int NumOfRing = 100;// リングの数
float[] ringX = new float[NumOfRing];// リングの x座標 [px]
float[] ringY = new float[NumOfRing];// リングの y座標 [px]
float[] ringSize = new float[NumOfRing];// リングの大きさ [px]
float[] ringColor_r = new float[NumOfRing];// リングの赤要素 (0〜255)
float[] ringColor_g = new float[NumOfRing];// リングの緑要素 (0〜255)
float[] ringColor_b = new float[NumOfRing];// リングの青要素 (0〜255)

// -----
void setup() {
  size(400, 400);//
  ellipseMode(CENTER);// 円の描画モード
  noFill();// 図形を塗らない
  strokeWeight(2);// 線の太さ
}
// -----
void draw() {
  background(0);
  if (useRing == NumOfRing) {
    useRing = 0; //初期化、エラーが出ないようにする。
  }
  drawRings();// リングを描画するための関数
}
// -----
void drawRings() {// リングを描画するための関数
  for (int i = 0; i<useRing; i++ ) {
    if ( ringSize[i] < width*1.5 ) { // ringSizeが大きくなりすぎたら消えるようにする
      stroke(ringColor_r[i], ringColor_g[i], ringColor_b[i]);
      ellipse(ringX[i], ringY[i], ringSize[i], ringSize[i]);
      ringSize[i] = ringSize[i] + 1.0;
    }
  }
}
// -----
void mousePressed() {
  ringColor_r[useRing] = random(256);// リングの赤要素 (0〜255)
  ringColor_g[useRing] = random(256);// リングの緑要素 (0〜255)
  ringColor_b[useRing] = random(256);// リングの青要素 (0〜255)
  ringSize[useRing] = 0;
  ringX[useRing] = mouseX;
  ringY[useRing] = mouseY;
  useRing = useRing +1;
}
