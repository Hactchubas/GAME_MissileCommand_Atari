
//  CRIA O JOGADOR
class Commander {
  //  VARIÁVEIS
  //    POSIÇÕES X E Y DA MIRA DO JOGADOR 
  int posX, posY;
  //    PONTOS DO JOGADOR
  int points;
  
  //  CONSTRUTOR
  Commander() {
    posX = width/2;
    posY = height/2;
    points = 0;
  }


//  FUNÇÃO QUE AUALIZA A POSIÇÃO DA MIRA DO JOGADOR
  void move() {
    if (upKey && posY >= 10) {
      posY-=5;
    }
    if (downKey && posY <= height-90) {
      posY+=5;
    }
    if (leftKey && posX >= 10) {
      posX-=5;
    }
    if (rightKey && posX <= width-10) {
      posX+=5;
    }
  }

// FUNÇÃO QUE MOSTRA O JOGADOR E AS INFORMAÇÕES DE LEVEL E SEUS PONTOS
  void display() {
    //  CHAMA A FUNÇÃO QUE MOVE A MIRA
    move();
    
    //  INFORMAÇÃOES DE PONTOS E LEVEL NA TELA
    fill(255);
    textAlign(CENTER, TOP);
    textSize(40);
    text(this.points, width/2, 10);
    textAlign(LEFT, TOP);
    textSize(40);
    text("Level  "+difficulty[1], 10, 10);    
    
    // DESENNHA O JOGADOR E O CANHÃO BASEADO NA MIRA DO JOGADOR
    float angle;
    rectMode(CENTER);
    pushMatrix();
    translate(width/2, height-100);
    angle = atan2(posY-height+100, posX-width/2);
    rotate(angle);
    fill(145);
    rect(25, 0, 20, 5);    
    popMatrix();
    fill(255-30*building[6].hitCount);
    ellipse(width/2,height-100,30,30);
    fill(255);
    rect(posX, posY, 10, 10);
  }
}
