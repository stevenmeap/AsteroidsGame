public SpaceShip ship;


//public ArrayList<Entity> entities;
public static int time = 0;
public static int wide;
public static int tall;

private Sector sector;

void setup() {
  size(400, 400, P2D);
 // ship = new SpaceShip(width/2, height/2);
 // entities = new ArrayList();
 // entities.add(new Asteroid(300, 300));
  sector = new Sector();

  tall = height;
  wide = width;
}


void draw() {
  sector.updateBackGround();
  //if (ship.isVisible()) {
 //   time++;
  //}
  //updateShapes();
 // update();
 // spawnEnemies();
}


