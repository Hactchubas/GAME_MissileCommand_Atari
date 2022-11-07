
// CRIA UMA CLASSE PARA OS PRÉDIOS/ALVOS DOS METEOROS DO JOGO
class Building {
  //  VARIÁVEIS
  //    VARIÁVEL QUE CHECA SE O PRÉDIO JÁ FOI ATINGIDO
  boolean hit;
  //    DÁ UM NÚMERO IDENTIFICADOR AO PRÉDIO, CONTA QUANTAS VEZES O PRÉDIO FOI ATINGIDO
  int Number, hitCount;
  //    VETOR DA POSIÇÃO DO PRÉDIO
  PVector location;
  
  //  CONSTRUTOR
  Building(int x,int y, int num) {
    location = new PVector(x, y);
    hit = false;
    Number = num;
    hitCount = 0;
  }
  
  //  FUNÇÃO QUE MOSTRA OS PRÉDIOS DE ACORDO COM AS SUAS INFORMAÇÕES ATUAIS
  void display() {
    noStroke();
    if (!hit) {
      fill(59,148,219);
      ellipse(location.x, location.y, 30, 30);
    } else {
      fill(46, 99, 143,100-hitCount*15);
      ellipse(location.x, location.y, 30, 30);
    }
    fill(0);
    textSize(10);
    text(this.hitCount +"\n"+this.Number, location.x, location.y);
  }
}
