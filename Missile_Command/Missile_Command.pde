  
  
//  Variáveis:
  //  boolean que define se o jogador não atingiu nenhuma das condições de derrota:
boolean GAMEOVER = false;
  //  IMAGEM DE FUNDO
PImage fundo;
  //  Classes para cada um dos tipos de objetos que criei para a aplicação
Building[] building;
Meteor[] meteors;
Level level;
Commander commander;
ArrayList <Missile> missiles = new ArrayList<Missile>();

  //  Define a dificuldade e o quanto o jogo foi avançado, sendo:
    //  10 a dificuldade em sí, como o número de meteoros
    //  1  o level em que se encontra o jogador
    //  6  o número de prédios ainda não destruidos completamente
int[] difficulty = {10, 1, 6};



// Setup inicial
void setup() {
  size(900, 900);
  background(0);
  fundo = loadImage("fundo.png");
  // Define já a criação do jogo com o level 1 
  level = new Level(difficulty[0], difficulty[1]);
  // Cria um jogador
  commander = new Commander();
  // Começa o jogo (level 1);
  level.startLevel();
}

// Jogo em loop
void draw() {
  background(0);
  
  // Chama a função que atualiza todas as informações gerais do jogo
  gameUpdate();

  
  image(fundo,0,0);
}

//  Atualiza todas as informações gerais do jogo
void gameUpdate() {

  //  ATUALIZA O LEVEL ATUAL 
  level.update();
  
  //  CHAMA A FUNÇÃO QUE CHECA SE O LEVEL ATUAL FOI VENCIDO
  int[] check = level.levelWon();
  
  //  CARREGA NOVAS INFORAÇÕES PARA UM NOVO LEVEL CASO O LEVEL TENHA SIDO VENCIDO
  if (check[0] >= difficulty[0]) {
    
    difficulty[0] += 3;
    difficulty[1]++;
    difficulty[2] = check[2];
    commander.points += difficulty[2] * 30;
    //  CRIA E INICIA UM NOVO LEVEL
    level = new Level(difficulty[0], difficulty[1]);
    level.startLevel();
  }
  
  //  CHAMA A FUNÇÃO QUE CHECA SE O JOGADOR ATINGIU ALGUMA CONDIÇÃO DE DERROTA
  gameOver();
}

  //  CHECA SE O JOGADOR ATINGIU ALGUMA CONDIÇÃO DE DERROTA
void gameOver(){
  if(GAMEOVER){
    textAlign(CENTER,CENTER);
    fill(255);
    textSize(100);
    text("GAME OVER",width/2,height/2);
    noLoop();
  }
}
