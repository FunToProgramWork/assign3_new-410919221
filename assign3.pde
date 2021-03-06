PImage skyImg, lifeImg, soldierImg, cabbageImg;
PImage soil0, soil1, soil2, soil3, soil4, soil5, stone1, stone2;
PImage groundhogImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;
PImage titleImg, gameoverImg, startNormalImg, startHoveredImg, restartNormalImg, restartHoveredImg;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

//detect button's position, change picture
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;
//stone's position
int x=0, y=0;
//soldier's position
int soldierX, soldierY;
int soldierSize;
int soldierSpeed;
//groundhog's position
float groundhogX;
float groundhogY;
int groundhogSize;
//to remove the offset
final int soilSize = 80;
//cabbage's position
int cabbageX;
int cabbageY;
int cabbageSize;
//groundhog change position
int hogState;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
final int HOG_IDLE=1;
final int HOG_DOWN=2;
final int HOG_LEFT=3;
final int HOG_RIGHT=4;
//groundhog move timer
float t;
//roll the soil
float moveY=0;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  frameRate (60);

  //load the pictures
  skyImg = loadImage("img/bg.jpg");
  lifeImg = loadImage("img/life.png");
  //soil area
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");

  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  groundhogImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  titleImg = loadImage("img/title.jpg");
  startNormalImg = loadImage("img/startNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
  gameoverImg = loadImage("img/gameover.jpg");

  //lifeCount
  playerHealth = 2;

  //soldier
  soldierX = -160;
  soldierY = 80*floor(random(2, 6));
  soldierSize = 80;
  soldierSpeed = 3;//soldier

  //groundhog
  groundhogX=320.0;
  groundhogY=80.0;
  groundhogSize=80;
  t=0.0;//groundhog change position
  hogState = HOG_IDLE;

  //cabbage
  cabbageX = 80*floor(random(0, 8));
  cabbageY = 80*floor(random(2, 6));
  cabbageSize=80;
}

void draw() {
  switch(gameState) {
  case GAME_START:
    image(titleImg, 0, 0);//start picture
    hogState=HOG_IDLE;
    t=0.0;
    downPressed=false;
    leftPressed=false;
    rightPressed=false;
    //detect button position
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(startHoveredImg, BUTTON_LEFT, BUTTON_TOP);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    } else {
      image(startNormalImg, BUTTON_LEFT, BUTTON_TOP);
    }
    break;

  case GAME_RUN:
    //background
    image(skyImg, 0, 0);//sky
    fill(253, 184, 19);//sun
    strokeWeight(5);
    stroke(255, 255, 0);
    ellipse(590, 50, 120, 120);
    
    /* ------ Debug Function ------
    Please DO NOT edit the code here.
    It's for reviewing other requirements when you fail to complete the camera moving requirement.
    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */
    
    if(moveY > -1600){
      moveY=soilSize-groundhogY;//a changing number(since the groundhogY is changing)
    }
    pushMatrix();
    translate(0,moveY);
        //soil
        for (int i=0; i<width; i+=soilSize) {
          for (int n=160; n<160+soilSize*4; n+=soilSize) {
            image(soil0, i, n);
          }
          for (int n=480; n<480+soilSize*4; n+=soilSize) {
            image(soil1, i, n);
          }
          for (int n=800; n<800+soilSize*4; n+=soilSize) {
            image(soil2, i, n);
          }
          for (int n=1120; n<1120+soilSize*4; n+=soilSize) {
            image(soil3, i, n);
          }
          for (int n=1440; n<1440+soilSize*4; n+=soilSize) {
            image(soil4, i, n);
          }
          for (int n=1760; n<1760+soilSize*4; n+=soilSize) {
            image(soil5, i, n);
          }
        }
    
        //stone 1-8
        pushMatrix();
        translate(0, 160);
        y=0;
        x = soilSize;
        y=0;
        for (int i=0; i<8; i++) {
          x = i*soilSize;
          image(stone1, x, y);
          y += soilSize;
        }
        popMatrix();
