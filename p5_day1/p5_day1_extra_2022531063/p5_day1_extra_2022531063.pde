// グローバル変数
int count = 0;
/*
　完成した課題は
 　extra01, extra02 <-- 自分の進度を記入する
 */
// -----
void setup() {
  size(512, 512);//
  background( 0 );
  /*
  各関数のコメントアウトを解除して実行すれば
   各課題の結果を確認できるようにしておく
   */
  extra_01();// 色相環
  //extra_02();// ランダムドット
}
// -----
void draw() {
  // extra_04();// 広がる縞
  // extra_04b();// 広がる縞の別バージョン
  // extra_05();// ライラックチェイサー

  count = count + 1;
}
// -----
void extra_01() {// 色相環
  colorMode(HSB, 360, 100, 100);
  noStroke();
  strokeWeight(7);

  float x, y;
  float theta;// その画素の方向 [rad]
  float r = 400;// その画素の中心からの距離 [px]

  for (int i = 0; i < 360; i++) { //360 = 1回転
    theta = radians(90+i); //赤色を上に持ってくる
    x = width/2 + r * cos(theta);
    y = height/2 - r * sin(theta);

    stroke(i, 100, 100);
    line(width/2, height/2, x, y);
  }
}
// -----
void extra_02() {// ランダムドット
  int NumOfDot = 800;// ドットの数
  float[] dotX = new float[NumOfDot];// ドットのX座標を格納する配列
  float[] dotY = new float[NumOfDot];// ドットのy座標を格納する配列
  float judg_x =0;
  float judg_y =0;

  // ドットの座標を決める処理
  for (int i=0; i<NumOfDot; i++) {// ドットの数だけループ

    if (i >=2) { //ドット間を調べる
      judg_x = dotX[i-1] - dotX[i-2];
      judg_y = dotY[i-1] - dotY[i-2];
    }

    if (i <= 1) {
      dotX[i] = random(1.0) * float( width );// 出る数値は 0 ~ 200 でランダム
      dotY[i] = random(1.0) * float( width );// 出る数値は 0 ~ 200 でランダム
    } else if (i >= 2  &&  abs(judg_x) > 9  &&  abs(judg_y) > 9 ) {
      dotX[i] = random(1.0) * float( width );// 出る数値は 0 ~ 200 でランダム
      dotY[i] = random(1.0) * float( width );// 出る数値は 0 ~ 200 でランダム
    } else {
      break;
    }
  }
  // ドットを描く処理
  ellipseMode(CENTER);
  noStroke();
  fill(255);
  for (int i=0; i<NumOfDot; i++) {// ドットの数だけループ
    ellipse( dotX[i], dotY[i], 4, 4);
  }
}

// -----
void extra_03() {// 広がる縞
  background( 0 );
  noStroke();

  float val;// valueのつもり，階調値(0~255)
  float NumOfCycle = 4;// 波の数
  float x, y;
  float theta;// その画素の方向 [rad]
  float r;// その画素の中心からの距離 [px]
}
// -----
void extra_04() {// ライラックチェイサー
  colorMode(HSB, 100);
  background(0, 0, 75);
}
