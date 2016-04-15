float BallR = 7; // Ball radius
float BounceH = 75; // Bounce height
float BounceS = 20; // Bounce stride
float TileS = 20; // Tile size
float heightH = 70; // Camera height
int[][] tiles;
boolean [][] gotbonus;
color[] palette; // tile colours
float xpos, ypos; // x and y positions
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
  lightFalloff(1, 0, 0); 
}
