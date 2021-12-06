public class Missiles extends Entity {

  private Entity shooter;

  private SpaceShip spaceship;
  private Alien alien;



  public Missiles(int x, int y, float angle, Entity shooter) {
    super(x, y);
    corners = 4;
    initSprite();
    this.angle = angle;
    this.shooter = shooter;
    this.angle = angle;
    visible = true;

    if (shooter instanceof SpaceShip) {
      spaceship = (SpaceShip) shooter;
      accelerationX = (float) ( Math.cos(angle) * 2.5);
      accelerationY = (float) ( Math.sin(angle) * 2.5);
    }
    if (shooter instanceof Alien) {
      alien = (Alien) shooter;
      accelerationX = (float) ( Math.cos(angle) * 2.5);
      accelerationY = (float) ( Math.sin(angle) * 2.5);
      r = 255;
      g = 100;
      b = 100;
    }
    noFill = false;
  } 

  public void move() {
    if (x > width || x < 0 || y < 0 ||y > height ) {
      visible = false;
    }
    updateLists();
    if (visible) {
      x += accelerationX;
      y += accelerationY;
    }
  }


  private void updateLists() {
    if (x > width || y < 0 || y > height || x < 0)
      visible = false;
    if (spaceship != null) {
      for (int i = 0; i < entities.size(); i++) {
        if (entities.get(i) instanceof Alien) {
          Alien alien = (Alien) entities.get(i);
          if (colliding(alien, this)) {
            if (visible) {
              alien.kill();
              visible = false;
              ship.setScore(ship.getScore() + 250);
            }
          }
        }
        if (entities.get(i) instanceof Asteroid) {
          Asteroid asteroid = (Asteroid) entities.get(i);
          if (colliding(asteroid, this)) {
            if (!visible)
              return;
            visible = false;
            asteroid.setVisible(false);
            if (!asteroid.isShard()) {
              entities.add(new Asteroid((int) (asteroid.getX() + Math.random() * 10), (int)( asteroid.getY()+ Math.random() * 10), true));
              entities.add(new Asteroid((int) (asteroid.getX() + Math.random() * 10), (int)( asteroid.getY()+ Math.random() * 10), true));
              if (ship != null) spaceship.setScore(spaceship.getScore() + 100);
              return;
            } else if (ship != null) ship.setScore(ship.getScore() + 50);
          }
        }
      }
    }

    if (alien != null) {

      if (dist(ship.getX(), ship.getY(), x, y) < 10) {
        ship.setVisible(false);
      }
    }
  }

  /**
   BACKEND STUFF
   **/
  private void initSprite() {
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -5;
    yCorners[0] = 2;
    xCorners[1] = 5;
    yCorners[1] = 2;
    xCorners[2] = 5;
    yCorners[2] = -2;
    xCorners[3] = -5;
    yCorners[3] = -2;
  }
  /*
  SETTERS
   */
  public void setAngle(float angle) {
    this.angle = angle;
  }
}
