public class Asteroid extends Entity {


  private double moveAngle; //determines trajectory of asteroid


  private boolean isShard;



  public Asteroid(int x, int y) {
    super(x, y);
    initAsteroid();
    visible = true;
    noFill = true;
    moveAngle = (int) (Math.random()*100) < 50 ? (double) (Math.random() * 360): (double) -(Math.random() * 360);
    accelerationX += Math.cos(moveAngle) * 0.5;
    accelerationY += Math.sin(moveAngle) * 0.5;
  }
  public Asteroid(int x, int y, boolean isShard) {
    super(x, y);
    this.isShard = isShard;
    initAsteroid();
    noFill = true;
    visible = true;
    moveAngle = (double) (Math.random() * 360);
    accelerationX += Math.cos(moveAngle) * 0.5;
    accelerationY += Math.sin(moveAngle) * 0.5;
  }

  public void updateAngle() {
    angle -= 0.01;
  }

  //Initializes Asteroid PShape object
  private void initAsteroid() {
    int shapeCase = (int) (Math.random() * 3) + 1;
    switch (shapeCase) {
    case 1:
      if (isShard) {
        shard1();
      } else setCorners1();

      break;
    case 2:
      if (isShard) {
        shard2();
      } else setCorners2();
      break;
    case 3:
      if (isShard) {
        shard1();
      } else setCorners3();

      break;
    }
  }



  //Getters
  public boolean isShard() {
    return this.isShard;
  }

  public void setShard(boolean isShard) {
    this.isShard = isShard;
  }





  //Asteroid models
  private void setCorners1() {
    xCorners = new int[8];
    yCorners = new int[8];

    xCorners[0] = -15+(int) (Math.random() * 10);
    yCorners[0] = -12 +(int) (Math.random() * 10);

    xCorners[1] = -3+(int) (Math.random() * 10) ;
    yCorners[1] = -15+(int) (Math.random() * 10);

    xCorners[2] = 12+(int) (Math.random() * 10);
    yCorners[2] = -12+(int) (Math.random() * 10);

    xCorners[3] = 15+(int) (Math.random() * 10);
    yCorners[3] = -3+(int) (Math.random() * 10);

    xCorners[4] = 18+(int) (Math.random() * 10);
    yCorners[4] = 3 +(int) (Math.random() * 10);

    xCorners[5] = 3 +(int) (Math.random() * 10);
    yCorners[5] = 6 +(int) (Math.random() * 10);

    xCorners[6] = -15+(int) (Math.random() * 10);
    yCorners[6] = 9+(int) (Math.random() * 10);

    xCorners[7] = -21+(int) (Math.random() * 10);
    yCorners[7] = 0 +(int) (Math.random() * 10);
  }
  //+(int) (Math.random() * 20) - 10;
  private void setCorners2() {
    xCorners = new int[6];
    yCorners = new int[6];

    xCorners[0] = -10;
    yCorners[0] = -15;

    xCorners[1] = 15;
    yCorners[1] = -6;

    xCorners[2] = 0;
    yCorners[2] = 0;

    xCorners[3] = 6;
    yCorners[3] = 7;

    xCorners[4] = -10;
    yCorners[4] = 8;

    xCorners[5] = -8;
    yCorners[5] = 0;
  }
  private void setCorners3() {
    xCorners = new int[6];
    yCorners = new int[6];

    xCorners[0] = -11;
    yCorners[0] = -8;

    xCorners[1] = 7;
    yCorners[1] = -8;

    xCorners[2] = 13;
    yCorners[2] = 0;

    xCorners[3] = 6;
    yCorners[3] = 10;

    xCorners[4] = -11;
    yCorners[4] = 8;

    xCorners[5] = -5;
    yCorners[5] = 0;
  }

  private void shard1() {
    xCorners = new int[5];
    yCorners = new int[5];

    xCorners[0] = -2;
    yCorners[0] = -8;

    xCorners[1] = 6;
    yCorners[1] = -4;

    xCorners[2] = 4;
    yCorners[2] = 2;

    xCorners[3] = -4;
    yCorners[3] = 2;

    xCorners[4] = -8;
    yCorners[4] = 0;
  }
  private void shard2() {
    xCorners = new int[5];
    yCorners = new int[5];

    xCorners[0] = -4;
    yCorners[0] = -6;

    xCorners[1] = 6;
    yCorners[1] = -8;

    xCorners[2] = 8;
    yCorners[2] = 0;

    xCorners[3] = 4;
    yCorners[3] = 4;

    xCorners[4] = -6;
    yCorners[4] = 0;
  }
}
