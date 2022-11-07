
//  VARIÁVEIS TESTE DE TECLA
boolean upKey = false, leftKey=false, downKey=false, rightKey = false, barKey = false;

//  CHECA SE AS TECLAS DE INTERESSE AINDA ESTÃO SENDO APERTADAS
void keyReleased() {
  if (keyCode == UP) {
    upKey = false;
  }
  if (keyCode == DOWN) {
    downKey = false;
  }
  if (keyCode == LEFT) {
    leftKey = false;
  }
  if (keyCode == RIGHT) {
    rightKey = false;
  }
  if (key == ' ') {
    if (keyCode == ' ') {
      barKey = false;
    }
  }
}

//  CHECA SE ALGUMA DAS TECLAS DE INTERESSE FOI APERTADA
void keyPressed() {
  if (keyCode == UP) {
    upKey = true;
  }
  if (keyCode == DOWN) {
    downKey = true;
  }
  if (keyCode == LEFT) {
    leftKey = true;
  }
  if (keyCode == RIGHT) {
    rightKey = true;
  }
  if (key == ' ') {
    if (keyCode == ' ') {
      barKey = true;
    }
  }
}
