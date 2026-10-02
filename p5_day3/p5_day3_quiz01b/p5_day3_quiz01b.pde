// グローバル変数
int NumOfCard = 9*2;// カードの数
myCard[] cards = new myCard[NumOfCard];// myCard型の配列
int[] selectedCardIndex;
int NumOfSelectedCard;
int n1, n2;// 1枚目と2枚目にめくったカード
int count = 0;
int countForCardReverse;
boolean chooseable = true;
// 構造体
class myCard {// myCardという構造体の雛形
  int id, value;
  float x, y, w, h;
  boolean cursorOn;// マウスカーソルがあるかどうか
  boolean appear;// 裏の数が見えているかどうか
  boolean pairFound;// ペアが見つかったかどうか

  myCard(int num1, int num2) {// コンストラクタ
    // 引数は,通し番号(num1, 0~17)と裏に描かれた番号(num2, 0~9)
    id = num1;
    value = num2;
    x = 150 + 100*(id%6);
    y = 150 + 150*(id/6);
    w = 75;
    h = 100;
    cursorOn = false;// 「カードの上にカーソルはない」に
    appear = false;// 「見せない」に
    pairFound = false;// 「ペアは見つかっていない」
    println("[" + nf(id, 2, 0) + "]: " + value);
  }
}
// -----
void setup() {
  size(800, 600);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(20);

  initMyCards();// カードの初期化
}
// -----
void initMyCards() {
  int[] tmpArray = new int[NumOfCard];
  boolean loopFlg;
  for ( int i=0; i<NumOfCard; i++) {
    loopFlg = true;// ひとまず「ループする」に
    while (loopFlg) {// 「ループする」の間は
      int tmp = int( random( NumOfCard/2 ) );
      if ( tmpArray[tmp] < 2 ) {// 使用回数が 2 未満ならば
        tmpArray[tmp] = tmpArray[tmp] + 1;
        cards[i] = new myCard(i, tmp+1);
        loopFlg = false;// 「ループしない」に
      }
    }
  }
  selectedCardIndex = new int[2];
  NumOfSelectedCard = 0;
}
// -----
void draw() {
  background( 0 );

  drawCard();

  // ２枚目で外れた場合の処理
  if ( NumOfSelectedCard == 2) {
    if ( cards[n1].value != cards[n2].value ) {
      if ( count - countForCardReverse > 60 ) {
        cards[n1].appear = false;
        cards[n2].appear = false;
        NumOfSelectedCard = 0;
        chooseable = true;
      }
    }
  }
  count = count + 1;
}
// -----
void drawCard() {
  strokeWeight(4);

  for (int i=0; i<NumOfCard; i++) {
    if ( cards[i].appear ) {
      stroke(255);
      fill(255);
      rect( cards[i].x, cards[i].y, cards[i].w, cards[i].h);
      fill(0);
      text(cards[i].value, cards[i].x, cards[i].y);
      if ( cards[i].pairFound ) {
        stroke(255, 0, 0);
        line(cards[i].x - cards[i].w/2, cards[i].y - cards[i].h/2, cards[i].x + cards[i].w/2, cards[i].y + cards[i].h/2);
      }
    } else {

      fill(128);
      if ( cards[i].cursorOn ) {
        stroke(128, 255, 128);
      } else {
        stroke(255);
      }
      rect( cards[i].x, cards[i].y, cards[i].w, cards[i].h);
    }
  }
}
// -----
void mouseMoved() {
  cursorCheck();
}
// -----
void cursorCheck() {
  for (int i=0; i<NumOfCard; i++) {
    if ( abs(mouseX - cards[i].x) < cards[i].w/2 && abs(mouseY - cards[i].y) < cards[i].h/2 ) {
      cards[i].cursorOn = true;// 「カードの上にカーソルがある」に
    } else {
      cards[i].cursorOn = false;// 「カードの上にカーソルがない」に
    }
  }
}
// -----
void mousePressed() {
  if ( chooseable) {
    openCard();
  }
}
// -----
void openCard() {
  for (int i=0; i<NumOfCard; i++) {
    if ( cards[i].cursorOn ) {// 「カードの上にカーソルがある」ならば
      cards[i].appear = true;
      selectedCardIndex[NumOfSelectedCard] = i;
      NumOfSelectedCard = NumOfSelectedCard+1;
      if ( NumOfSelectedCard == 2) {// 選んだのが2枚目ならば
        n1 = selectedCardIndex[0];
        n2 = selectedCardIndex[1];
        if ( cards[n1].value == cards[n2].value ) {// ペアだった場合
          cards[n1].pairFound = true;// 「ペアが見つかった」に
          cards[n2].pairFound = true;
          NumOfSelectedCard = 0;// 選択しているカードの枚数をリセット
        } else {// はずれの場合
          chooseable = false;// 一定時間選べないようにする(draw内で処理する)
          countForCardReverse = count;// 選べない時間の開始時刻
        }
      }
    }
  }
}
