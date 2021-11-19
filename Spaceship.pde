public class SpaceShip extends Entity {

  private float angle; //rotation


  private int score;

  private long cooldown; // time on shooting cooldown
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
    jumpcooldown = 0;
    cooldown = 0;
    cd = false;
    angle = 0.0;
    //shape.setFill(color(255, 255, 255));
   // shape.setStroke(color(0, 0, 0));
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
    constructShape();
  }
}
