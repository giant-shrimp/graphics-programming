void setup() {
  size(360, 640);// ここは固定
  background(225, 245, 252);
  int M = 5; //M行
  int N = 5; //N列
  float size = 45; //図形のサイズ

  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      float x = j * size * 2; //次の三角形までの横幅
      float y = i * size * 3; //次の三角形までの縦幅
      if (j % 2 != 0) { //列が奇数の場合、図形を半段+αだけずらす
        y += size + random(10) ; //α = (0~9)
      }
      int figure = (int)random(3); // ランダムに形状を選択( 0:円、 1:三角、 2:四角)
      drawPajamas(x, y, figure, size);// 自作の関数
    }
  }
  saveFrame("myWallPaper_2022531063.png");
}
// -----
void drawPajamas(float x, float y, int figure, float size) { //ランダムに選ばれた図形を描く
  stroke(0);
  strokeWeight(5);
  float random_theta = random(2*PI); //random_thetaで、各図形に角度を付与する

  if ( figure == 0 ) { //円を描く
    fill(64, 198, 113); //緑色に塗る
    ellipse(x, y, size*1.5, size*1.5);
  }else if ( figure == 1 ) { //三角形を描く
    fill(254, 3, 18); //赤色に塗る
    beginShape(TRIANGLES);
    for (int i = 0; i < 3; i++) { //一連(3つ)の頂点を接続する
      float theta = random_theta + i * 2 * PI /3 ;
      float x_tri = cos(theta) * size;
      float y_tri = sin(theta) * size;
      vertex(x + x_tri, y + y_tri);
    }
    endShape();
  }else if ( figure == 2 ) { //四角形を描く
    fill(255, 204, 129); //黄色に塗る
    beginShape(QUADS);
    for (int i = 0; i < 4; i++) { //一連(4つ)の頂点を接続する
      float theta = random_theta + i * 2 * PI /4 ;
      float x_qu = cos(theta) * size;
      float y_qu = sin(theta) * size;
      vertex(x + x_qu, y + y_qu);
    }
    endShape();
  }
}
