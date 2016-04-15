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
  
}

void mouseClicked()
{
  if (gameover) reset();

void draw
{
  int ypos = (frameCount % 20000);
  
  camera(0, ypos, heightH, 0, (ypos + 400), 0, 0, -1,0);
}
