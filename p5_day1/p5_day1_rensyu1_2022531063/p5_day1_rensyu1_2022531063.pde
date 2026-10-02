int cpNum = 1;
void setup() {
  size(200, 200);
  background(0);
  if (cpNum == 1) {
    cp_1();//練習①-1 四角形
  } else if (cpNum == 2) {
    cp_2();//練習①-2 楕円
  } else if (cpNum == 3) {
    cp_3();//練習①-3 線分
  } else if (cpNum == 4) {
    cp_4();//練習①-4 変数
  } else if (cpNum == 5) {
    cp_5();//練習①-5 繰り返し
  } else if (cpNum == 6) {
    cp_6();//練習①-6 文字
  } else if (cpNum == 7) {
    cp_7();//練習①-7 条件分岐
  } else if (cpNum == 8) {
    cp_8();//練習①-8 数学的な関数
  } else if (cpNum == 9) {
    cp_9();//練習①-9 配列
  }
}

void cp_9() {
  int[] a = new int[17];
  for (int i=0; i<a.length; i++) {
    a[i] = 10 + i*10;
  }
  stroke(255);
  fill(0);
  for (int i=0; i<a.length; i++) {
    rect(a[i], a[i], 20, 20);
  }
}

void cp_8() {
  float x1, x2, x3;
  float y1, y2, y3;
  float r = 70.0;

  x1 = width/2 + r*cos(PI/2);
  y1 = height/2 - r*sin(PI/2);
  x2 = width/2 + r*cos(PI/2 + 2*PI/3 );
  y2 = height/2 - r*sin(PI/2 + 2*PI/3 );
  x3 = width/2 + r*cos( radians(330) );
  y3 = height/2 - r*sin( radians(330) );

  strokeWeight(4);
  stroke(255);
  line(x1, y1, x2, y2);
  line(x2, y2, x3, y3);
  line(x3, y3, x1, y1);
  //sinは、角度の正弦を計算する。この関数は、値は-1から1の範囲で返される。sin(angle)のとき、angle=ラジアンの角度が入る。
  //cosは、角度の余弦を計算する。この関数は、値は-1から1の範囲で返される。cos(angle)のとき、angle=ラジアンの角度が入る。
  //radiansは、度測定をラジアンで対応する値に変換する。radians(degrees)のとき、degrees=ラジアンに変換する度値が入る。
  //Yの方をマイナスにしているのは、height/2 が出力結果の中央座標(縦方向について)を示し、sin は0～πの範囲で正の値、π～2πの範囲で負の値を持つことから、これらを足してしまうと逆三角形が出力されるから。
}

void cp_7() {
  int x;
  int NumOfLines =39;
  strokeWeight(2);
  for (int i=0; i<NumOfLines; i++) {
    x = 5+ i*5;
    if (i<NumOfLines/2) {
      stroke(255);
    } else {
      if (i%2 ==0) {
        stroke(0, 0, 255);
      } else if (i%2 ==1) {
        stroke(255, 255, 0);
      }
    }
    line(x, 10, x, 190);
  }
  //textは、画面にテキストを描画する。最初のパラメータで指定された情報を、追加のパラメータで指定された位置に画面に表示する。
  //text(c, x, y)とすると、c=表示する英数字、x=テキストのx座標、y=テキストのy座標を表す。
  //textAlignは、描画テキストの現在の配置を設定する。パラメータのLEFT、CENTER、および RIGHT は、text() 関数の x および y パラメータの値に関連して文字の表示特性を設定する。
}

void cp_6() {
  textAlign(CENTER, CENTER);
  text("A", 20, 20);

  textAlign(LEFT, TOP);
  for (int i=0; i<10; i++) {
    textSize(10);
    fill(255);
    text(i, 20+i*10, 40);

    textSize(20);
    fill(255, 255, 0);
    text(i, 20+i*15, 60);

    textSize(10);
    fill(255, 0, 0);
    text(i, 20, 90+10*i);
  }
  //textは、画面にテキストを描画する。最初のパラメータで指定された情報を、追加のパラメータで指定された位置に画面に表示する。
  //text(c, x, y)とすると、c=表示する英数字、x=テキストのx座標、y=テキストのy座標を表す。
  //textAlignは、描画テキストの現在の配置を設定する。パラメータのLEFT、CENTER、および RIGHT は、text() 関数の x および y パラメータの値に関連して文字の表示特性を設定する。
}

void cp_5() {
  int x;
  int NumOfLines =39;
  stroke(255);
  for (int i=0; i<NumOfLines; i++) {
    x = 5 +i*5;
    line(x, 10, x, 190);
  }
  //ある決まった回数だけ繰り返し処理をしたい場合はfor、ループさせたい場合はwhileを使う。
}

void cp_4() {
  int x1, x2, y1, y2;

  strokeWeight(2);
  stroke(255);

  x1 = 25;
  y1 = 25;
  x2 = 175;
  y2 = 175;
  line(x1, y1, x2, y2);

  x1 = 25;
  y1 = 175;
  x2 = 175;
  y2 = 25;
  line(x1, y1, x2, y2);
}

void cp_3() {
  stroke(255);
  line(90, 40, 110, 40);

  strokeWeight(4);
  line(80, 100, 120, 100);

  stroke(255, 255, 0);
  line(70, 160, 130, 160);
  //strokeは、図形の周りに線や境界線を描くために使用される色を設定する。この色は、RGBまたはHSB色で指定される。各値は0から255の範囲。
  //strokeWeightは、図形の周りの境界線に使用されるストロークの幅を設定する。
  //lineは、画面に線を描く。4つのパラメータを持つline()は、2Dで線を引く。
  //line(a,b,c,d)とすると、a=最初の点のx座標、b=最初の点のy座標、c=次の点のx座標、d=次の点のy座標を表す。
}

void cp_2() {
  ellipseMode(CENTER);

  fill(255, 0, 0);
  ellipse(width/4, height/4, 10, 40);

  fill(0, 255, 0);
  ellipse(width/2, height/2, 20, 40);

  fill(0, 0, 255);
  ellipse(width*3/4, height*3/4, 40, 40);
  //ellipseの引数は、ellipse(a,b,c,d)とすると、
  //a=楕円のx座標、b=楕円のy座標、c=楕円の幅、d=楕円の高さを表す。
  //ellipseModeを変えると、楕円が描画される場所が変わる。
}

void cp_1() {
  stroke(255);
  fill(255, 0, 0);
  rect(width/2, height/2, 50, 50);

  rectMode(CENTER);
  fill(0, 0, 255);
  rect(width/2, height/2, 50, 50);

  rectMode(CORNER);
  noFill();
  stroke(0, 255, 0);
  rect(width/4, height/4, 50, 50);
  //rectの４つの引数は、rect(a,b,c,d)とすると、
  //a=長方形のx座標、b=長方形のy座標、c=長方形の幅、d=長方形の高さを表す。
  //rectModeを変えると、長方形が描画される場所が変わる。
  //プログラムで後にあるものが、画面では一番手前に描画される。
}
