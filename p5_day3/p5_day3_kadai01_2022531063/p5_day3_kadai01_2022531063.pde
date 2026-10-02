// グローバル変数
int count = 0; //星の回転に必要な数値
int useRing = 0;// 着目するリングの番号
int NumOfRing = 100;// リングの数
boolean shiftKeyPressed = false;// shiftキーを押しているか
myShape[] myShapes = new myShape[NumOfRing];// myRingという構造体の配列 myShapes
// -----
class myShape {// myShape という構造体(Class)の雛形
  float x, y, s;//　中心座標(x, y) と大きさ s
  int hue;// 色
  int shape;// 形
  boolean drawFlg;// 描くどうかのフラグ
  // 構造体と同名の関数はコンストラクタと呼ばれる
  myShape() {
    x = 0;
    y = 0;//
    s = 0;// size
    shape = 0;// 0なら円，1なら回転する星
    hue = 0;// 色相
    drawFlg = false;// 「描かない」に
  }
  // この構造体のなかで使える関数を定義
  void showContents() {// 中身を表示するための関数
    println("-----");
    println("center : ("+x+", "+y+")");
    println("size   : "+s);
    println("hue    : "+hue);
    println("drawFlg: "+drawFlg);
    println("-----");
  }
  void initShape(float mx, float my, boolean s_flg) {// 始点を決める
    // ここにプログラムを追加する
    x = mx;
    y = my;
    s = 0;
    shape = int(s_flg); //(true:1 , false:0)
    drawFlg = true;
    hue = int( random(100) );
  }
  void update() {// 構造体の情報を更新するための関数
    // ここにプログラムを追加する
    s = s +1;// サイズを増やす
    if ( s > width*1.5 ) {// サイズがウィンドウよりも十分に大きいならば
      drawFlg = false;
    }
  }
  void drawRing() {// リングを描画するための関数
    if ( drawFlg == true) {// 「描く」ならば
      stroke(hue, 100, 100);
      ellipse(x, y, s, s);
    }
  }
  void drawRotatingStar() {// 回転する星を描画するための関数
    if ( drawFlg == true) {// 「描く」ならば
      // ここにプログラムを追加する
      stroke(hue, 100, 100);
      for ( int i=0; i<5; i++) {
        //countを用いて回転させる
        float x1 = x + s/2*cos( radians(count+90+72*i) );
        float y1 = y - s/2*sin( radians(count+90+72*i) );
        float x2 = x + s/2*cos( radians(count+90+72*(i+2)) );
        float y2 = y - s/2*sin( radians(count+90+72*(i+2)) );
        stroke(hue, 100, 100);
        line(x1, y1, x2, y2);
      }
    }
  }
}
// -----
void setup() {
  size(400, 400);//
  colorMode(HSB, 100);
  noFill();// 図形を塗らない
  strokeWeight(2);// 線の太さ
  ellipseMode(CENTER);// 円の描画モード

  // 構造体を初期化
  for (int i=0; i<NumOfRing; i++) {
    myShapes[i] = new myShape();
    // println(i);
    // myShapes[i].showContents();
  }
}
// -----
void draw() {
  background( 0, 0, 0 );// colorModeはHSB

  // 構造体の情報を元に描画
  for (int i=0; i<NumOfRing; i++) {
    myShapes[i].update();
    if ( myShapes[i].shape == 0) {
      myShapes[i].drawRing();
    } else if (myShapes[i].shape == 1) {
      myShapes[i].drawRotatingStar();
    }
  }

  count = count + 1 ;
}
// -----
void mousePressed() {
  myShapes[useRing].initShape(mouseX, mouseY, shiftKeyPressed);
  useRing = (useRing + 1)%NumOfRing;
}
// -----
void keyPressed() {
  if (keyCode == SHIFT) {
    shiftKeyPressed = true;
  }
}
// -----
void keyReleased() {
  if (keyCode == SHIFT) {
    shiftKeyPressed = false;
  }
}
