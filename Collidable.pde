// Interface for collidable objects.
interface Collidable {
  // Method for checking if this collider is intersecting with another collider.
  // Returns true if the colliders are intersecting, false otherwise.
  boolean isColliding(Collider obj);

  // Methods for checking if this collider is intersecting with another collider on a specific side.
  // Returns true if the colliders are intersecting on the specified side, false otherwise.
  boolean isCollidingTop(Collider obj);
  boolean isCollidingBottom(Collider obj);
  boolean isCollidingLeft(Collider obj);
  boolean isCollidingRight(Collider obj);
}
