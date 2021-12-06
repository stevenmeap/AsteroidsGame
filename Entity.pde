public class Entity {
  protected int corners;
  protected int[] xCorners;
  protected int[] yCorners;
  protected int speed;

  protected float x, y;
  protected float angle = 0.0; 


  protected float accelerationX;
  protected float accelerationY;
  protected boolean visible;

  protected boolean noFill;

  protected int r, g, b;


  public Entity(int x, int y) {
    r = 255;
    g = 255;
    b = 255;
    visible = true;
    noFill = false;
    accelerationX = 0;
    accelerationY = 0;
    this.x = x;
    this.y = y;
  }

  //sets a given PShape 
  protected void drawShape() {
    move();
    pushMatrix();
    translate(x, y);
    rotate(angle);
    beginShape();
    if (noFill) {
      noFill();
      stroke(255);
    } else {
      fill(r,g,b);
      stroke(0);
    }
    for (int i = 0; i < xCorners.length; i++) {
      int x = xCorners[i];
      int y = yCorners[i];
      vertex(x, y);
    }
    endShape();
    translate(-x, -y);
    popMatrix();
  }

  protected void drawAddon(int[] xc, int[] yc, float dx, float dy) {
    move();
    pushMatrix();
    translate(dx, dy);
    rotate(angle);
    beginShape();
    if (noFill) {
      noFill();
      stroke(255);
    } else {
      fill(r,g,b);
      stroke(0);
    }
    for (int i = 0; i < xc.length; i++) {
      int x = xc[i];
      int y = yc[i];
      vertex(x, y);
    }
    endShape(CLOSE);
    translate(-dx, -dy);
    popMatrix();
  }


  protected boolean colliding(Entity entity1, Entity entity2) {
    return dist(entity1.getX(), entity1.getY(), entity2.getX(), entity2.getY()) < entity1.getAverageBounds();
  }


  public void move() {
    if (x > width) {
      x = 1;
      return;
    } else if (x < 0) {
      x = width -1;
      return;
    }
    if (y > height) {
      y = 1;
      return;
    } else if ( y < 0) {
      y = height - 1;
      return;
    }
    x += accelerationX;
    y += accelerationY;
  }
  public void drift() {
    drawShape();
  }


  // sets starting location for object
  public void setLocation(int x, int y) {
    this.x = x;
    this.y = y;
  }


  //getters
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }

  public boolean getVisible() {
    return visible;
  }
  public float getWidth() {
    int maxX = 0;
    for (int i : xCorners) {
      if (i < 0)
        i *= -1;
      maxX = Math.max(maxX, i);
    }
    return maxX;
  }
  public float getHeight() {
    int maxY = 0;
    for (int i : yCorners) {
      if (i < 0)
        i *= -1;
      maxY = Math.max(maxY, i);
    }
    return maxY;
  }
  public float getAverageBounds() {
    return (getWidth() + getHeight()) / 2;
  }

  //setter
  public void setVisibility(boolean visible) {
    this.visible = visible;
  }
}
