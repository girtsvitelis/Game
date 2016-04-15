float BallR = 7; // Ball radius
float BounceH = 75; // Bounce height
float BounceS = 20; // Bounce stride
float TileS = 20; // Tile size
float heightH = 70; // Camera height
int[][] tiles;
boolean [][] gotbonus;
color[] palette; // tile colours
float xp, yp; // x and y positions
int score;
int lives;
boolean gameover = false;
boolean showFlash = false;
int ForFrames = 10;
int flashCounter;

void setup
{
  size (512, 512, P3D);
  reset();
  palette = new color[]
  {
    color(0), //black - avoid
    color(255), //white - normal tile
  };
}

void reset()
{
  //reset game
  
  tiles = new int[1000][6];
  gotbonus = new boolean[1000][6];
  for (int row = 0; row < 1000; row ++)
  {
    for (int col = 0; col < 6; col ++)
    {
      tiles[row][col] = 1;
      if (row > 20 && random (0, 10)>8) tiles[row][col] = 0;
      if (row > 30 && random (0, 100)>95) tiles[row][col] = 2;
      if (row > 30 && random (0, 100)>98) tiles[row][col] = 3;
      if (row > 60 && random (0, 100)>99) tiles[row][col] = 4;
    }
  }
  
  score = 0;
  lives = 5;
  gameover = false;
  frameCount = 0;
}
      
}

void mouseClicked()
{
  if (gameover) reset();

void draw
{
  int ypos = (frameCount % 20000);
  
  camera (0, ypos, heightH, 0, (ypos + 400), 0, 0, -1,0);
  ambientLight (210, 220, 200);
  directionalLight (204, 204, 204, -.7, 1, 1.2);
  lightFalloff (1, 0, 0); 
  
  if (showFlash)
  {
    float flashamt = float(flashCounter) / float(ForFrames);
    background (lerpColor(color(255, 50, 0), color(0), flashamt));
    flashCounter ++;
    if (flashCounter == 0)
    {
      showFlash = false;
    }
  }
  
  else
  {
    background(0);
  }
  
  // Ball position
  float xx = 60 - mouseX / 4.25; //left-right
  float yy = ypos + 60 + ((512 - mouseY) / 5); //front-back
  float zz = BallR / 2 + (BounceH * (float)Math.abs(Math.sin(frameCount/BounceS))); // up-down
  
  
  // Draw tiles
  
  for (int col = 0; col < 6; col ++)
  {
    int x =-- 60 + (20 * col);
    for (int row = 0; row < 1000; row ++)
    {
      int y = 20 * row;
      if ( y > ypos && y < ypos + 500 && tiles[row][col] > 0)
      {
        fill (palette[tiles][row][col]], 255 - ((y -ypos) / 2));
        rect (x, y, 20, 20);
      }
    }
  }
  
  fill (127);
  
  // Draw ball and shadow
  
  if (!gameover)
  {
    // Ball shadow
    ellipse(xx, yy, 20, 20);
    // Draw player 
    pushMatrix();
    translate(xx, yy, zz);
    rotateX(- frameCount / 20); // Ball roll
    sphereDetail(8);
    fill(190, 56, 78);
    sphere(BallR);
    popMatrix();
  }
  
  // Draw score and combo
  
  pushMatrix();
  translate180,ypos + 400 , 0);
  rotateZ(PI);
  rotateX(PI * 3 / 2.2);
  text("SCORE", 0, - 20);
  text(score+ "",0 , 0);
  if (combo > 1)
  {
    text((int)combo+ "X COMBO", 0, - 40);
  }
  popMatrix();
  
  // Draw lives
  
  pushMatrix();
  translate(-120, ypos + 400, 0);
  rotateZ(PI);
  rotateX((PI * 3 / 2.2);
  text("LIVES", 0, - 20);
  text(lives+"", 0, 0);
  popMatrix();
  
  // Check for collisions
  
  if (zz <= BallR && !gameover) groundCheck(xx,yy);
  
  // Gameover
  
  if (gameover)
  {
    pushMatrix();
    translate(120, ypos+400, 80);
    rotateZ(PI);
    rotateX((PI * 3 / 2.2));
    text("GAME OVER", 0, 0);
    popMatrix();
  }
  
}

void groundCheck(float xx, float yy)
{
  // Called when ball is on ground
  
  if (BounceH > 0) BounceH = 70; // Reset bounce if not rolling
  
  // Tile position underneath
  
  int row = (int)(yy / 20);
  int col = (int)((xx + 60) / 20);
  
  int tiletype = 0;
  if (col < 0 || col > = 6)
  {
    tiletype = 0;
  }
  
  else
  {
    tiletype = tiles[row][col];
    if (!gotbonus[row][col]))
    {
      gotbonus[row][col]=true; // Don't count more than once
      switch (tiletype)
      {
        case 0:
          // Fell down a hole
          lives--;
          if (lives==0) gameover = true;
          combo = 1.0; // Combo breaker
          showFalsh = true;
          flashCounter = ForFrames;
          break;
        case 1:
          // Hit normal tile
          score += 10;
          combo = 1;
          break;
        case 2:
          // Hit gold tile
          score += 50 * combo;
          tiles[row][col] = 1;
          if (BounceH > 0) combo *= 2;
          break;
        case 3:
          // Double bounce
          BounceH = 120;
          score += 50*combo;
          tiles[row][col] = 1;
          if (BounceH > 0) combo *= 2;
          break;
        case 4:
          // Set to roll
          BounceH = 0;
          combo = 1;
          break;
         default;
          break;
      }
    }
  }
}  
  
  
  
}
