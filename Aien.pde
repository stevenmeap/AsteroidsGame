public class Alien extends Entity {
  private PShape addon;


  private float accelerationX;
  private float accelerationY;
  private double moveAngle;

  private int[] aCornersX;
  private int[] aCornersY;

  private SpaceShip target;
  private boolean dead;
  private long cooldown;
  private boolean cd;

  private int deadTime;

  public Alien(int x, int y, SpaceShip target) {
    super(x, y);
    this.target = target;
    visible = true;
    initAlien();
    setTarget();
  }



  //sets the destination or base acceleration value for the given Alien
  private void setTarget() {
    float dx = 300;
    float dy = 300;
    double angle = Math.atan2(dy, dx);
    moveAngle = angle;
    accelerationX = (float) Math.cos(360) * 1.5;
    accelerationY = (float) Math.sin(350) * 1.5;
    if (x >= 500)
      accelerationX *= -1;
  }

  //updates coordinates of PShape objects
  public void drift() {
    move(shape);
    move(addon);
    shoot();
  }

  //updates acceleration values for PShape, reversing direction as needed
  private void updateAcceleration() {
    boolean negX = false;
    boolean negY = false;
    boolean posX = false;
    boolean posY = false;
    for (int i = 0; i < this.shape.getVertexCount(); i++) {
      PVector vector = this.shape.getVertex(i);
      if (vector.x + accelerationX > width) 
        negX = true;
      if (vector.y + accelerationY > height) 
        negY = true;
      if (vector.x + accelerationX < 0) 
        posX = true;
      if (vector.y + accelerationY <0) 
        posY = true;
    }
    if (negX) 
      if (accelerationX > 0)
        accelerationX *= -1;
    if (negY) 
      if (accelerationY > 0)
        accelerationY *= -1;
    if(posX)
      if(accelerationX < 0)
        accelerationX *= -1;
    if(posY)
      if(accelerationY < 0)
        accelerationY *= -1;
  }

  //adds acceleration values to given PShapes updated their locations
  private void move(PShape shape) {
    if (dead)
      return;
    setCenter();
    if (shape != addon)
      updateAcceleration();
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector vector = shape.getVertex(i);
      vector.x += accelerationX;
      vector.y += accelerationY;
      shape.setVertex(i, vector);
    }
  }

//shoots alien missiles
  private void shoot() {
    if (dead)
      return;
    if (cd) {
      cooldown += 1;
      if (cooldown > 60) {
        cd = false;
        cooldown = 0;
      }
      return;
    }
    float dx = ship.getCenterX() - centerX;
    float dy = ship.getCenterY() - centerY;
    float angle = (float) Math.atan2(dy, dx);
    entities.add(new Missiles((int)centerX, (int)centerY, 255, 0, 0, angle, this));
    cd = true;
  }
  
  //drift values for broken ufo
  private float dAccelerationX;
  private float dAccelerationY;
  
  //begins death animation for alien
  public void kill() {
    dead = true;
    dAccelerationX = (float) Math.cos(Math.random() * 360) * 1.5;
    dAccelerationY = (float) Math.sin(Math.random() * 360) * 1.5;
    accelerationX = (float) Math.cos(Math.random() * 360) * 1.5;
    accelerationY = (float) Math.sin(Math.random() * 360) * 1.5;
  }
  
  //moves broken ufo shapes
  public void deadMove() {
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector v = shape.getVertex(i);
      v.x += accelerationX;
      v.y += accelerationY;
      shape.setVertex(i, v);
    }
    for (int i = 0; i < addon.getVertexCount(); i++) {
      PVector v = addon.getVertex(i);
      v.x += dAccelerationX;
      v.y += dAccelerationY;
      addon.setVertex(i, v);
    }
  }







  //initializes alien PShape objects
  private void initAlien() {
    xCorners = new int[10];
    yCorners = new int[10];
    xCorners[0] = -8;
    yCorners[0] = -8;

    xCorners[1] = 8;
    yCorners [1] = -8;

    xCorners[2] = 12;
    yCorners[2] = -4;

    xCorners[3] = 20;
    yCorners[3] = 0;

    xCorners[4] = 16;
    yCorners[4] = 4;

    xCorners[5] = 8;
    yCorners[5] = 8;

    xCorners[6] = -8;
    yCorners[6] = 8;

    xCorners[7] = -16;
    yCorners[7] = 4;

    xCorners[8] = -20;
    yCorners[8] = 0;

    xCorners[9] = -12;
    yCorners[9] = -4;

    buildShape();
    shape.setFill(false);
    shape.setStroke(color(255, 255, 255));
    aCornersX = new int[8];
    aCornersY = new int[8];
    aCornersX[0] = -8;
    aCornersY[0] = -8;

    aCornersX[1] = 8;
    aCornersY[1] = -8;

    aCornersX[2] = 12;
    aCornersY[2] = -4;

    aCornersX[3] = 16;
    aCornersY[3] = 0;

    aCornersX[4] = 8;
    aCornersY[4] = 4;

    aCornersX[5] = -8;
    aCornersY[5] = 4;

    aCornersX[6] = -16;
    aCornersY[6] = 0;

    aCornersX[7] = -12;
    aCornersY[7] = -4;
    addon = constructShape(addon, aCornersX, aCornersY);
    addon.setFill(false);
    addon.setStroke(color(255, 255, 255));
  }


//getters and setters for alien shoot cooldown
  public long getCooldown() {
    return cooldown;
  }
  public void setCooldown(long cd) {
    cooldown = cd;
  }
  public void incrementCooldown(int increment) {
    cooldown += increment;
  }
  public boolean onCooldown() {
    return cd;
  }
  public void setOnCooldown(boolean cd) {
    this.cd = cd;
  }
  
  //getters and setters for alien death animation
  public boolean isDead() {
    return dead;
  }
  public int getDeathTime() {
    return deadTime;
  }
  public void setDeadTime(int deadTime) {
    this.deadTime = deadTime;
  }

  //displays alien PShape objects
  public void display() {
    pushMatrix();
    shape(shape);
    shape(addon);
    popMatrix();
  }
}
