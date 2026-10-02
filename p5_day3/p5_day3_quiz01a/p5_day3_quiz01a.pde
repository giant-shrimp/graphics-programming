// グローバル変数
int NumOfCell = 9;// セルの数
int[] passcode;// パスコード
int passcodeLength;// パスコードの長さ
int inputCodeLength = 0;// 入力したコードの長さ
nineCells nc;// nineCells型の構造体
boolean unlocked = false;// 「解けていない」
boolean alert = false;// 「警告しない」
int count = 0;
// 構造体
class nineCells {// nineCellsという構造体の雛形
  int[] id;// 
  int[] light;// セルの数値（点灯なら1）
  float cellSize;
  float[] posX, posY;

  nineCells() {// コンストラクタ
    cellSize = 100;
    id = new int[NumOfCell];// 配列の初期化
    light = new int[NumOfCell];
    posX = new float[NumOfCell];
    posY = new float[NumOfCell];
    for ( int i=0; i<NumOfCell; i++) {
      id[i] = i+1;// id は 1~9
      light[i] = 1;// 最初は全て点灯
      posX[i] = width/2 + ((i%3)-1)*cellSize;
      posY[i] = height/2 + (1-(i/3))*cellSize;
    }
  }
  void touchLight(int target) {// 点灯情報の更新
    int hIdx = target%3;// 水平位置(左から0,1,2)
    int vIdx = target/3;// 垂直位置(下から0,1,2)

    light[target] = ( light[target] + 1 ) %2;// targetのセル

    if ( vIdx == 0) {//　下側
      light[target+3] = ( light[target+3] + 1 ) %2;// targetの1つ上のセル
    } else if (vIdx == 1) {// 中央
      light[target+3] = ( light[target+3] + 1 ) %2;// targetの1つ上のセル
      light[target-3] = ( light[target-3] + 1 ) %2;// targetの1つ下のセル
    } else if (vIdx == 2) {// 上側
      light[target-3] = ( light[target-3] + 1 ) %2;// targetの1つ下のセル
    }

    if ( hIdx == 0) {//　左側
      light[target+1] = ( light[target+1] + 1 ) %2;// targetの1つ右のセル
    } else if (hIdx == 1) {// 中央
      light[target+1] = ( light[target+1] + 1 ) %2;// targetの1つ右のセル
      light[target-1] = ( light[target-1] + 1 ) %2;// targetの1つ左のセル
    } else if (hIdx == 2) {// 右側
      light[target-1] = ( light[target-1] + 1 ) %2;// targetの1つ左のセル
    }
  }
  void drawCells() {// セルを描画するための関数
    for ( int i=0; i<NumOfCell; i++) {
      stroke(0);
      fill(255, 255, (1-light[i])*255);// 点灯なら黄色
      rect(posX[i], posY[i], cellSize, cellSize);
      fill(0);
      text(id[i], posX[i], posY[i]);
    }
  }
  int checkLightSum() {// 点灯しているセルの合計を返す関数
    int tmp = 0;
    for ( int i=0; i<NumOfCell; i++) {
      tmp = tmp + light[i];
    }
    return tmp;
  }
}
// -----
void setup() {
  size(400, 400);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(20);

  nc = new nineCells();// nineCellsの生成（コンストラクタを呼び出す）

  initPasscode(3);
}
// -----
void initPasscode(int len) {
  inputCodeLength = 0;
  unlocked = false;// 「解けてない」
  alert = false;// 「警告しない」
  passcodeLength = len;
  passcode = new int[len];
  boolean passcodeGenerated;// passcodeが生成されたかどうか
  for ( int i=0; i<len; i++) {
    passcodeGenerated = false;
    while ( passcodeGenerated == false) {// 「生成されていない」間はずっと
      int tmp = int( random(9) );// 0~8の整数

      nc.touchLight(tmp);
      if ( nc.checkLightSum() != 9) {
        if ( i == 0) {// iが1の場合
          passcode[i] = tmp;
          passcodeGenerated = true;// 「生成された」
        } else if ( i > 0) {// iが1より大きい場合
          if (passcode[i-1] != tmp) {// 一つ前の数字とは異なるならば
            passcode[i] = tmp;
            passcodeGenerated = true;// 「生成された」
          } else {
            nc.touchLight(tmp);// 同じ場所を触ってやり直し
          }
        }
      } else {// 9マス全部点灯ならば、
        nc.touchLight(tmp);// 同じ場所を触ってやり直し
      }
    }
    print((passcode[i]+1)+" -> ");
  }
  println();
}
// -----
void draw() {
  if ( alert ) {// 想定手数よりも多くなったら警告を出す
    background( map(sin(2*PI*count/32 ), -1, 1, 0, 255), 0, 0);
  } else {
    background( 0 );
  }
  if ( unlocked ) {// 「解けた」ら
    fill(255);
    text("Passcode is unlocked!", width/2, height/16);
  } 
  nc.drawCells();// セルを描画するための関数

  count = count + 1;
}
// -----
void keyReleased() {
  if ( key == '1') {
    nc.touchLight(0);
  } else if ( key == '2') {
    nc.touchLight(1);
  } else if ( key == '3') {
    nc.touchLight(2);
  } else if ( key == '4') {
    nc.touchLight(3);
  } else if ( key == '5') {
    nc.touchLight(4);
  } else if ( key == '6') {
    nc.touchLight(5);
  } else if ( key == '7') {
    nc.touchLight(6);
  } else if ( key == '8') {
    nc.touchLight(7);
  } else if ( key == '9') {
    nc.touchLight(8);
  }
  inputCodeLength = inputCodeLength + 1;
  // passcodeの確認作業を行う
  if ( nc.checkLightSum() == 9) {// 全てのセルが点灯されたら
    unlocked = true;
    alert = false;//
  } else {
    if ( inputCodeLength >= passcodeLength) {// 想定したものより長くなったら
      alert = true;// 「警告する」
    }
  }
}
