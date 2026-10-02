import processing.sound.*;
int gameflg = 0; //音ゲーで利用
float count = 0; //音ゲーで利用
int NumOfOctave = 2; //オクターブの数
int NumOfTone = NumOfOctave*12; //音階の数
SinOsc[] sine = new SinOsc[NumOfTone];
boolean[] tonePressed = new boolean[NumOfTone];
// -----
void setup() {
  size(640, 640);
  background(255);
  for (int i=0; i < NumOfTone; i++) {
    sine[i] = new SinOsc(this);
    sine[i].freq(261.626*pow(pow(2, 1.0/12.0), i));
    sine[i].amp(0.5);
  }
}
// -----
void draw() {
  background(0);

  drawWhiteKeys();
  drawBlackKeys();

  for (int i =0; i < NumOfTone; i++) {
    if (tonePressed[i] == true) {
      sine[i].play();
    } else if (tonePressed[i] == false) {
      sine[i].stop();
    }
  }

  if (gameflg %2 == 1) { //gameflgが奇数であれば音ゲー開始
    otoge();
  }
}
// -----
void drawWhiteKeys() { //白い鍵盤
  float oct_width = (float)width / ((float)NumOfOctave);
  float key_width = oct_width / 7; //キーの幅
  strokeWeight(2);

  for (int i=0; i < NumOfTone; i++) {
    int oct_num = i/12; //何オクターブ目か
    int onkai = i%12; //音階
    float x = 0;

    if (tonePressed[i]) {
      fill(255, 255, 0, 128); //押されると黄色に変化
      stroke(255, 255, 0);
    } else {
      fill(255); //白の鍵盤に戻る
      stroke(0);
    }
    if (onkai <= 4) {
      if (onkai%2 == 0) {
        x = (float)oct_num *(7 *key_width) + ((float)onkai/2) *key_width;
        rect(x, 460, key_width, 180);
      }
    } else if (onkai > 4) {
      if (onkai%2 == 1) {
        x = (float)oct_num *(7 *key_width) + (((float)onkai + 1)/2) *key_width;
        rect(x, 460, key_width, 180);
      }
    }
  }
  noStroke();
}
// -----
void drawBlackKeys() { //黒い鍵盤
  float oct_width = (float)width / ((float)NumOfOctave);
  float key_width = oct_width / 7; //キーの幅
  strokeWeight(2);

  for (int i=0; i < NumOfTone; i++) {
    int oct_num = i/12; //何オクターブ目か
    int onkai = i%12; //音階
    float x = 0;

    if (tonePressed[i]) {
      fill(100, 100, 255); //押されると青色に変化
      stroke(255, 255, 0);
    } else {
      fill(0); //黒い鍵盤に戻る
      stroke(0);
    }
    if (onkai <= 3) {
      if (onkai%2 == 1) {
        x = (float)oct_num *(7 *key_width) + ((float)onkai/2) *key_width;
        rect(x+key_width/4, 460, key_width/2, 110);
      }
    } else if (onkai > 5) {
      if (onkai%2 == 0) {
        x = (float)oct_num *(7 *key_width) + (((float)onkai + 1)/2) *key_width;
        rect(x+key_width/4, 460, key_width/2, 110);
      }
    }
  }
  noStroke();
}
// -----
void keyPressed() { //keyを押したとき
  if ( key == 'q') {
    tonePressed[0] = true;
  }
  if ( key == '2') {
    tonePressed[1] = true;
  }
  if ( key == 'w') {
    tonePressed[2] = true;
  }
  if ( key == '3') {
    tonePressed[3] = true;
  }
  if ( key == 'e') {
    tonePressed[4] = true;
  }
  if ( key == 'r') {
    tonePressed[5] = true;
  }
  if ( key == '5') {
    tonePressed[6] = true;
  }
  if ( key == 't') {
    tonePressed[7] = true;
  }
  if ( key == '6') {
    tonePressed[8] = true;
  }
  if ( key == 'y') {
    tonePressed[9] = true;
  }
  if ( key == '7') {
    tonePressed[10] = true;
  }
  if ( key == 'u') {
    tonePressed[11] = true;
  }
  if ( key == 'j') {
    tonePressed[12] = true;
  }
  if ( key == 'i') {
    tonePressed[13] = true;
  }
  if ( key == 'k') {
    tonePressed[14] = true;
  }
  if ( key == 'o') {
    tonePressed[15] = true;
  }
  if ( key == 'l') {
    tonePressed[16] = true;
  }
  if ( key == ';') {
    tonePressed[17] = true;
  }
  if ( key == '@') {
    tonePressed[18] = true;
  }
  if ( key == ':') {
    tonePressed[19] = true;
  }
  if ( key == '[') {
    tonePressed[20] = true;
  }
  if ( key == ']') {
    tonePressed[21] = true;
  }
  if ( keyCode == ENTER ) {
    tonePressed[22] = true;
  }
  if ( keyCode == SHIFT ) {
    tonePressed[23] = true;
  }
}
// -----
void keyReleased() { //keyを放したとき
  if ( key == 'q') {
    tonePressed[0] = false;
  }
  if ( key == '2') {
    tonePressed[1] = false;
  }
  if ( key == 'w') {
    tonePressed[2] = false;
  }
  if ( key == '3') {
    tonePressed[3] = false;
  }
  if ( key == 'e') {
    tonePressed[4] = false;
  }
  if ( key == 'r') {
    tonePressed[5] = false;
  }
  if ( key == '5') {
    tonePressed[6] = false;
  }
  if ( key == 't') {
    tonePressed[7] = false;
  }
  if ( key == '6') {
    tonePressed[8] = false;
  }
  if ( key == 'y') {
    tonePressed[9] = false;
  }
  if ( key == '7') {
    tonePressed[10] = false;
  }
  if ( key == 'u') {
    tonePressed[11] = false;
  }
  if ( key == 'j') {
    tonePressed[12] = false;
  }
  if ( key == 'i') {
    tonePressed[13] = false;
  }
  if ( key == 'k') {
    tonePressed[14] = false;
  }
  if ( key == 'o') {
    tonePressed[15] = false;
  }
  if ( key == 'l') {
    tonePressed[16] = false;
  }
  if ( key == ';') {
    tonePressed[17] = false;
  }
  if ( key == '@') {
    tonePressed[18] = false;
  }
  if ( key == ':') {
    tonePressed[19] = false;
  }
  if ( key == '[') {
    tonePressed[20] = false;
  }
  if ( key == ']') {
    tonePressed[21] = false;
  }
  if ( keyCode == ENTER ) {
    tonePressed[22] = false;
  }
  if ( keyCode == SHIFT ) {
    tonePressed[23] = false;
  }
  if ( keyCode == UP ) { //UPkeyを放すごとに,gameflgが加算される
    gameflg++;
  }
  if ( keyCode == RIGHT ) { //countを初期化
    count = 0;
  }
}
// -----
void otoge() { //音ゲー関数
  fill(255);
  textSize(30);
  text("Country Road", 240, 30); //カントリーロードを再現
  int base = 180; //鍵盤のheight
  int half = 90; //base/2

  fumen(0, 0, base*1);      //ド
  fumen(0, 2, base*2+half); //レ
  fumen(0, 4, base*4);      //ミ
  fumen(0, 4, base*5);
  fumen(0, 4, base*6);
  fumen(0, 4, base*7);

  fumen(0, 4, base*9);      //ミ
  fumen(0, 2, base*9+half); //レ
  fumen(0, 0, base*10+half);//ド
  fumen(0, 2, base*12);     //レ
  fumen(0, 2, base*13);
  fumen(0, 2, base*14);
  fumen(0, 2, base*15);
}
// -----
void fumen(int a, int b, int c) { //譜面を流す関数
  float oct_width = (float)width / ((float)NumOfOctave);
  float key_width = oct_width / 7; //キーの幅
  float x = 0;
  int blackwhite = a; //0:白い鍵盤、 1:黒い鍵盤
  int oct_num = b/12; //0: 1オクターブ目、 1: 2オクターブ目
  int onkai = b%12; //音階
  float y = count - c; //y座標,cの値が大きいほど遅れて譜面が流れてくる（スピードは変わらない）
  strokeWeight(2);

  fill(0, 200, 0, 140);
  if (onkai <= 4 && blackwhite == 0) {
    if (onkai%2 == 0) {
      x = (float)oct_num *(7 *key_width) + ((float)onkai/2) *key_width;
      rect(x, y, key_width, 180);
    }
  } else if (onkai > 4 && blackwhite == 0) {
    if (onkai%2 == 1) {
      x = (float)oct_num *(7 *key_width) + (((float)onkai + 1)/2) *key_width;
      rect(x, y, key_width, 180);
    }
  } else if (onkai <= 3 && blackwhite == 1) {
    if (onkai%2 == 1) {
      x = (float)oct_num *(7 *key_width) + ((float)onkai/2) *key_width;
      rect(x+key_width/4, y, key_width/2, 110);
    }
  } else if (onkai > 5 && blackwhite == 1) {
    if (onkai%2 == 0) {
      x = (float)oct_num *(7 *key_width) + (((float)onkai + 1)/2) *key_width;
      rect(x+key_width/4, y, key_width/2, 110);
    }
  }
  count = count + 0.5; //譜面が流れるスピード
  if (count > 5000 ) count = 0;
  noStroke();
}
