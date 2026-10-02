/*
  アプリ名： Don't Collide(衝突しないで)
  使い方　： キーボードで完結。前方から対向車が来るのでそれをよけ続ける。
  注意　　： 外部ライブラリや外部ファイルは必要ない。
*/
// グローバル変数
Car myCar; //Car型の構造体 myCar
int R = 150; //プレイヤーの車の初期値(Red)
int G = 150; //プレイヤーの車の初期値(Green)
int B = 250; //プレイヤーの車の初期値(Blue)
class Car {
  int xx, size_w, size_h, r, g, b;
  Car(int yourLane, int R, int G, int B) {
    xx = yourLane;
    size_w = 40; //車体の横幅
    size_h = 65; //車体の縦幅
    r = R; //Red
    g = G; //Green
    b = B; //Blue
  }
  //関数
  void showCar() { //車を表現する関数
    strokeWeight(2);
    stroke(0);
    int st_x = x * (5+ xx); //xの基準座標
    int st_y = height * 5 / 6; //ｙの基準座標
    fill(r, g, b); //車体の色
    rect(st_x + 30, st_y, size_w, size_h); //車体の土台を描画
    fill(224, 255, 255); //ガラス色
    rect(st_x + 30, st_y +20, size_w, 35);//ガラスを描画
    fill(r, g, b); //車体の色
    rect(st_x + 35, st_y +30, size_w-10, 15);//車体の天井を描画
    //車体の左側
    line(st_x + 30, st_y +20, st_x + 35, st_y  +30);
    line(st_x + 30, st_y +55, st_x + 35, st_y +45);
    //車体の右側
    line(st_x + 70, st_y +20, st_x + 65, st_y +30);
    line(st_x + 70, st_y +55, st_x + 65, st_y +45);
    //タイヤ
    line(st_x + 28, st_y +10, st_x + 28, st_y +25);
    line(st_x + 28, st_y +45, st_x + 28, st_y +60);
    line(st_x + 72, st_y +10, st_x + 72, st_y +25);
    line(st_x + 72, st_y +45, st_x + 72, st_y +60);
  }
}
float meter = 1; // 現在のスピードメーター
int yourLane = 1; // 今車がどこにいるか
boolean gameFlg = false;
boolean resultFlg = false;
boolean countFlg = false;
boolean startFlg = false;
boolean levelFlg = false;
boolean checkFlg = true;
int countStartTime; // カウントダウンの開始時間
int score = 0;
int points = 0;
int level = 0; //対向車のスピードに作用する
int[] greys; //道路の白線の切れ目を表す
int cars = 3; // 障害物の台数
int d = 9; // d=division
int slide; //アニメーションのように作用する
int x, y; // 基準の座標
int[] e_x = new int[cars];
int[] e_y = new int[cars];
int[] e_speed = new int[cars];
boolean[] monopoly = new boolean[5]; // 各レーンに対向車が走行しているかどうか
// -----
void setup() {
  size(900, 900);
  textAlign(CENTER);
  init_game(); // ゲームの初期化
}
// -----
void init_game() {
  yourLane = 1; // yourRail=1:真ん中のレーン
  points = 0;
  meter = 1;
  level = 0;
  slide = 0;
  x = width / d;
  y = height / d;
  greys = new int[]{0, height / 3, height * 2 / 3};

  for (int i = 0; i < monopoly.length; i++) { //monopolyをfalseで初期化
    monopoly[i] = false;
  }
  for (int i = 0; i < cars; i++) { // 対向車の初期化
    init_e_car(i);
  }
}
// -----
void draw() {
  background(150);
  showRoad();
  myCar = new Car(yourLane, R, G, B);
  myCar.showCar(); // 自分が操作する車の関数
  stroke(0);
  strokeWeight(10);
  line(5, 0, 5, height);
  line(x * 4, 0, x * 4, height);
  if (gameFlg) { //ゲーム画面のとき
    showOperating();
    showMeter();
    showLevel();
    showScore();
    if (countFlg) { //カウントダウンするとき
      countDown();
    } else { //カウントダウンが終わったとき
      enemyCar();
      if (checkFlg) checkCollision();
    }
  } else {
    if (resultFlg) { // ゲームオーバーのとき
      showGameOver();
    } else { // 初期画面
      showTitle();
    }
  }
}
// -----
void countDown() { //カウントダウンをする関数
  int countDuration = 4000; // カウントダウンの継続時間（ミリ秒）
  int elapsed = millis() - countStartTime;
  int remaining = countDuration - elapsed;
  int count = int(remaining / 1000.0);

  if (count > 0) {
    stroke(255 - (count - 1) * 85, (count - 1) * 85, (count - 1) * 85);
    ellipse(x * 2, height / 2 - 110, 170, 170); //数字を囲む円
    fill(255 - (count - 1) * 85, (count - 1) * 85, (count - 1) * 85);
    textSize(150);
    text(count, x * 2, height / 2 -65);
  } else {
    stroke(255, 0, 0);
    rect(x/4, y*3-25, x*7/2, y*1.5, 40);
    fill(255, 0, 0);
    textSize(110);
    text("START!", x * 2, height / 2 -65);
  }

  if (elapsed >= countDuration) { //カウントダウンが終わったら
    countFlg = false;
    startFlg = true;
  }
}
// -----
void showRoad() { // 道を表現
  noStroke();
  // 公道
  fill(0, 140, 0); // 緑色
  rect(width * 4 / d, 0, x * 5, height);
  // 車道
  fill(128); // 灰色
  rect(x * 5, 0, x * 3, height);
  // 外側の車線
  strokeWeight(9);
  stroke(255);
  line(x * 5, 0, x * 5, height);
  line(x * 8, 0, x * 8, height);
  // 内側の車線
  strokeWeight(5);
  stroke(255);
  line(x * 6, 0, x * 6, height);
  line(x * 7, 0, x * 7, height);
  // 内側の車線の切れ目
  float speed = 2;
  stroke(128);// 灰色
  int l = 40; // l=length(切れ目の長さ)
  for (int i = 0; i < 3; i++) {
    rect(x * 6, greys[i], x, l); // 切れ目を作成
    greys[i] += 3 + meter * speed; // 切れ目を動かす
    if (greys[i] > height) // 画面外に出たとき
      greys[i] = -l;
  }
}
// -----
void init_e_car(int i) {//対向車の初期化
  do {
    e_x[i] = int(random(0, 5)); //最初は多めに
  } while (monopoly[e_x[i]]); // 既に独占状態の場合、別のレーンを選択
  e_y[i] = -int(random(200, 400));
  e_speed[i] = int(random(4, 8));
  monopoly[e_x[i]] = true;  //独占状態にする
}
// -----
void enemyCar() { // 対向車を表現する関数
  strokeWeight(2);
  stroke(0);
  for (int i = 0; i < cars; i++) {
    if (e_x[i] <= 2) { //対向車が3つのレーンの中にいる時に表示
      fill(255, 140, 0); //車体の色(orange)
      rect(x * (5 + e_x[i]) + 30, e_y[i], 40, 65); //車体の土台
      fill(224, 255, 255); //ガラス色
      rect(x * (5 + e_x[i]) + 30, e_y[i]+10, 40, 35); //車体のガラス
      fill(255, 140, 0); //車体の色(orange)
      rect(x * (5 + e_x[i]) + 35, e_y[i]+20, 30, 15); //車体の天井
      //車体の左側
      line(x * (5 +  e_x[i]) + 70, e_y[i]+10, x * (5 +  e_x[i]) + 65, e_y[i]+20);
      line(x * (5 +  e_x[i]) + 70, e_y[i]+45, x * (5 +  e_x[i]) + 65, e_y[i]+35);
      //車体の右側
      line(x * (5 +  e_x[i]) + 30, e_y[i]+10, x * (5 +  e_x[i]) + 35, e_y[i]+20);
      line(x * (5 +  e_x[i]) + 30, e_y[i]+45, x * (5 +  e_x[i]) + 35, e_y[i]+35);
      //タイヤ
      line(x * (5 +  e_x[i]) + 28, e_y[i]+5, x * (5 +  e_x[i]) + 28, e_y[i]+20);
      line(x * (5 +  e_x[i]) + 28, e_y[i]+40, x * (5 +  e_x[i]) + 28, e_y[i]+55);
      line(x * (5 +  e_x[i]) + 72, e_y[i]+5, x * (5 +  e_x[i]) + 72, e_y[i]+20);
      line(x * (5 +  e_x[i]) + 72, e_y[i]+40, x * (5 +  e_x[i]) + 72, e_y[i]+55);
    }
    e_y[i] += e_speed[i] * meter;

    if (e_y[i] > height) { // 障害物の車が画面外へ出たとき
      monopoly[e_x[i]] = false; // レーンの独占を解除
      do {
        e_x[i] = int(random(0, 4));
      } while (monopoly[e_x[i]]); // 既に独占状態の場合、別のレーンを選択

      e_y[i] = -60;
      e_speed[i] = int(random(3+level, 7+level)); //levelが上がる度にスピードが速くなる
      monopoly[e_x[i]] = true; // 独占状態にする
    }
  }
}
// -----
void checkCollision() { //衝突しているか判定する関数
  float mycarX = x * (5 + yourLane) + 30;
  float mycarY = height * 5 / 6;
  float mycarWidth = 40;
  float mycarHeight = 65;

  for (int i = 0; i < cars; i++) {
    float enemyX = x * (5 + e_x[i]) + 30;
    float enemyY = e_y[i];
    float enemyWidth = 40;
    float enemyHeight = 65;
    // 衝突判定
    if (mycarX < enemyX + enemyWidth && mycarX + mycarWidth > enemyX && mycarY < enemyY + enemyHeight && mycarY + mycarHeight > enemyY)
      gameOver();
  }
}
// -----
void gameOver() { //ゲームオーバーになると起動する関数
  gameFlg = false;
  resultFlg = true;
  startFlg = false;
}
// -----
void showGameOver() { //ゲームオーバーのときに表示
  fill(255);
  textSize(150);
  text("GAME OVER", 0, y, x*4, 400);
  textSize(75);
  text("SCORE : " + score, x * 2, y * 6);
  String t = "Press Enter to start the next game!";
  textSize(45);
  text(t, 0, y *7+50, x*4, 400);
}
// -----
void showTitle() { //タイトル画面を表示する関数
  String u = "Don't Collide";
  String s = "Press Enter to start the game!";
  fill(255);
  textSize(130);
  text(u, 0, y*1.5, x*4, 700);
  textSize(45);
  text(s, 0, y*7+50, x*4, 400);
  rect(5,y*4.5,x*4-5,y*2+25,50);
  fill(0);
  text("<Customize>", x*2,y*5);
  textSize(35);
  fill(R,0,0);
  text("(1 key)- | R = "+R +" | +(2 key)",x*2,y*5.5); //1キーで値に-1する/2キーで値に+1する
  fill(0,G,0);
  text("(3 key)- | G = "+G +" | +(4 key)",x*2,y*6); //3キーで値に-1する/4キーで値に+1する
  fill(0,0,B);
  text("(5 key)- | B = "+B +" | +(6 key)",x*2,y*6.5); //5キーで値に-1する/6キーで値に+1する
}
// -----
void showOperating() { //操作説明を表示する関数
  stroke(0);
  strokeWeight(10);
  textSize(30);
  fill(150);
  rect(5, y*5-40, x*4-5, y*3, 50);
  fill(255);
  text("A or LEFT key: Move to Left", 0, y*5, x*4, y);
  text("D or RIGHT key: Move to Right", 0, y*5+50, x*4, y);
  text("W or UP key: Speed Up", 0, y*6, x*4, y);
  text("S or DOWN key: Speed Down", 0, y*6+50, x*4, y);
}
// -----
void showLevel() { // 対向車のlevelを表示する関数
  int levelup = score % 200;
  stroke(0);
  strokeWeight(10);
  textSize(60);
  if (level > 1 && levelup < 30) { //レベルアップしたとき
    int yy = 15-levelup;
    fill(150);
    rect(5, 0, x * 4 - 5, slide+y -abs(yy*7), 50);
    fill(255);
    text("LEVEL UP!! ", x * 2, slide+70 -abs(yy*8));
  }
  fill(150);
  rect(5, 0, x * 4 - 5, slide, 50);
  fill(255);
  text("CAR LEVEL : " + level, x * 2, slide -40 );

  if (countFlg) slide +=1; //カウントダウンしている間に動く
}
// -----
void showScore() { // スコアを表示する関数
  score = points / 20;
  if (score % 200 == 0 && !countFlg) levelFlg = true;
  if (score % 200 == 1 && levelFlg) {
    level++;
    levelFlg = false;
  }
  stroke(0);
  strokeWeight(10);
  fill(150);
  rect(5, -30, x * 4 - 5, y*1.5, 50);
  fill(255);
  textSize(65);
  if (startFlg) points += meter; //カウントダウンが終わったときに動く
  text("SCORE : " + score, x * 2, 80);
}
// -----
void showMeter() { // スピードメーターを表示する
  fill(150);
  rect(5, y * 7, x * 4 - 5, y * 3, 50);
  fill(255);
  textSize(40);
  text("SPEED : " + (int(meter * 20)) + " km/h", x * 2, height * 15 / 18 - 5);
  // スピードメーターの作成
  float x1, y1; // テキストの座標
  float x2 = x * 2; // 円の中心(x座標)
  float y2 = y * 8 + 90; // 円の中心(y座標)
  float r = 110.0; // r=半径
  fill(128);
  ellipse(x2, y2 - 9, r * 1.5, r * 1.5);
  textSize(30);
  for (int i = 0; i < 7; i++) {
    fill(255);
    x1 = x2 + (r - 5) * cos(radians(180 - 30 * i));
    y1 = y2 - (r - 5) * sin(radians(180 - 30 * i));
    text(i * 20, x1, y1);
  }
  fill(255, 0, 0); // 赤色
  ellipse(x2, y2 - 9, r / 4, r / 4); // 中心の円
  float x3, y3;
  stroke(255, 0, 0); // 赤色の針
  strokeWeight(5);
  x3 = x2 + r * cos(radians(180 - meter * 30));
  y3 = y2 - r * sin(radians(180 - meter * 30));
  line(x2, y2 - 9, x3, y3);
}
// -----
void keyPressed() {
  if (keyCode == ENTER) {
    if (!gameFlg) {
      gameFlg = true;
      countFlg = true;
      countStartTime = millis();
      init_game();
    }
  }
  if (gameFlg) { //ゲーム中
    if (keyCode == LEFT || key == 'a') {
      if (yourLane != 0) // yourRail=0:左レーン
        yourLane--;
    }
    if (keyCode == RIGHT || key == 'd') {
      if (yourLane != 2) // yourRail=2:右レーン
        yourLane++;
    }
    if (keyCode == UP || key == 'w') {
      if (meter < 6) {// スピードメーターの上限は6
        meter += 0.4;
      }
    }
    if (keyCode == DOWN || key == 's') {
      if (meter > 1) {// スピードメーターの下限は1
        meter -= 0.4;
      }
    }
    //if (keyCode == SHIFT) { //確認用
    //  checkFlg = false;
    //}
  }else{
    if(!resultFlg){ //タイトル画面のときに車の色をカスタマイズできる
      if(key == '2' && R<255 ) R++;
      if(key == '4' && G<255 ) G++;
      if(key == '6' && B<255 ) B++;
      if(key == '1' && R>0 ) R--;
      if(key == '3' && G>0 ) G--;
      if(key == '5' && B>0 ) B--;
    }
  }
}
// -----
void keyReleased() { //確認用
  if (keyCode == SHIFT) {
    checkFlg = true;
  }
}
