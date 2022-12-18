static class GameManager {
    ArrayList<GameObject> gameObjects;
    ArrayList<Collider> colliders;
    ArrayList<GameControl> controllers;
    float fixedDeltaTime;
    float fixedTimeAccumulator;
    static GameManager instance;

    private GameManager() {
        // Create game objects
        // Create colliders
        gameObjects = new ArrayList<GameObject>();
        colliders = new ArrayList<Collider>();
        controllers = new ArrayList<GameControl>();
        fixedDeltaTime = 1.0f / 60.0f;
        fixedTimeAccumulator = 0;
    }

    static GameManager getInstance() {
        if (instance == null) {
            instance = new GameManager();
        }
        return instance;
    }

    void Update(float deltaTime) {
        // fixedTimeAccumulator += deltaTime;
        // while (fixedTimeAccumulator >= fixedDeltaTime) {
        //     fixedTimeAccumulator -= fixedDeltaTime;
        //     FixedUpdate(fixedDeltaTime);
        // }
        float elapsedTime = deltaTime - fixedTimeAccumulator;
        fixedTimeAccumulator += elapsedTime;
        while (fixedTimeAccumulator >= fixedDeltaTime) {
            FixedUpdate(fixedDeltaTime);
            fixedTimeAccumulator -= fixedDeltaTime;
        }
        Render();
    }

    void FixedUpdate(float deltaTime) {
        // Update game objects
        // Update colliders
        updateGameObjects(deltaTime);
        detectAndHandleCollisions();
    }

    void Render() {
        // Render game objects
        renderGameObjects();
    }

    void Destroy() {
        for (int i = 0; i < gameObjects.size(); i++) {
            gameObjects.get(i).destroy();
        }
        for (int i = 0; i < colliders.size(); i++) {
            colliders.get(i).destroy();
        }
    }
    
    void Destroy(GameObject g) {
      g.destroy();
    }

    void addGameObject(GameObject go) {
        gameObjects.add(go);
    }

    void removeGameObject(GameObject go) {
        gameObjects.remove(go);
    }

    void updateGameObjects(float deltaTime) {
        for (int i = 0; i < gameObjects.size(); i++) {
            // gameObjects[i].update(deltaTime);
            GameObject obj = gameObjects.get(i);
            obj.update();
            if (obj.isMovable) {
                obj.vel.add(obj.acc.mult(deltaTime));
                obj.pos.add(obj.vel.mult(deltaTime));
                obj.vel.add(obj.gravity.mult(deltaTime));
            } else {
                obj.vel = new PVector(0, 0);
            }
        }
    }

    void detectAndHandleCollisions() {
        for (int i = 0; i < colliders.size(); i++) {
            colliders.get(i).detectCollisions();
        }
        for (int i = 0; i < colliders.size(); i++) {
            colliders.get(i).handleCollisions();
        }
    }
    
    void updateGameControls() {
        for (GameControl c: controllers) {
            c.update();
        }
    }

    void renderGameObjects() {
        for (int i = 0; i < gameObjects.size(); i++) {
            gameObjects.get(i).render();
        }
    }
}
