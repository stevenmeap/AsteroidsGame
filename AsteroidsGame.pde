  if (ship.onCooldown()) {
    ship.incrementCooldown(1);
    if (ship.getCooldown() > 5) {
      ship.setOnCooldown(false);
      ship.setCooldown(0);
    }
  }
  if (!ship.canJump()) {
    ship.setJumpCooldown(ship.getJumpCooldown() + 1);
    if (ship.getJumpCooldown() > 100) {
      ship.setCanJump(true);
      ship.setJumpCooldown(0);
    }
  }

  update();
  ship.drift();
  text("Score: " + ship.getScore(), 40, 50);
  text("Sector: " + sector.getTitle(), 40, 20);
