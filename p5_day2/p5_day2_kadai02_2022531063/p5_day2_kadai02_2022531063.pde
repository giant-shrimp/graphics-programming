// グローバル変数
int count = 0;
int yourHand = 0;// 今手がどこにあるか
int[] slotNum = new int[3];// スロットの各リールの数値
int[] slotSpeed = new int[3];// 各リールの回転速度
boolean[] slotRot = new boolean[3];// 各リールが回転中かどうか(true, false)
boolean ReachFlg = false;// 今リーチかどうか
int MessageNum = 0;// メッセージを表示するかどうか（0:無表示・1:成功・2:失敗）
// -----
void setup() {
  size(400, 400);
  background( 0 );
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(30);

  init_slot();// スロットを初期化
}
// -----
void init_slot() {// Slotを初期化
  // 初期値の設定
  for ( int i=0; i<3; i++) {// 各リールを初期化
    slotNum[i] = int( random(10) );// 0~9の整数
    slotRot[i] = true;
  }
  // 回転周期の設定
  slotSpeed[0] = 20;// 1桁めの回転周期 [Frame]
  slotSpeed[1] = 10;// 2桁めの回転周期 [Frame]
  slotSpeed[2] = 3;// 3桁めの回転周期 [Frame]
  // その他の設定
  yourHand = 0;// 注目するリールを左に
  ReachFlg = false;// 「リーチではない」に
  MessageNum = 0;// 「おめでとうは表示しない」に
}
// -----
void draw() {
  background( 0 );

  updateSlot();// Slotを更新
  showSlot();// Slotを表示　
  showHand();// 手の位置を表示

  count = count + 1;
}
// -----
void updateSlot() {// Slotを更新
  for ( int i=0; i<3; i++) {// リールの数だけループ
    if ( slotRot[i] ) {// 回転中かどうか確認
      if (count%slotSpeed[i] == 0) {// 更新タイミングならば
        slotNum[i] = (slotNum[i] + 1)%10;// 1増やす
      }
    }
  }

  if (ReachFlg == true) { //リーチのフラグが立ったら背景を変化させる
    changeBackground();
  }
  if ( slotRot[2] == false ) { //3つ目のスロットまで回転が終わったら結果表示の関数へ移行
    Result();
  }
}
// -----
void showSlot() {// Slotを表示
  float x, y;
  strokeWeight(2);
  stroke(255);
  for (int i=0; i<3; i++) {
    x = width/2 + (i-1)*width/4;
    y = height/2;
    fill(0);
    rect(x, y, width/4, height/4);// 枠線
    fill(255);
    text(slotNum[i], x, y);
  }
}
// -----
void showHand() {// 現在着目しているリールを示す矢印
  float x, y;
  x = width/2 + (yourHand-1)*width/4;
  y = height/3;
  stroke(255, 255, 0);
  line(x, y, x, y-40);
  line(x, y, x-20, y-20);
  line(x, y, x+20, y-20);
}
// -----
void keyReleased() {
  if ( keyCode == DOWN) {
    checkSlot();
  } else if (keyCode == LEFT ) { //初期化
    if ( yourHand == 2 && slotRot[yourHand] == false) {// 矢印が右側にあり、回転が止まっているとき
      init_slot();
    }
  } else if (keyCode == SHIFT) { //チートを追加
    if ( yourHand == 2) {// 矢印が右側にあるならば
      Cheat();
    }
  }
}
// -----
void checkSlot() {
  slotRot[yourHand] = false; //回転を止める
  if ( yourHand < 2) { //1つ目のスロットと2つ目のスロットの数値が等しければフラグを立てる
    if ( yourHand == 1 && slotNum[yourHand-1] == slotNum[yourHand] ) {
      ReachFlg = true;
    }
    yourHand++; //矢印を次のリールへ
  }
  showHand();
}
// -----
void changeBackground() { //背景を変化させる関数
  float r, g, b; //r=赤色、g=緑色、b=青色
  r = 255 * abs(sin(radians(2*count)));  //abs(n)は、nの絶対値を返す関数である。
  g = 255 * abs(sin(radians(count+45))); //sin(),cos()は負の値も含むため、abs()で正の値へ変換。
  b = 255 * abs(cos(radians(3*count)));
  background( r, g, b ); //スロットの背景をcountを用いて変化させる
}
// -----
void Result() { //結果のテキストを表示する関数
  background(0); //背景を戻す

  // 各リールの数値が全て等しければ成功のメッセージ、それ以外は失敗のメッセージ
  if ( slotNum[yourHand-2] == slotNum[yourHand-1] && slotNum[yourHand-2] == slotNum[yourHand] ) {
    MessageNum = 1; //成功
  } else {
    MessageNum = 2; //失敗
  }

  fill(255, 255, 0);
  if ( MessageNum == 1) { //成功時のテキスト
    text("Congratulations!!", width/2, height-50);
  } else if ( MessageNum == 2 ) { //失敗時のテキスト
    text("Let's do it again", width/2, height-50);
  }
}
// -----
void Cheat() { //絶対成功するバレバレのチート
  slotNum[yourHand-1] = slotNum[yourHand-2];
  slotNum[yourHand] = slotNum[yourHand-1];
  slotRot[yourHand] = false;
  Result();
}
