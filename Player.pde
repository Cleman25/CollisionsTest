class Player extends GameObject {
  boolean grounded = false;
  Collider collider = new RectCollider(this);
  GameControl controller = new GameControl(this);
  public Player(PVector pos, PVector size) {
      super(pos, size, true);
      fill = color(255);
      outline = color(255, 0, 0);
      gravity.set(0, 0.2);
      collider = new RectCollider(this);
      grounded = true;
      controller.setInputKey("up", KeyEvent.VK_W);
      controller.setInputKey("down", KeyEvent.VK_S);
      controller.setInputKey("left", KeyEvent.VK_A);
      controller.setInputKey("right", KeyEvent.VK_D);
      controller.setInputKey("jump", KeyEvent.VK_SPACE);
  }

  void render() {
    super.render();
    textFont(createFont("Arial Black", 12));
    fill(text);
    text("X:"+pos.x+"\r\nY:"+pos.y, pos.x, pos.y - 40);
  }

  void update() {
    super.update();
  }

  void onCollisionTop(GameObject obj) {
  };

  void onCollisionLeft(GameObject obj) {
  };

  void onCollisionRight(GameObject obj) {
  };

  void onCollisionBottom(GameObject obj) {
  };

  void onCollision(GameObject obj) {
  };
  
  void onSeparation(GameObject obj) {
  };

  void Controls() {
    super.Controls();
  }

  // void PrintDetails() {
  //   println("Pos: \t " + lastPos + "\nLastPos: \t " + pos);
  //   println("Delta: \t " + delta);
  //   println("Vel: \t " + vel + " | Gravity:" + gravity);
  //   println("Bools: \t Gravity:" + useGravity + " | Moving:" + isMoving + " | Jumping:" + isJumping + " | Falling:" + isFalling + " | Can jump:" + canJump + " | Moveable:" + moveable + " | Collided:" + collided);
  //   println("Collisions:" + collisions);
  //   println("Quad: \t Top:" + top+" Left:" + left + " Right+" + right + " Bottom:" + bottom);
  //   PrintCollided();
  // }
}
