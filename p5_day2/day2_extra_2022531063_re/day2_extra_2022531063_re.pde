// グローバル変数
float waveAmp = 0.0;// 波の振幅
float PxPerOneUnit = 75;// グラフの１目盛あたり何ピクセルにするか
int NumOfPoint = 1000;// 波を表現するときのデータ点の数
float[] t = new float[NumOfPoint];// 時間データを格納した配列
float[] mySignal = new float[NumOfPoint];// 信号データを格納した配列
float[] myFourierSeries = new float[NumOfPoint];// フーリエ級数を格納した配列
float[] myDiff = new float[NumOfPoint];// 信号データとフーリエ級数の差分を格納した配列
int n = 20;// フーリエ係数の個数
float[] a = new float[n];// フーリエ係数（余弦のみ）
int useN = 0;// 着目する係数
//-----
void setup() {
  size(800, 800);
  ellipseMode(CENTER);
  setSignal();// お手本の波を生成
  updateFourier();// フーリエ級数を更新
}
//-----
void draw() {
  background(128);

  // 元の信号
  showAxis(width/2, height/4);
  showData(width/2, height/4, mySignal, 'k');
  showData(width/2, height/4, myFourierSeries, 'y');

  // 差分
  showAxis(width/2, height/2);
  showData(width/2, height/2, myDiff, 'b');

  // フーリエ係数
  showFourierCoefficient(width/2, height*3/4);
}
//-----
void keyPressed() {// キーを押したとき
  //手を加えた箇所
  if ( keyCode == RIGHT ) { //矢印を右へ移動
    if (useN < n-1) useN++; //a19になるまでuseNを増やす。
  }
  if ( keyCode == LEFT ) { //矢印を左へ移動
    if (useN > 0) useN--; //a0になるまでuseNを減らす。
  }
  if ( keyCode == UP ) {
    if ( a[useN] <= 1 ) a[useN] += 0.01; //着目するフーリエ係数が0.01ずつ増える。(上限1.0まで)
    updateFourier(); //フーリエ係数を更新
  }
  if ( keyCode == DOWN ) {
    if ( a[useN] >= -1 ) a[useN] -= 0.01; //着目するフーリエ係数が0.01ずつ減る。(下限-1.0まで)
    updateFourier(); //フーリエ係数を更新
  }
  //ここまで
}
//-----
void keyReleased() {// キーを離したとき
  //手を加えた箇所
  if ( keyCode == '1' ) {
    resolveFourier(); //フーリエ係数を求めるための関数
  }
  if ( keyCode == '0' ) {
    resetFourier(); //フーリエ係数をリセット
  }
  //ここまで
}
//-----
void resolveFourier() {// フーリエ係数を求めるための関数
  //手を加えた箇所
  a[0] = 0.5; //a0を求める。
  for (int i = 1; i < n; i++) { //フーリエ解析でいうところのakを求める。(今回はan)
    a[i] = 1/PI/i*sin(PI*i/2); //一般項
  }
  //ここまで
  updateFourier();
}
//-----
void resetFourier() {// フーリエ係数をリセット
  //手を加えた箇所
  for (int i = 0; i < n; i++) { //全て初期値に戻す。
    a[i] = 0;
  }
  //ここまで
  updateFourier();
}
//-----
void setSignal() {// お手本の波を生成
  for ( int i=0; i<NumOfPoint; i++) {
    t[i] = -3.0 + 6.0*float(i)/float(NumOfPoint);
    mySignal[i] = 0.5*float( int( t[i] + 3.5 ) % 2 );// 矩形波を生成
  }
}
//-----
void updateFourier() {// フーリエ級数を更新
  float T = 2.0;// 周期
  for ( int i=0; i<NumOfPoint; i++) {
    // myFourierSeries[i] = waveAmp*cos( t[i] * 2*PI / 3.0);
    myFourierSeries[i] = a[0] / 2;
    for (int j=1; j<n; j++) {
      myFourierSeries[i] = myFourierSeries[i] + a[j]*cos( t[i] * j*2*PI / T);
    }
    myDiff[i] = mySignal[i] - myFourierSeries[i];
  }
}
//-----
void showAxis(float xC, float yC) {// グラフの軸を描画するための関数
  // 引数はグラフの中心座標(xC, yC)
  fill(255);// 文字の色
  stroke(255);// 白色の線
  strokeWeight(1);
  // Y軸
  line(xC, yC + 1.2*PxPerOneUnit, xC, yC - 1.2*PxPerOneUnit);// Y軸
  line(xC - 0.05*PxPerOneUnit, yC - 1.1*PxPerOneUnit, xC, yC - 1.2*PxPerOneUnit);// Y軸の矢羽1
  line(xC + 0.05*PxPerOneUnit, yC - 1.1*PxPerOneUnit, xC, yC - 1.2*PxPerOneUnit);// Y軸の矢羽2
  for ( int i = -1; i<=1; i++) {// y軸の目盛り
    line(xC - 0.05*PxPerOneUnit, yC - i*PxPerOneUnit, xC + 0.05*PxPerOneUnit, yC - i*PxPerOneUnit);
    text(i, xC - 0.15*PxPerOneUnit, yC - (float(i)+0.05)*PxPerOneUnit);
  }
  // X軸
  line(xC - 3*PxPerOneUnit, yC, xC +  3*PxPerOneUnit, yC);// X軸
  line(xC + 2.9*PxPerOneUnit, yC - 0.1*PxPerOneUnit, xC +  3*PxPerOneUnit, yC);// X軸の矢羽1
  line(xC + 2.9*PxPerOneUnit, yC + 0.1*PxPerOneUnit, xC +  3*PxPerOneUnit, yC);// X軸の矢羽2
  for ( int i = -2; i<=2; i++) {// y軸の目盛り
    line(xC + i*PxPerOneUnit, yC - 0.05*PxPerOneUnit, xC + i*PxPerOneUnit, yC + 0.05*PxPerOneUnit);// X軸の目盛り
    if ( i != 0) {
      text(""+i, xC + i*PxPerOneUnit, yC + 0.175*PxPerOneUnit);//
    }
  }
}
//-----
void showData(float xC, float yC, float dataSet[], char c) {// データをプロットするための関数
  // 引数はグラフの中心座標(xC, yC) と プロットしたデータ（配列） と 色情報
  float x1, y1, x2, y2;
  if ( c == 'b') {// blue
    stroke(0, 0, 255);//
  } else if (c == 'y') {// yellow
    stroke(255, 255, 0);//
  } else if (c == 'k') {// black
    stroke(0);// 黒の線
  }
  strokeWeight(2);
  for ( int i = 0; i<NumOfPoint-1; i++) {// データ点の数だけループ
    x1 = xC + t[i]*PxPerOneUnit;
    y1 = yC - dataSet[i]*PxPerOneUnit;
    x2 = xC + t[i+1]*PxPerOneUnit;
    y2 = yC - dataSet[i+1]*PxPerOneUnit;
    line( x1, y1, x2, y2);// データの曲線
  }
}
// -----
void showFourierCoefficient(float xC, float yC) {
  float x1, y1, x2, y2;

  strokeWeight(1);
  for ( int i=0; i<n; i++ ) {// フーリエ係数の数だけループ
    stroke(255);
    x1 = xC + 30*(i-10);
    x2 = x1;
    y1 = yC - 1.2*PxPerOneUnit;
    y2 = yC + 1.2*PxPerOneUnit;
    line(x1, y1, x2, y2);
    for ( int j=0; j<5; j++) {// 0.5 刻みに目盛りをつける
      float xx1 = x1 - 2;
      float xx2 = x1 + 2;
      float vv = (( float(j)-2 ) /2);
      float yy = yC - vv*PxPerOneUnit;
      line(xx1, yy, xx2, yy);
      if (i==0) {// i=0 のときのだけ左端に数値
        text(""+vv, xx1-40, yy);
      }
    }
    text("a"+i, x1-10, y2+20);// 何個めのフーリエ係数か表示

    y1 = yC - a[i]*PxPerOneUnit;// プログラムが完成したらこっちを使う
    //y1 = yC - waveAmp*PxPerOneUnit;//
    fill(255, 255, 0);
    noStroke();
    ellipse(x1, y1, 8, 8);// 現在のフーリエ係数を黄色の円で表示
  }

  // 選択中の係数を表す矢印
  stroke(255, 255, 0);
  //手を加えた箇所
  float x, y;
  x = 98 + (useN)*30;
  y = height*10/11;
  line(x, y, x, y+40);
  line(x, y, x-10, y+20);
  line(x, y, x+10, y+20);
  //ここまで
}
