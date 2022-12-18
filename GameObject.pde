abstract class GameObject {
    PVector pos, vel, lastPos, delta, size, acc, gravity;
    boolean useGravity = false, canJump = true, inAir = false, isMoving = false, isMovable = true, rendered = false;
    float friction = 0.99, left, right, top, bottom;
    Collider collider;
    GameControl controller;
    color fill = color(255, 0, 0), outline = color(255), text = color(0);
    public GameObject(PVector pos, PVector size, boolean mvb) {
        this.pos = pos;
        this.size = size;
        this.isMovable = mvb;
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
        gravity = new PVector(0, 0.1);
        delta = new PVector(0, 0);
        lastPos = new PVector(0, 0);
        GameManager.getInstance().gameObjects.add(this);
        if (collider != null) {
            GameManager.getInstance().colliders.add(collider);
        }
        if (controller != null) {
            GameManager.getInstance().controllers.add(controller);
        }
    }

    void render() {
        pushMatrix();
        stroke(outline);
        strokeWeight(1);
        fill(fill);
        boundaryBox();
        popMatrix();
        rendered = true;
    }

    void update() {
        Dimensions();
        Controls();
        isMoving = delta.x != 0;
        lastPos = pos.copy();
    }

    void boundaryBox() {
        if (collider instanceof RectCollider) {
            rect(pos.x, pos.y, size.x, size.y, 2);
        } else if(collider instanceof SphereCollider) {
            ellipse(pos.x, pos.y, size.x, size.y);
        }
    }

    void Dimensions() {
        left = pos.x;
        right = pos.x + size.x;
        top = pos.y;
        bottom = pos.y + size.y;
    }

    // detects the 5 basic actions (up, left, down, right, jump) and allows the player to double jump if the canJump boolean is true and the player is in the air
    void Controls() {
      if (controller != null) {
          if (controller.isInputActive("up")) {
              onUp();
          }
          if (controller.isInputActive("left")) {
              onLeft();
          }
          if (controller.isInputActive("down")) {
              onDown();
          }
          if (controller.isInputActive("right")) {
              onRight();
          }
          if (controller.isInputActive("jump")) {
              if (canJump && !inAir) {
                  onJump();
              } else if(canJump && inAir) {
                  onDoubleJump();
              }
          }
        }
    };

    // basic actions
    void onUp() {
        if (useGravity) {
            vel.y = -5;
        }
    }

    void onLeft() {
        vel.x = -5;
    }

    void onDown() {
        vel.y = 5;
    }

    void onRight() {
        if (useGravity) {
            vel.x = 5;
        }
    }

    void onJump() {
        if (useGravity) {
            vel.y = -10;
            inAir = true;
        }
    }

    void onDoubleJump() {
        if (useGravity) {
            if (vel.y < 0) {
                vel.y = -vel.y;
                canJump = false;
                inAir = true;
            }
        }
    }

    abstract void onCollision(GameObject obj);
    abstract void onCollisionTop(GameObject obj);
    abstract void onCollisionLeft(GameObject obj);
    abstract void onCollisionRight(GameObject obj);
    abstract void onCollisionBottom(GameObject obj);
  	abstract void onSeparation(GameObject obj);
    // garbage collection
    protected void dispose() {
        destroy();
    }

    protected void destroy() {
        if (GameManager.getInstance().gameObjects.contains(this)) {
            GameManager.getInstance().gameObjects.remove(this);
        }
    }
}
