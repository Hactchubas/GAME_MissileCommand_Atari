
// CRIA UMA CLASSE DE NÍVEL ONDE A MAIORIA DAS INFORMAÇÕES E ATUALIZAÇÕES DO JOGO VAI ACONTECER
class Level {
  //  VARIÁVEIS
  //    DIFICULDADE E NÚMERO DO LEVEL
  int difficulty = 0, levelNumber;
  //    VARIÁVEL DE CONTROLE DO TEMPO ENTRE DISPAROS
  int shooTimer;

  //  CONSTRUTOR
  Level(int difficultyUpdated, int levelUpdate) {
    shooTimer =  0;
    difficulty = difficultyUpdated;
    levelNumber = levelUpdate;
  }


  //  FUNÇÃO QUE INICIA O LEVEL
  void startLevel() {
    //  CRIA OS PRÉDIOS, APENAS NO LEVEL 1 (INÍCIO DO JOGO)
    if (levelNumber == 1) {

      //  CRIA OS PRÉDIOS
      building = new Building[7];

      //  INICIALIZA MANUALMENTE UM PRÉDIO NA POSIÇÃO DO JOGADOR
      building[6] = new Building(width/2, height-100, 6);

      //  O RESTANTE DOS PRÉDIOS SÃO INICIALIZADOS DE FORMA PADRÃO NAS POSIÇÕES COMO DO JOGO ORIGINAL
      for (int i=0; i<6; i++) {
        int gambiarraMath =  width/2+25 + int(pow(-1, i)*(100+i*50));
        building[i] = new Building(  gambiarraMath, height-50, i );
      }
    }

    //  CRIA OS METEOROS DO LEVEL JÁ NO SEU INÍCIO
    meteors = new Meteor[difficulty];

    //  INICIALIZA TODOS JÁ COM ALVO RANDÔMICO DE PRÉDIO
    for (int i = 0; i < difficulty; i++) {
      meteors[i] = new Meteor(building[int(random(7))], level);
    }
  }

  //  FUNÇÃO QUE ATUALIZAE MOSTRA O LEVEL
  void update() {

    //  ATUALIZA E MOSTRA OS METEOROS
    for (int i =0; i < difficulty; i++) {
      // APENAS DOS METEOROS QUE AINDA NÃO FORAM DESTRUÍDOS
      if (!meteors[i].destroyed) {
        meteors[i].update(level);
        meteors[i].display();
      }
    }

    //  MOSTRA OS PRÉDIOS
    for (int i = 0; i < 6; i++) {
      building[i].display();
    }

    //  LIMITA O NÚMERO DE DISPAROS SEGUIDOS QUE O JOGADOR PODE DAR E ATIRA AO APERTAD A BARRA DE ESPAÇO
    shooTimer++;
    if (barKey && shooTimer > 25+difficulty && missiles.size()<10) {
      missiles.add(new Missile());
      shooTimer = 0;
    }
    //  ATUALIZA E MOSTRA OS MÍSSEIS
    for (int i =0; i< missiles.size(); i++) {
      Missile missileNow = missiles.get(i);
      missileNow.update(commander, i );
      missileNow.display();
    }
    
    //  MOSTRA O JOGADOR
    commander.display();
    
    //CHECA A CONDIÇÃO DE DERROTA EM QUE TODOS OS PRÉDIOS GORAM COMPLETAMENTE DESTRUÍDOS
    noMore_Buildings();
  }

  //  FUNÇÃO QUE CHECA SE O LEVEL FOI VENCIDO E RETORNA SUAS INFORMAÇÃOES GERAIS PARA UM NOVO LEVEL SER CRIADO
  int[] levelWon() {
    int countMeteors = 0, hittedBuildings = 0;
    // CHECA METEOROS DESTRUÍDOS
    for (int i=0; i<difficulty; i++) {
      if (meteors[i].destroyed) {
        countMeteors++;
      }
    }
    // CHECA PRÉDIOS NÃO DESTRUÍDOS 
    for (int i=0; i<6; i++) {
      if (building[i].hit) {
        hittedBuildings++;
      }
    }
    //println(hittedBuildings);
    //   CRIA UM ARRAY E RETORNA AS INFORMAÇÕES TAL QUAL A VARIÁVEL 'DIFFICULTY'
    int[] update = {countMeteors, levelNumber, 6-hittedBuildings};
    return update;
  }

  //  FUNÇÃO QUE CHECA SE TODOS OS PRÉDIOS FORARM TOTALMENTE DESTRUÍDOS
  void noMore_Buildings() {
    int countBuildings =0;
    for (int j=0; j<6; j++) {
      //  SE UM PRÉDIO FOI ATINGIDO 3 OU MAIS VEZES ELE É CONDIDERADO DESTRUÍDO
      if (building[j].hitCount < 3) {
        //println("Prédio " + j + " hits: " + building[j].hitCount);
        countBuildings++;
      }
    }
    //  SE NÃO HÁ MAIS PRÉDIOS QUE NÃO FORAM ATINGIDOS PELO MENOS 3 VEZES É DECLARADO GAME OVER
    if (countBuildings == 0) {
      GAMEOVER = true;
      println("GAME OVER");
    }
  }
}
