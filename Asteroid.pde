public class Asteroid extends Entity {
  private float accelerationX;
  private float accelerationY;

  private double moveAngle;
  private double spinAngle;

  private boolean isShard;



  public Asteroid(int x, int y) {
    super(x, y);
   
    initAsteroid();
    visible = true;
    spinAngle = 0;
    moveAngle = (double) (Math.random() * 360);
    accelerationX += Math.cos(moveAngle) * 0.5;
    accelerationY += Math.sin(moveAngle) * 0.5;
  }
  public Asteroid(int x, int y, boolean isShard) {
    super(x, y);
    this.isShard = isShard;
    initAsteroid();
    visible = true;
    spinAngle = 0;
    moveAngle = (double) (Math.random() * 360);
    accelerationX += Math.cos(moveAngle) * 0.5;
    accelerationY += Math.sin(moveAngle) * 0.5;
  }








  //displays the shape
  public void display() {
    pushMatrix();
    shape(shape);
    popMatrix();
  }

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
    spinAngle += 0.01;
    rotate((float) spinAngle );
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
    buildShape();
    shape.setFill(false);
    shape.setStroke(color(255, 255, 255));
  
    
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
  private void shar3() {
    xCorners = new int[6];
    yCorners = new int[6];
  }
}
