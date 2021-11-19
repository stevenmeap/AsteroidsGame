public SpaceShip ship;


public ArrayList<Entity> entities;
public static int time = 0;
public static int wide;
public static int tall;

private Sector sector;

void setup() {
  size(400, 400, P2D);
 // ship = new SpaceShip(width/2, height/2);
  entities = new ArrayList();
 // entities.add(new Asteroid(300, 300));
  sector = new Sector();

  tall = height;
  wide = width;
}


void draw() {
  sector.updateBackGround();
  if (ship.isVisible()) {
    time++;
  }
  updateShapes();
  update();
  spawnEnemies();
}



public void updateShapes() {
  if (ship.isVisible()) {
    if (ship.onCooldown()) {
      ship.incrementCooldown(1);
      if (ship.getCooldown() > 5) {
        ship.setOnCooldown(false);
        ship.setCooldown(0);
      }
      if (!ship.canJump()) {
        ship.setJumpCooldown(ship.getJumpCooldown() + 1);
        if (ship.getJumpCooldown() > 30)
          ship.setCanJump(true);
      }
    }
    ship.display();
    ship.drift();
    text("Score: " + ship.getScore(), 40, 50);
    text("Sector: " + sector.getName(), 40, 20);
  } else {
    text("Ship Destroyed!", width/2 - 50, height/2);
    text("Final Score: " + ship.getScore(), width/2 - 50, height/2 - 100);
    entities.clear();
    time = 0;
    return;
  }

  //loops through all game entities (excluding ship entity)
  for (int i = 0; i < entities.size(); i++) {
    //missiles
    Entity e = entities.get(i);
    if (e instanceof Missiles) {
      Missiles missile = (Missiles) e;
      if (missile.isVisible()) {
        missile.display();
        missile.move();
      } else entities.remove(i);
    }
    //asteroids
    if (e instanceof Asteroid) {
      Asteroid asteroid = (Asteroid) e;
      if (asteroid.isVisible()) {
        asteroid.display();
        asteroid.drift();
      } else entities.remove(i);
    }
    //aliens
    if (e instanceof Alien) {
      Alien alien = (Alien) e;
      if (alien.isDead()) {
        alien.deadMove();
        alien.setDeadTime(alien.getDeathTime() + 1);
        if (alien.getDeathTime() > 60)
          alien.setVisible(false);
      }
      if (alien.isVisible()) {
        alien.display();
        alien.drift();
      } else entities.remove(i);
    }
  }
}

private int getAsteroids() {
  int asteroids = 0;
  for (int i = 0; i < entities.size(); i++) {
    if (entities.get(i) instanceof Asteroid)
      asteroids++;
  }
  return asteroids;
}
private int getAliens() {
  int aliens = 0;
  for (int i = 0; i < entities.size(); i++) {
    if (entities.get(i) instanceof Alien)
      aliens++;
  }
  return aliens;
}
public void spawnEnemies() {
  int aliens = getAliens();
  int asteroids = getAsteroids();
  if (time % 200 == 0  && time != 0 && aliens < 1) {
    int corner = (int) (Math.random() * 4) + 1;
    int bx = 100;
    int by = 100;
    switch(corner) {
    case 1:
      entities.add(new Alien((int) (bx), (int) (by), ship));
      break;
    case 2:
      bx = 400;
      entities.add(new Alien((int) (bx), (int) (by), ship));
      break;
    case 3:
      by = 400;
      Alien alien = new Alien((int) (bx), (int) (by), ship);
      entities.add(alien);

      break;
    case 4:
      bx = 400;
      by = 400;
      entities.add(new Alien((int) (bx), (int) (by), ship));
      break;
    }


    time++;
  }
  if (asteroids < 10) {
    int corner = (int) (Math.random() * 4 + 1);
    int bx = 0;
    int by = 0;
    switch(corner) {
    case 1:
      break;
    case 2:
      bx = 400;
      break;
    case 3:
      by = 400;
      break;
    case 4:
      bx = 400;
      by = 400;
      break;
    }
    float rx =(float) Math.random() * 20;
    float ry =(float) Math.random() * 20;
    entities.add(new Asteroid((int) (rx + bx), (int) (ry + by)));
  }
}

public void update() {
  ship.update(rotCode);
  ship.move(moveNum);
}
int moveNum = -1;
int rotCode = -1;



public void keyReleased() {
  moveNum = -1;
  rotCode = -1;
}
public void keyPressed() {


  switch(keyCode) {
  case 68:
    moveNum = 1;
    break;
  case 65:
    moveNum = 3;
    break;
  case 81:
    rotCode = 81;
    break; 
  case 69:
    rotCode = 69;
    break;
  case 32:
    ship.shoot();
    ship.setOnCooldown(true);
    break;
  case 82:
    if (!ship.isVisible()) {
      ship = new SpaceShip(width/2, height/2);
      entities = new ArrayList();
      entities.add(new Asteroid(300, 300));
      sector = new Sector();
      break;
    }
    break;
  case 72:
    if (ship.isVisible()) {
      if (ship.canJump()) {
        ship.teleport((int) (Math.random() * 100 +100), (int) (Math.random() * 100 + 100));
        ship.setCanJump(false);
        entities = new ArrayList();
        entities.add(new Asteroid(300, 300));
        sector = new Sector();
      }
    }
    break;
  }
}
