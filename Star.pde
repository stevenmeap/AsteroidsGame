public class Star {
  protected int x, y;
  protected int r, b, g;
  boolean glow;
  public Star(int x, int y) {
    this.x = x;
    this.y = y;
    r = 255;
    g = 255;
    b = 255;
    glow = true;
  }
  public Star(int x, int y, int r, int g, int b) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
    glow = false;
  }


//display the star primitive shape
  public void display() {
    pushMatrix();
    if (glow) {
      noStroke();
      fill(255, 247, 230, 0.6);
      ellipse(x, y, 10, 10);
    }
    popMatrix();
    pushMatrix();
    stroke(255,255,255);
    fill(r, g, b);
    ellipse(x, y, 5, 5);
    popMatrix();
  }


//getters and setters for star coordinates
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public void setX(int x) {
    this.x = x;
  }
  public void setY(int y) {
    this.y = y;
  }
}
