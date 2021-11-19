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



  public Entity(int x, int y) {
    this.x = x;
    this.y = y;

  }


  //rotates the shape to the appropriate angle, called in drift()
  protected void rot(float angle) {
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
  protected void constructShape() {
    shape = createShape();
    shape.beginShape();
    for (int i = 0; i < xCorners.length; i++) {
      int a = xCorners[i];
      int b = yCorners[i];
      shape.vertex(x + a, y + b);
    }
    shape.endShape();
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

  public boolean getVisible() {
    return visible;
  }
  public PShape getShape() {
    return shape;
  }

  //setter
  public void setVisibility(boolean visible) {
    this.visible = visible;
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
