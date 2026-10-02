// グローバル変数
int count = 0;
/*
　完成した課題は
 　kadai01 ~ kadai06   <-- 自分の進度を記入する
 */
// -----
void setup() {
  size(200, 200);//
  background( 0 );
  textSize(16);
  textAlign(CENTER, CENTER);
  /*
  各関数のコメントアウトを解除して実行すれば
   各課題の結果を確認できるようにしておく
   */
  kadai_01();// #記号
  //kadai_02();// 炭○郎っぽい格子模様
  //kadai_03();// 五芒星
  //kadai_04();// 正弦波状の縞
}
// -----
void draw() {
  //kadai_05();// アナログ時計
  //kadai_06();// 左から右に移動する輝度縞
  count = count + 1;
}
// -----
void kadai_01() {// #記号
  // ヒント：描く順番がポイント
  noStroke();// これから描く図形の枠線の色はなし

  fill(255, 255, 138);// 1つめの四角形の塗り色(黄)
  rect(40, 20, 40, 160);

  fill(255, 128, 128);// 2つめの四角形の塗り色(赤)
  rect(20, 40, 160, 40);

  fill(163, 252, 136);// 3つめの四角形の塗り色(緑)
  rect(120, 20, 40, 160);
  
  fill(126, 126, 243);// 4つめの四角形の塗り色(紫)
  rect(20, 120, 160, 40);

  fill(255, 255, 138);// 1つめの四角形の塗り色(黄)の補強,分割して描く四角形を１つに削減
  rect(40, 120, 40, 40);

}
// -----
void kadai_02() {// 炭○郎
  // ヒント：２重forループを使う，奇数と偶数をうまく使って交互にする，全集中
  float x, y, w=20, h=20;
  noStroke();
  for (y = 0; y < 10; y++) {
    for (x = 0; x <10; x++) {
      if (y%2 == x%2) {
        fill(84, 175, 135); //緑色に塗る
      } else { //（今回はsetupでbackground( 0 )と定義しているため、この文は無くても成り立つ。）
        fill(0); //黒色に塗る
      }
      rect(20*x, 20*y, w, h); //if文,else文の中にrect()を書いていたので、外へ出した。
    }
  }
}
// -----
void kadai_03() {// 五芒星
  // ヒント：何度ずつにすればいいんでしょうね　→　360°/5 = 72°
  float x1, y1, x2, y2;
  float r = 50.0;
  for (int i = 0; i < 5; i++ ) {
    x1 = width/2 + r*cos( radians(90+72*i) ); //この点(90°)を基準として以降は72°ずつ足していく。
    y1 = height/2 - r*sin( radians(90+72*i) );

    x2 = width/2 + r*cos( radians(90+72*(i+2)) );
    y2 = height/2 - r*sin( radians(90+72*(i+2)) );

    strokeWeight(2);// 線の太さ
    stroke(255);// 線の色は白
    line(x1, y1, x2, y2); //五芒星を描く
  }
}
// -----
void kadai_04() {// 正弦波状の縞
  // ヒント：幅 width，高さ 1 の四角形を明るさを変えながら描く
  float val;// 階調値(0~255)→マイナスになってはいけない
  float NumOfCycle = 25;// 波の数
  noStroke();// これがないと大変

  for (int i = 0; i < 200; i++) {
    val = 127.5 * (1 + sin(2 * PI *i/NumOfCycle)); // 0～255の間へ変換
    fill(val);
    rect(0, i, width, 1);
  }
}
// -----
void kadai_05() {// アナログ時計
  // ヒント：回転方向に気をつける
  float x = width/2, y =height/2 ;

  background( 0 );

  // 最初に文字盤を描く
  noStroke();
  fill(255);
  textSize(20);
  float x1, y1;
  float r = 60.0;
  for (int i = 0; i < 12; i++ ) {
    x1 = width/2 + r*cos( radians(90-30*i) ); //この点(90°)を基準として以降は30°ずつ引いていく。
    y1 = height/2 - r*sin( radians(90-30*i) );
    text(i, x1, y1);
  }

  // 時計の針を描く
  noFill();// 塗らない
  strokeWeight(2);
  int speed = 100; //時計の針が回る速さ

  //秒針
  float x2, y2;
  stroke(0, 0, 200); //青色の針
  x2 = width/2 + (r-40)*cos( radians(90-speed*count) );
  y2 = height/2 - (r-40)*sin( radians(90-speed*count) );
  line(x, y, x2, y2);

  //長針
  float x3, y3;
  stroke(255, 0, 0); //赤色の針
  x3 = width/2 + (r-10)*cos( radians(90-speed*count/360) ); //秒針が1周(360°回転)したら1°進む
  y3 = height/2 - (r-10)*sin( radians(90-speed*count/360) );
  line(x, y, x3, y3);

  //短針
  float x4, y4;
  stroke(84, 175, 135); //緑色の針
  x4 = width/2 + (r-30)*cos( radians(90-speed*count/360/12) ); //長針が12°進むと1°進む
  y4 = height/2 - (r-30)*sin( radians(90-speed*count/360/12) );
  line(x, y, x4, y4);
}
// -----
void kadai_06() {// 動く縞
  // ヒント：kadai_04と途中まで一緒
  float val;// 階調値(0~255)
  float NumOfCycle = 100;// 波の数

  background( 0 );
  noStroke();

  for (int i = 0; i < 200; i++) {
    val = 127.5 * (1 + sin(2 * PI *(i-count)/NumOfCycle)); // 0～255の間へ変換、countで動かす
    fill(val);
    rect(i, 0, 1, height);
  }
}
