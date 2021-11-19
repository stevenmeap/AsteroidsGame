public class SpaceShip extends Entity {

  private float angle = 0.0; //rotation


  private int score;

  private long cooldown = 0; // time on shooting cooldown
  private boolean cd;

  private boolean jump;
  private long jumpcooldown;

  public SpaceShip(int x, int y) {
    super(x, y);
    corners = 3;
    initShip();
    visible = true;
    score = 0;
    jump = true;
    //shape.setFill(color(255, 255, 255));
   // shape.setStroke(color(0, 0, 0));
  }

  //moves the ship, should be called every draw() call
  /*
  public void drift() {
    shape.resetMatrix();
    boolean setX0 = false;
    boolean setXMax = false;
    boolean setY0 = false;
    boolean setYMax = false;
    int xm = 0;
    int x0 = 0;
    int ym = 0;
    int y0 = 0;
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector vector = shape.getVertex(i);
      if (vector.x + accelerationX > wide)
        x0++;
      if (vector.x + accelerationX < 0)
        xm++;
      if (vector.y + accelerationY > tall)
        y0++;
      if (vector.y + accelerationY < 0)
        ym++;
      if (xm == shape.getVertexCount())
        setXMax = true;
      if (x0 == shape.getVertexCount())
        setX0 = true;
      if (ym == shape.getVertexCount())
        setYMax = true;
      if (y0 == shape.getVertexCount())
        setY0 = true;
    }
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector vector = shape.getVertex(i);
      if (setX0)
        vector.x = 0 + xCorners[i] ;
      else if (setXMax)
        vector.x = wide + xCorners[i] ;
      else vector.x += accelerationX;
      if (setY0)
        vector.y = 0 + yCorners[i];
      else if (setYMax)
        vector.y = tall + yCorners[i];
      else vector.y += accelerationY;
      shape.setVertex(i, vector);
    }
    setCenter();
    rot(angle);
    //checkColliding();
  }
  */

/*
  private void checkColliding() {
    for (int i = 0; i < entities.size(); i++) {
      if (!(entities.get(i) instanceof Asteroid))
        continue;
      Asteroid asteroid = (Asteroid) entities.get(i);
      if (dist(asteroid.getCenterX(), asteroid.getCenterY(), centerX, centerY) < utils.getWidth(asteroid.getShape())
        && dist(asteroid.getCenterX(), asteroid.getCenterY(), centerX, centerY) < utils.getHeight(asteroid.getShape())) {
        visible = false;
        asteroid.setVisible(false);
        return;
      }
    }
  }
  */



  //fires a missile class, called in Main class
  /*
  public void shoot() {
    if (cd)
      return;
    cd = true;
    entities.add(new Missiles((int)centerX, (int) centerY, 0, 255, 0, angle, this));
  }
  */

  //updates acceleration values, called  in Main class
  public void move(int dir) {
    if (dir == 1) {
      accelerationY += Math.sin(angle) * 0.05;
      accelerationX += Math.cos(angle) * 0.05;
    }
    if (dir == 3) {
      accelerationY -= Math.sin(angle) * 0.05;
      accelerationX -= Math.cos(angle) * 0.05;
    }
  }

  //sets ship location to inputed x, y values and resets acceleratiion valuezs
  /*
  public void teleport(int x, int y) {
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector vec = shape.getVertex(i);
      vec.x = x + xCorners[i];
      vec.y = y + yCorners[i];
      accelerationX = 0;
      accelerationY = 0;
      shape.setVertex(i, vec);
    }
  }
  */

  //initializes the ship PShape object
  private void initShip() {
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -15;
    yCorners[0] = 10;
    xCorners[1] = 10;
    yCorners[1] = 0;
    xCorners[2] = -15;
    yCorners[2] = -10;
    buildShape();
  }

  // builds the PShape object

  //updates angle of rotation, called in Main class
  public void update(int key) {
    switch(key) {
    case 69:
      angle += 0.1;
      break;
    case 81:
      angle -= 0.1;
      break;
    }
  }



  //getters and setters for missile cooldown
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

  //getters and setters for ship score
  public int getScore() {
    return score;
  }
  public void setScore(int score) {
    this.score = score;
  }

  //getters and setters for hyperspace cooldown values
  public boolean canJump() {
    return jump;
  }
  public long getJumpCooldown() {
    return jumpcooldown;
  }
  public void setCanJump(boolean jump) {
    this.jump = jump;
  }
  public void setJumpCooldown(long cd) {
    jumpcooldown = cd;
  }
}
