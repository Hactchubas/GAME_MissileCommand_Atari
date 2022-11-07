
//  CRIA A CLASSE PARA OS METEOROS
class Meteor {
  //  VARIÁVEIS
  //    SE O METEORO PODE MIRAR NO PRÉDIO; SE O METEORO FOI DESTRUÍDO
  boolean canTarget = false, destroyed;
  //    LEVEL ATUAL
  int level;
  //    POSIÇÕES X E Y EM QUE O METEORO SURGE; O NÚMERO DO ALVO;
  int appearX,
    appearY,
    targetNum;
  //    VETORES DE LOCALIZACÃO DO METEORO; LOCALIZAÇÃO DE SEU ALVO; VETOR DA DIREÇÃO A SER PERCORRIDA
  PVector location, target = new PVector(0, 0), direction;
  //  CONSTRUTOR
  Meteor(Building buildingNow, Level levelNow) {
    level = levelNow.levelNumber;
    //  POSIÇÕES INICIAIS RANDÔMICAS ACIMA DA TELA
    appearX = int(random(width));
    appearY = int(-random(1000+100*level));

    //  DEFINE ALVO; POSIÇÃO DO METEORO; POSIÇÃO DO ALVO
    targetNum = buildingNow.Number;
    this.location = new PVector(appearX, appearY);
    target.add(buildingNow.location);

    destroyed = false;

    //  CHAMA UMA FUNÇÃO QUE GERA UM ALVO VÁLIDO CASO O ATUAL NÃO SEJA
    if (building[targetNum].hitCount >= 3) {
      targetTest();
    }
  }

  //  FUNÇÃO QUE ATUALIZA O METEORO
  void update(Level levelNow) {

    //  A DIREÇÃO É DEFINIDA PELA DIFERENÇA DOS VETORES DE POSIÇÃO DO METEORO E SEU ALVO
    //  DEFINIDA A "VELOCIADE" DO METEORO
    //  ACRESCE A DIREÇÃO À LOCALIZAÇÃO DO METEORO FAZENDO-O SE MEXER PRECISAMENTE NA DIREÇÃO DO ALVO
    direction = PVector.sub(target, location);
    direction.setMag(1+levelNow.difficulty*0.01);
    location.add(direction);

    // CHECA COLIZÃO METEORO-PRÉDIO(ALVO)
    if (dist(location.x, location.y, target.x, target.y) < 10) {
      //  PONTUA
      if (building[targetNum].hit) {
        commander.points -= 15;
      }
      building[targetNum].hit = true;
      //  CASO O ALVO ATINGIDO SEJA O JOGADOR O JOGO ACABA IMEDIATAMENTE
      if (targetNum == 6 && building[targetNum].hit == true) {
        GAMEOVER = true;
      }
      building[targetNum].hitCount++;
      // METEORO DESTRÓI-SE
      this.destroyed = true;
    }

    //  CHECA A COLISÃO DO METEORO COM A EXPLOSÃO DOS MÍSSEIS
    for (int t =0; t < missiles.size(); t++) {
      Missile missileCheck = missiles.get(t);
      if (dist(this.location.x, this.location.y, missileCheck.location.x, missileCheck.location.y) < missileCheck.timeExplosion) {
        this.destroyed = true;
        // PONTUA
        commander.points += 10;
      }
    }
  }

  //  FUNÇÃO QUE TESTA SE O PRÉDIO É UM ALVO VÁLIDO
  void targetTest() {
    int countBuildings =0;
    println("Level " + level);

    //  CHECA QUANTOS PRÉDIOS VÁLIDOS AINDA TEM (FORAM ATINGIDOS MENOS DE 3 VEZES)
    for (int j=0; j<6; j++) {
      if (building[j].hitCount < 3) {
        println("Prédio " + j + " hits: " + building[j].hitCount);
        countBuildings++;
      }
    }
    //  CASO HAJAM PRÉDIOS VÁLIDOS GERA UM NOVO ALVO PARA
    if (countBuildings > 0) {
      while (building[targetNum].hitCount > 3) {
        targetNum= int(random(7));
      }
      target.sub(target);
      target.add(building[targetNum].location);
    }
    //   CASO NÃO HAJAM PRÉDIOS VÁLIDOS, GAME OVER
    else {
      GAMEOVER = true;
      println("GAME OVER");
    }
  }

  // MOSTRA O METEORO COMO UMA LINHA DE SUA POSIÇÃO INICIAL À ATUAL
  void display() {
    fill(255);
    textSize(30);
    text(this.targetNum, location.x, location.y);

    stroke(219,85,80);
    strokeWeight(3);
    line(appearX, appearY, location.x, location.y);
    stroke(143,42,39);
    strokeWeight(7);
    point(location.x, location.y);
  }
}
