public SpaceShip ship;


public ArrayList<Entity> entities;

public int highscore;
public static int time = 0;

private Sector sector;

public void setup() {
  highscore = 0;
  size(400, 400);
  ship = new SpaceShip(width/2, height/2);
  entities = new ArrayList();
  sector = new Sector();
}


public void draw() {
  sector.updateBackGround();
  spawnEnemies();
  updateShapes();
  update();
  
}


private void updateShip() {
  if (ship.isVisible()) {
    if (ship.onCooldown()) {
      ship.incrementCooldown(1);
      if (ship.getCooldown() > 5) {
        ship.setOnCooldown(false);
        ship.setCooldown(0);
      }
    }
    if (!ship.canJump() && !ship.isJumping()) {
      ship.setJumpCooldown(ship.getJumpCooldown() + 1);
      if (ship.getJumpCooldown() > 100) {
        ship.setCanJump(true);
        ship.setJumpCooldown(0);
      }
    }
    if(ship.isJumping()){
      ship.incrementTextTime(1);
      if(ship.getTextTime() > 100){
        ship.setJumping(false);
        ship.incrementTextTime(-100);
        ship.teleport((int) (Math.random() * 100 + width/4), (int) (Math.random() * 100 + height / 4));
        sector = new Sector();
      }else{
        entities.clear();
        ship.talk();
      }
    }

    update();
    ship.drift();
    text("Score: " + ship.getScore(), 40, 50);
    text("Highscore: " + highscore, 40, 30);
    text("Sector: " + sector.getTitle(), 40, 20);
  } else {
    if(ship.getScore() > highscore)
      highscore = ship.getScore();
    text("Ship Destroyed!", width/2 - 50, height/2);
    text("Final Score: " + ship.getScore(), width/2 - 50, height/2 - 100);
    text("Highscore: " + highscore, width/2 - 50, height/2 - 120);
    entities.clear();
    time = 0;
    return;
  }
}


public void updateShapes() {

  updateShip();
  //loops through all game entities (excluding ship entity)
  for (int i = 0; i < entities.size(); i++) {
    //missiles
    Entity e = entities.get(i);
    if (e instanceof Missiles) {
      Missiles missile = (Missiles) e;
      if (missile.isVisible()) {
        missile.drift();
      } else entities.remove(i);
    }
    //asteroids
    if (e instanceof Asteroid) {
      Asteroid asteroid = (Asteroid) e;
      if (asteroid.isVisible()) {
        asteroid.updateAngle();
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
        alien.fire();
      } else entities.remove(i);
    }
  }
}


private int getAsteroids() {
  int asteroids = 0;
  for (Entity entity : entities) {
    if (entity instanceof Asteroid)
      asteroids++;
  }
  return asteroids;
}
private int getAliens() {
  int aliens = 0;
  for (Entity entity : entities) {
    if (entity instanceof Alien)
      aliens++;
  }
  return aliens;
}
public void spawnEnemies() {
  if(ship.isJumping())
    return;
  
  int aliens = getAliens();
  int asteroids = getAsteroids();
  if (aliens < 1 && sector.getMaxAsteroids() < 30) {
    if (time % 200 == 0  && time != 0) {
      int corner = (int) (Math.random() * 4) + 1;
      int bx = 100;
      int by = 100;
      switch(corner) {
      case 1:
        entities.add(new Alien((int) (bx), (int) (by)));
        break;
      case 2:
        bx = 400;
        entities.add(new Alien((int) (bx), (int) (by)));
        break;
      case 3:
        by = 400;
        Alien alien = new Alien((int) (bx), (int) (by));
        entities.add(alien);

        break;
      case 4:
        bx = 400;
        by = 400;
        entities.add(new Alien((int) (bx), (int) (by)));
        break;
      }
    }
    time++;
  }

  if (asteroids < sector.getMaxAsteroids()) {
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
    float rx =(int) Math.random() * 20;
    float ry =(int) Math.random() * 20;
    entities.add(new Asteroid((int) (rx + bx), (int) (ry + by), false));
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
      sector = new Sector();
 
      break;
    }
    break;
  case 72:
    if (ship.isVisible()) {
      if (ship.canJump()) {
        ship.setJumping(true);
        ship.setCanJump(false);
        ship.message = ship.getRandomMessage();
        entities = new ArrayList();
        
      }
    }
    break;
  }
}
