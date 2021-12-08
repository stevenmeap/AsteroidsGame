public class SpaceShip extends Entity {

  //rotation


  
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
  }




  private void checkColliding() {
    for (Entity entity : entities) {
      if(!(entity instanceof Asteroid))
      continue;
      Asteroid asteroid = (Asteroid) entity;
      if (colliding(asteroid, this)) {
        visible = false;
        asteroid.setVisible(false);
        return;
      }
    }
  }



  //fires a missile class, called in Main class
  public void shoot() {
    if (cd)
      return;
    cd = true;
    entities.add(new Missiles((int)x, (int)y, angle, this));
  }

  //updates acceleration values, called  in Main class
  public void move(int dir) {
    checkColliding();
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
  public void teleport(int x, int y){
    this.x = x;
    this.y = y;
    accelerationX = 0;
    accelerationY = 0;
    angle = 0;
  }

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
   // buildShape();
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

  //getters for ship acceleration
  public float getAccelerationX() {
    return accelerationX;
  }
  public float getAccelerationY() {
    return accelerationY;
  }
  
  //getters and setters for missile cooldown
  public long getCooldown(){
    return cooldown;
  }
  public void setCooldown(long cd){
    cooldown = cd;
  }
  public void incrementCooldown(int increment){
    cooldown += increment;
  }
  public boolean onCooldown(){
    return cd;
  }
  public void setOnCooldown(boolean cd){
    this.cd = cd;
  }
  
  //getters and setters for ship score
  public int getScore(){
    return score;
  }
  public void setScore(int score){
    this.score = score;
  }
  
  //getters and setters for hyperspace cooldown values
  public boolean canJump(){
    return jump;
  }
  public long getJumpCooldown(){
    return jumpcooldown;
  }
  public void setCanJump(boolean jump){
    this.jump = jump;
  }
  public void setJumpCooldown(long cd){
    jumpcooldown = cd;
  }

  //displays the shape

}
