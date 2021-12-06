public class Sector {
  private int r, g, b;
  private boolean cometField;
  private Star[] stars;
  private String name;
  //stores speed for moving stars, only initialized if cometfield == true
  private HashMap<Star, Integer> speed;
  public Sector() {
    setColor();

    setMovingStars();

    if (cometField) {
      speed = new HashMap();
      name = name + " comet field";
    }
    spawnStars();
  }


  //spawns the stars, only called upon class initialization
  private void spawnStars() {
    stars = new Star[(int) (Math.random() * 100 + 50)];
    for (int i = 0; i < stars.length; i++) {
      int x = (int) (Math.random() * width);
      int y = (int) (Math.random() * height);
      if (cometField) {
        Star star = new Star(x, y, 204, 221, 225);
        stars[i] = star;
        speed.put(star, (int) (Math.random() * 4) + 2);
      } else stars[i] = new Star(x, y);
    }
  }

  //determines whether sector will be a cometfield or not
  private void setMovingStars() {
    cometField = (int) (Math.random() * 100) < 35;
  }

  //sets the color and the name of the sector
  private void setColor() {
    int colorMode = (int) (Math.random() * 4);
    switch(colorMode) {
    case 0:
      r = 0;
      b = 0;
      g = 0;
      name = "deep dark";
      break;
    case 1:
      r = 21;
      g = 26;
      b = 0;
      name = "silent void";
      break;
    case 2: 
      r = 77;
      g = 0;
      b = 51;
      name = "space of the crimson star";
      break;
    case 3:
      r = 51;
      g = 0;
      b = 77;
      name = "star nebula";
      break;
    }
  }



  //updates in-game bakground with Sector properties
  public void updateBackGround() {
    background(r, g, b);
    for (Star star : stars) {
      star.display();
      if (cometField) {
        star.setX(star.getX() - speed.get(star));
        if (star.getX() < 0)
          star.setX(width);
      }
    }
  }

  //gettters and setters for Sector name 
  public String getTitle() {
    return name;
  }
  public void setTitle(String name) {
    this.name = name;
  }

  //getters and setter for sectors stored stars
  public Star[] getStars() {
    return stars;
  }
  public void clearStars() {
    stars = new Star[0];
  }
}
