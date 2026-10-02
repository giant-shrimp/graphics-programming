// グローバル変数，クラスなど
int NumOfCar = 3;
Car[] myCars;// Car型の構造体 myCar
// クラス
class Car {// Car という構造体(Class)の定義
  float x, y;// 車の中身座標 [px]
  float s;// 車の大きさ
  float wAngle;// 車輪の向き [°]
  // Classと同じ名称の関数(メソッド)はコンストラクタと呼ばれる
  Car(float xx, float yy, float ss) {
    // 引数は、中身座標と大きさ
    x = xx;// 
    y = yy;//
    s = ss;//
    wAngle = 45;
  }
  // 関数（メソッド）
  void drawBody() {// 車体を描画するための関数
    stroke(255);
    strokeWeight(1);
    fill(255);
    rect(x, y, s, s/4);// 車体（上部）
    rect(x, y - s/4, s/2, s/4);// 車体（下部）
  }
  void drawWheel() {// 車輪を描画するための関数
    stroke(255, 255, 0);
    strokeWeight(2);
    fill(0);
    ellipse(x - s/4, y + s/8, s/4, s/4);// 車輪（左）
    ellipse(x + s/4, y + s/8, s/4, s/4);// 車輪（右）
    stroke(255, 255, 0);
    for (int i=0; i<2; i++) {// スポークの本数分だけループ
      for (int j=0; j<2; j++) {// j=0 のときに左の車輪　
        float x1 = x - s/4 + j*s/2 + (s/8)*cos( radians(-wAngle+i*90) );
        float y1 = y + s/8 - (s/8)*sin( radians(-wAngle+i*90) );
        float x2 = x - s/4 + j*s/2 + (s/8)*cos( radians(-wAngle+i*90+180) );
        float y2 = y + s/8 - (s/8)*sin( radians(-wAngle+i*90+180) );
        line(x1, y1, x2, y2);// スポーク
      }
    }
  }
  void moveCar() {// 車を動かすための関数
    float dAngle = 5.0;// 1フレームでの車輪の回転角 [°]
    wAngle = wAngle + dAngle;// 車輪を回転
    x = x + (s/4)*radians(dAngle);// 360 [°] 回転したら 2*pi*r 進む
    if ( x - s/2 > width) {// 右にはみ出したら
      x = 0 - s/2;// 左に再出現
    }
  }
}
// -----
void setup() {
  size(400, 400);
  rectMode(CENTER);
  ellipseMode(CENTER);
  myCars = new Car[NumOfCar];
  for (int i=0; i<NumOfCar; i++) {
    float yy = (i+1)*height/(NumOfCar+1);
    float ss = (i+1)*40;
    myCars[i] = new Car( width/2, yy, ss);// myCarを生成
  }
}
// -----
void draw() {
  background(0);
  for (int i=0; i<NumOfCar; i++) {// 車の数だけループ　
    myCars[i].drawBody();
    myCars[i].drawWheel();
    myCars[i].moveCar();
  }
}
