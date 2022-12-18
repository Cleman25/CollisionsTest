class Platform extends GameObject {
  Collider collider = new RectCollider(this);
  boolean bouncy = false;
  public Platform(PVector pos, PVector size) {
    super(pos, size, false);
    this.pos = pos;
    this.size = size;
    fill = color(255, 0, 0);
    outline = color(255);
  }

  void render() {
    super.render();
    textFont(createFont("Arial Black", 10));
    if (mouseX >= left && mouseX <= right && mouseY >= top && mouseY <= bottom) {
      fill(text);
      text("X:"+pos.x+"\nY:"+pos.y, pos.x, pos.y - 40);
    }
    fill(255);
    //text(GameManager.getInstance().gameObjects.indexOf(this), pos.x, pos.y-2);
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
}
