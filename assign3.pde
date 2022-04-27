final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = GAME_START;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage skyImg, lifeImg, soldierImg, cabbageImg;
PImage soil0, soil1, soil2, soil3, soil4, soil5, stone1, stone2;
PImage groundhogImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;
PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;

int x=0, y=0;//stone's position
int soldierX, soldierY;//soldier's position
int soldierSize;
int soldierSpeed;
float groundhogX;//groundhog's position
float groundhogY;
int groundhogSize;
final int soilSize = 80;//to remove the offset
int cabbageX;//cabbage's position
int cabbageY;
int cabbageSize;

int hogState;//groundhog change position
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
final int HOG_IDLE=1;
final int HOG_DOWN=2;
final int HOG_LEFT=3;
final int HOG_RIGHT=4;
float t;//groundhog move timer
float moveY=0;//roll the soil

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	
	soil8x24 = loadImage("img/soil8x24.png");
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
	
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX && START_BUTTON_X < mouseX && START_BUTTON_Y + START_BUTTON_H > mouseY && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

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
    
        //stone 9-16
        pushMatrix();
        translate(0, 160+soilSize*8

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX && START_BUTTON_X < mouseX && START_BUTTON_Y + START_BUTTON_H > mouseY && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
				
			}
			}else{

				image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

			}
			break;
		
		}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
	y=y+1;
	if ( y > 480)	y = -80;
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
