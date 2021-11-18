public class Missiles extends Entity {
  private int red, green, blue;
  private double accelerationX;
  private double accelerationY;
  private float angle;
  private Entity shooter;

  private SpaceShip spaceship;
  private Alien alien;



  public Missiles(int x, int y, int red, int green, int blue, float angle, Entity shooter) {
    super(x, y);
    corners = 4;
    this.red = red;
    this.green = green;
    this.blue = blue;
    initSprite();
    this.angle = angle;
    this.shooter = shooter;
    rotate(angle);
    visible = true;
    if (shooter instanceof SpaceShip) {
      spaceship = (SpaceShip) shooter;
      accelerationX = spaceship.getAccelerationX();
      accelerationY = spaceship.getAccelerationY();
    } else if (shooter instanceof Alien) {
      alien = (Alien) shooter;
      shape.setFill(color(255,102, 102));
      
    }
    shape.setStroke(color(0,0,0));
  } 


  public void move() {
    shape.resetMatrix();
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector vector = shape.getVertex(i);

      vector.x += (Math.cos(angle) * 2.5);
      vector.y += (Math.sin(angle) * 2.5);
      shape.setVertex(i, vector);
    }
    rotate(angle); 
    updateLists();
  }


  public void display() {
    pushMatrix();
    shape(shape);
    popMatrix();
  }

  private void updateLists() {
    if (centerX > width || centerX < 0 || centerY > height || centerY < 0)
      visible = false;
    if (spaceship != null) {
      for (int i = 0; i < entities.size(); i++) {
        if(entities.get(i) instanceof Alien){
          Alien alien = (Alien) entities.get(i);
          if(dist(alien.getCenterX(), alien.getCenterY(), centerX, centerY) < utils.getWidth(alien.getShape())
          && dist(alien.getCenterX(), alien.getCenterY(), centerX, centerY) < utils.getHeight(alien.getShape())){
            if(visible){
              alien.kill();
              visible = false;
              ship.setScore(ship.getScore() + 250);
            }
          }else System.out.println("MISS");  
        }
        if (entities.get(i) instanceof Asteroid) {
          Asteroid asteroid = (Asteroid) entities.get(i);
          if (dist(asteroid.getCenterX(), asteroid.getCenterY(), centerX, centerY) < utils.getWidth(asteroid.getShape())
            && dist(asteroid.getCenterX(), asteroid.getCenterY(), centerX, centerY) < utils.getHeight(asteroid.getShape())) {
            if (!visible)
              return;
            visible = false;
            asteroid.setVisible(false);
            if (!asteroid.isShard()) {
              entities.add(new Asteroid((int) (asteroid.getCenterX() + Math.random() * 10), (int)( asteroid.getCenterY()+ Math.random() * 10), true));
              entities.add(new Asteroid((int) (asteroid.getCenterX() + Math.random() * 10), (int)( asteroid.getCenterY()+ Math.random() * 10), true));
              if (ship != null) spaceship.setScore(spaceship.getScore() + 100);
              return;
            } else if (ship != null) ship.setScore(ship.getScore() + 50);
          }
        }
      }
    }

    if (alien != null) {
     
      if (dist(ship.getCenterX(), ship.getCenterY(), centerX, centerY) < 10) {
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
    buildShape(red, green, blue);
    shape.setFill(color(255,255,255));
  }
  /*
  SETTERS
   */
  public void setAngle(float angle) {
    this.angle = angle;
  }
}
