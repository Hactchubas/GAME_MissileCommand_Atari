


// CRIA A CLASSE DOS MÍISEIS
class Missile {
  //  VARIÁVEIS
  //    TEMPO QUE DEMORA A EXPLOSÃO
  int timeExplosion = 0;
  //    LOCALIZAÇÃO DO TIRO; DIREÇÃO A SER PERCORRIDA; POSIÇÃO ONDE O TIRO FOI COMANDADO A EXPLODIR
  PVector location, direction, shoot;
  //    SE O MÍSSEL JÁ EXPLODIU; SE ELE ESTÁ DISPONÍVEL PARA SER ATIRADO;
  boolean explode, available;
  //   CONSTRUTOR
  Missile() {
    //  POSIÇÕES E CONDIÇÕES INÍCIAIS DOS TIROS
    location = new PVector(width/2, height-100);
    available = true;
    explode = false;
  }

  //  FUNÇÃO QUE ATUALIZA OS MÍSSEIS
  void update(Commander commando, int i) {
    //  TESTA SE UM METEORO ESTÁ DISPONÍVEL, OU SEJA, SE ELE NÃO ESTÁ EM CURSO OU TENHA JÁ EXPLODIDO
    if (this.available) {
      //  ATUALIZA A POSIÇÃO QUE O MÍSSEL DEVE EXPLODIR PARA A POSIÇÃO ATUAL DA MIRA DO COMANDANTE
      this.shoot = new PVector(commando.posX, commando.posY);
      this.available = false;
    }
    //  CASO NÃO DESTRUÍDO E EM CURSO ATUALIZA A POSIÇÃO DO MÍSSEL NA DIREÇÃO EM QUE FOI-LHE COMANDADO
    if (!this.explode && !this.available) {
      this.direction = PVector.sub(location, shoot);
      this.direction.setMag(-10);
      location.add(this.direction);
      //  CHECA SE O MÍSSEL CHEGOU AO LOCAL DE EXPLOSÃO E MUDA SEU ESTADO DE EXPLODE
      if (dist(this.location.x, this.location.y, this.shoot.x, this.shoot.y)<5) {
        this.explode = true;
      }
      // BUGFIX-----------
      if (this.location.x == width/2) {
        if (dist(this.location.x, this.location.y, this.shoot.x, this.shoot.y)<10) {
          this.explode = true;
        }
      }
      //------------------
    }
    //  FAZ UMA CONTAGEM DE TEMPO DE ATÉ 30 LOOPS COM O MÍSSEL EM EXPLOSÃO E DEPOIS O REMOVE DO ARRAYLIST
    if (explode) {
      timeExplosion++;
      if (timeExplosion > 30) {
        missiles.remove(i);
      }
    }
  }

  //  MOSTRA O MÍSSEL TANTO ANTES COMO ENQUANTO EXPLODE
  void display() {
    if (!explode) {
      strokeWeight(5);
      stroke(0, 255, 0);
      point(this.location.x, this.location.y);
      noStroke();
    } else {
      noStroke();
      fill(255, 0, 0);
      ellipse(this.location.x, this.location.y, 2*timeExplosion, 2*timeExplosion);
    }
  }
}
