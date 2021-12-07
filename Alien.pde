public class Alien extends Entity {
  private int[] aCornersX;
  private int[] aCornersY;

  private boolean dead;
  private long shotcooldown;
  private boolean shoot;

  private int deadTime;

  private float dx;
  private float dy;



  public Alien(int x, int y) {
    super(x, y);
    visible = true;
    noFill = true;
    shoot = false;
    initAlien();
    setTarget();
  }



  //sets the destination or base acceleration value for the given Alien
  private void setTarget() {
    accelerationX = (float) Math.cos(360) * 1;
    accelerationY = (float) Math.sin(350) * 1;
    if (x >= 500)
      accelerationX *= -1;
  }

  //updates coordinates of PShape objects
  public void drift() {
    drawShape();
    float inx = dead ? dx : x;
    float iny = dead ? dy : y;
    drawAddon(aCornersX, aCornersY, inx, iny);
    shoot();
  }
  
  //adds acceleration values to the alien
  public void move() {
    if (x > width) {
      accelerationX *= -1;
     
    } else if (x < 0) {
      accelerationX *= -1;
      
    }
    if (y > height) {
      accelerationY *= -1;
    
    } else if ( y < 0) {
      accelerationY *= -1;
 
    }
    if (dead)
      return;
    x += accelerationX;
    y += accelerationY;
  }

  //shoots alien missiles
  private void shoot() {
    if (dead)
      return;
    if (!shoot) {
      shotcooldown += 1;
      if (shotcooldown > 60) {
        shoot = true;
        shotcooldown = 0;
      }
      return;
    }
    float ex = ship.getX() - x;
    float ey = ship.getY() - y;
    float angle = (float) Math.atan2(ey, ex);
    entities.add(new Missiles((int)x, (int)y, angle, this));
    shoot = false;
  }

  //drift values for broken ufo
  private float dAccelerationX;
  private float dAccelerationY;

  //begins death animation for alien
  public void kill() {
    dead = true;
    dx = x;
    dy = y;
    dAccelerationX = (float) Math.cos(Math.random() * 360) * 1.5;
    dAccelerationY = (float) Math.sin(Math.random() * 360) * 1.5;
    accelerationX = (float) Math.cos(Math.random() * 360) * 1.5;
    accelerationY = (float) Math.sin(Math.random() * 360) * 1.5;
  }

  //moves broken ufo shapes
  public void deadMove() {
    x += accelerationX;
    y += accelerationY;
    dx += dAccelerationX;
    dy += dAccelerationY;
  }







  //initializes alien 
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
  }


  //getters and setters for alien shoot cooldown
  public long getCooldown() {
    return shotcooldown;
  }
  public void setCooldown(long cd) {
    shotcooldown = cd;
  }
  public void incrementCooldown(int increment) {
    shotcooldown += increment;
  }
  public boolean canShoot() {
    return shoot;
  }
  public void setCanShoot(boolean cd) {
    this.shoot = cd;
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

  //displays alien
  public void display() {
    pushMatrix();
    fill(0,0,0,0.0);
    stroke(255);
    drawShape();
    beginShape();
    for (int i = 0; i < aCornersX.length; i++) {

      int tx = aCornersX[i];
      int ty = aCornersY[i];
      vertex(tx + dx, ty + dy);
    }
    endShape();
    popMatrix();
  }
}
