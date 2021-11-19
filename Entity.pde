public class Entity {
  protected PShape shape;

  protected int corners;
  protected int[] xCorners;
  protected int[] yCorners;
  protected int speed;

  protected int x, y;
  protected float centerX, centerY;
  protected float accelerationX, accelerationY;



  protected boolean visible;

  protected ShapeUtils utils;

  public Entity(int x, int y) {
    this.x = x;
    this.y = y;
    utils = new ShapeUtils();
  }


  //rotates the shape to the appropriate angle, called in drift()
  protected void rotate(float angle) {
    setCenter();
    shape.translate(-centerX, -centerY);
    shape.rotate(angle);
    shape.translate(centerX, centerY);
  }


  //updates the center of the shape, used for rotations + shooting center
  protected void setCenter() {
    PVector vec0 = shape.getVertex(0);
    PVector vec1 = shape.getVertex(1);
    PVector vec2 = shape.getVertex(2);
    float dx = (vec0.x + vec2.x)/2;
    float dy = vec1.y;
    float midX = (vec1.x + dx)/2;
    centerX = midX;
    centerY = dy;
  }



  //sets a given PShape
  protected PShape constructShape(PShape shape) {
    shape = createShape();
    shape.beginShape();
    for (int i = 0; i < xCorners.length; i++) {
      int x = xCorners[i];
      int y = yCorners[i];
      shape.vertex(x + this.x, y + this.y);
    }
    shape.endShape(CLOSE);
    return shape;
  }

  //sets a given PShape, allows for use of external integer arrays
  protected PShape constructShape(PShape shape, int[] xc, int[] yc) {
    shape = createShape();
    shape.beginShape();
    for (int i = 0; i < xc.length; i++) {
      int x = xc[i];
      int y = yc[i];
      shape.vertex(x + this.x, y + this.y);
    }
    shape.endShape(CLOSE);
    return shape;
  }

  //sets a given PShape and colors it with inputted values
  protected PShape constructShape(PShape shape, int r, int g, int b) {
    shape = createShape();
    shape.beginShape();
    for (int i = 0; i < xCorners.length; i++) {
      int x = xCorners[i];
      int y = yCorners[i];
      shape.vertex(x + this.x, y + this.y);
    }
    shape.fill(r, g, b);
    shape.endShape(CLOSE);
    return shape;
  }

  // sets starting location for object
  public void setLocation(int x, int y) {
    this.x = x;
    this.y = y;
  }


  //getters
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public float getCenterX() {
    return centerX;
  }
  public float getCenterY() {
    return centerY;
  }

  public boolean isVisible() {
    return visible;
  }
  public PShape getShape() {
    return shape;
  }

  //setter
  public void setVisible(boolean visible) {
    this.visible = visible;
  }


  //PShape setters
  protected void buildShape() {
    shape = constructShape(shape);
  }


  protected void buildShape(int r, int g, int b) {
    shape = constructShape(shape, r, g, b);
  }

  //getters for ship acceleration
  public float getAccelerationX() {
    return accelerationX;
  }
  public float getAccelerationY() {
    return accelerationY;
  }
   //displays the shape
  public void display() {
    pushMatrix();
    shape(shape);
    popMatrix();
  }
}
