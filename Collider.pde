class Collider implements Collidable {
    ArrayList < Collider > collisions;
    GameObject parent;

    Collider(GameObject parent) {
        this.parent = parent;
        collisions = new ArrayList < Collider > ();
    }

    // Method for handling collisions.
    void handleCollisions() {
        // Loop through the list of colliders that are currently colliding with this collider.
        for (int i = 0; i < collisions.size(); i++) {
            Collider other = collisions.get(i);
			// if collider is a Platform and the other collider is a Player or if collider is a Player and the other collider is a Platform
			if ((this.parent instanceof Platform && other.parent instanceof Player) || (this.parent instanceof Player && other.parent instanceof Platform)) {
				
				// If the colliders are no longer intersecting, remove the other collider from the list.
				if (!intersect(other)) {
					collisions.remove(other);
					parent.onSeparation(other.parent);
				} else {
					if (isCollidingTop(other)) {
						parent.onCollisionTop(other.parent);
					}
					if (isCollidingBottom(other)) {
						parent.onCollisionBottom(other.parent);
					}
					if (isCollidingLeft(other)) {
						parent.onCollisionLeft(other.parent);
					}
					if (isCollidingRight(other)) {
						parent.onCollisionRight(other.parent);
					}
					if (isColliding(other)) {
						parent.onCollision(other.parent);
					}
				}

				// If the player is moving down and the player's bottom is above the platform's top, then the player is standing on the platform.
				if (other.parent.vel.y > 0 && other.parent.pos.y + other.parent.size.y / 2 > parent.pos.y - parent.size.y / 2) {
					// Set the player's position to the top of the platform.
					other.parent.pos.y = parent.pos.y - parent.size.y / 2 - other.parent.size.y / 2;
					// Set the player's velocity to 0.
					other.parent.vel.y = 0;
					// Set the player's grounded variable to true.
					((Player) other.parent).grounded = true;
				}

				// If the player is moving up and the player's top is below the platform's bottom, then the player is standing on the platform.
				if (other.parent.vel.y < 0 && other.parent.pos.y - other.parent.size.y / 2 < parent.pos.y + parent.size.y / 2) {
					// Set the player's position to the bottom of the platform.
					other.parent.pos.y = parent.pos.y + parent.size.y / 2 + other.parent.size.y / 2;
					// Set the player's velocity to 0.
					other.parent.vel.y = 0;
				}

				// If the player is moving right and the player's right is to the left of the platform's left, then the player is standing on the platform.
				if (other.parent.vel.x > 0 && other.parent.pos.x + other.parent.size.x / 2 > parent.pos.x - parent.size.x / 2) {
					// Set the player's position to the left of the platform.
					other.parent.pos.x = parent.pos.x - parent.size.x / 2 - other.parent.size.x / 2;
					// Set the player's velocity to 0.
					other.parent.vel.x = 0;
				}

				// If the player is moving left and the player's left is to the right of the platform's right, then the player is standing on the platform.
				if (other.parent.vel.x < 0 && other.parent.pos.x - other.parent.size.x / 2 < parent.pos.x + parent.size.x / 2) {
					// Set the player's position to the right of the platform.
					other.parent.pos.x = parent.pos.x + parent.size.x / 2 + other.parent.size.x / 2;
					// Set the player's velocity to 0.
					other.parent.vel.x = 0;
				}

			}
        }
    }
	
    // Method for detecting collisions.
    void detectCollisions() {
        // Loop through the list of all colliders in the game.
        for (int i = 0; i < GameManager.getInstance().colliders.size(); i++) {
            Collider other = GameManager.getInstance().colliders.get(i);
            // If the colliders are intersecting, add the other collider to the list of colliders that are colliding with this collider.
            if (intersect(other)) {
                collisions.add(other);
            }
        }
    }

	// Method for checking if this collider is intersecting with another collider.
	// Returns true if the colliders are intersecting, false otherwise.
	boolean intersect(Collider other) {
		// Use the best method for 2D collisions based on the type of the colliders.
		if (this instanceof RectCollider && other instanceof RectCollider) {
			// Calculate the minimum and maximum x and y values for each collider's AABB.
			float minX1 = parent.pos.x;
			float maxX1 = parent.pos.x + parent.size.x;
			float minY1 = parent.pos.y;
			float maxY1 = parent.pos.y + parent.size.y;
			float minX2 = other.parent.pos.x;
			float maxX2 = other.parent.pos.x + other.parent.size.x;
			float minY2 = other.parent.pos.y;
			float maxY2 = other.parent.pos.y + other.parent.size.y;

			// Check if the AABBs are overlapping (i.e. if there is a collision).
			if (maxX1 > minX2 && minX1 < maxX2 && maxY1 > minY2 && minY1 < maxY2) {
				return true;
			}
			return false;
		} else if (this instanceof SphereCollider && other instanceof SphereCollider) {
			// Calculate the distance between the centers of the two colliders.
			float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
			// Calculate the sum of the radii of the two colliders.
			float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
			// Check if the distance between the centers is less than the sum of the radii (i.e. if there is a collision).
			if (distance < radiiSum) {
				return true;
			}
			return false;
		} else if (this instanceof RectCollider && other instanceof SphereCollider) {
			// Calculate the minimum and maximum x and y values for the rect collider's AABB.
			float minX = parent.pos.x;
			float maxX = parent.pos.x + parent.size.x;
			float minY = parent.pos.y;
			float maxY = parent.pos.y + parent.size.y;
			// Check if the center of the sphere collider is inside the rect collider's AABB.
			if (other.parent.pos.x > minX && other.parent.pos.x < maxX && other.parent.pos.y > minY && other.parent.pos.y < maxY) {
				return true;
			}
            // Check if the circle is intersecting any of the edges of the AABB.
            if (dist(other.parent.pos.x, other.parent.pos.y, minX, minY) < other.parent.size.x / 2 ||
                dist(other.parent.pos.x, other.parent.pos.y, maxX, minY) < other.parent.size.x / 2 ||
                dist(other.parent.pos.x, other.parent.pos.y, minX, maxY) < other.parent.size.x / 2 ||
                dist(other.parent.pos.x, other.parent.pos.y, maxX, maxY) < other.parent.size.x / 2) {
                return true;
            }
			return false;
		}
		if (this instanceof SphereCollider && other instanceof RectCollider) {
			// Calculate the minimum and maximum x and y values for the rect collider's AABB.
			float minX = other.parent.pos.x;
			float maxX = other.parent.pos.x + other.parent.size.x;
			float minY = other.parent.pos.y;
			float maxY = other.parent.pos.y + other.parent.size.y;
            // Check if the circle is intersecting any of the edges of the AABB.
			if (parent.pos.x - parent.size.x / 2 > minX &&
                parent.pos.x + parent.size.x / 2 < maxX &&
                parent.pos.y - parent.size.y / 2 > minY &&
                parent.pos.y + parent.size.y / 2 < maxY) {
                return true;
			}
			// Check if the circle is intersecting any of the edges of the AABB.
            if (dist(parent.pos.x, parent.pos.y, minX, minY) < parent.size.x / 2 ||
                dist(parent.pos.x, parent.pos.y, maxX, minY) < parent.size.x / 2 ||
                dist(parent.pos.x, parent.pos.y, minX, maxY) < parent.size.x / 2 ||
                dist(parent.pos.x, parent.pos.y, maxX, maxY) < parent.size.x / 2) {
                return true;
            }
			return false;
		}
		return false;
	}

	// Method for checking if this collider is intersecting with a point.
	// Returns true if the collider is intersecting with the point, false otherwise.
	boolean intersect(PVector point) {
		// Use the best method for 2D collisions based on the type of the collider.
		if (this instanceof RectCollider) {
			// Calculate the minimum and maximum x and y values for the collider's AABB.
			float minX = parent.pos.x;
			float maxX = parent.pos.x + parent.size.x;
			float minY = parent.pos.y;
			float maxY = parent.pos.y + parent.size.y;
			// Check if the point is inside the collider's AABB (i.e. if there is a collision).
			if (point.x > minX && point.x < maxX && point.y > minY && point.y < maxY) {
				return true;
			}
			return false;
		} else if (this instanceof SphereCollider) {
			// Calculate the distance between the center of the collider and the point.
			float distance = dist(parent.pos.x, parent.pos.y, point.x, point.y);
			// Check if the distance between the center of the collider and the point is less than the radius of the collider (i.e. if there is a collision).
			if (distance < parent.size.x / 2) {
				return true;
			}
			return false;
		}
		return false;
	}

	// Method for checking if this collider is intersecting with a line.
	// Returns true if the collider is intersecting with the line, false otherwise.
	boolean intersect(Line line) {
		// Use the best method for 2D collisions based on the type of the collider.
		if (this instanceof RectCollider) {
			// Calculate the minimum and maximum x and y values for the collider's AABB.
			float minX = parent.pos.x;
			float maxX = parent.pos.x + parent.size.x;
			float minY = parent.pos.y;
			float maxY = parent.pos.y + parent.size.y;
			// Check if the line is inside the collider's AABB (i.e. if there is a collision).
			if (line.start.x > minX && line.start.x < maxX && line.start.y > minY && line.start.y < maxY) {
				return true;
			}
			if (line.end.x > minX && line.end.x < maxX && line.end.y > minY && line.end.y < maxY) {
				return true;
			}
			// Check if the line intersects any of the edges of the collider's AABB.
			if (line.intersect(new Line(minX, minY, maxX, minY))) {
				return true;
			}
			if (line.intersect(new Line(minX, minY, minX, maxY))) {
				return true;
			}
			if (line.intersect(new Line(maxX, minY, maxX, maxY))) {
				return true;
			}
			if (line.intersect(new Line(minX, maxY, maxX, maxY))) {
				return true;
			}
			return false;
		} else if (this instanceof SphereCollider) {
			// Calculate the distance between the center of the collider and the line.
			float distance = dist(parent.pos.x, parent.pos.y, line.start.x, line.start.y);
			// Check if the distance between the center of the collider and the line is less than the radius of the collider (i.e. if there is a collision).
			if (distance < parent.size.x / 2) {
				return true;
			}
			return false;
		}
		return false;
	}

	// implement the abstract method from the Collidable interface
	boolean isColliding(Collider obj) {
		return intersect(obj);
	}

	// Method for checking if this collider is colliding with the top side of another collider.
    // Returns true if the colliders are colliding, false otherwise.
    boolean isCollidingTop(Collider other) {
        // Use the best method for 2D collisions based on the type of the colliders.
        if (this instanceof RectCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum y values for each collider's AABB.
            float minY1 = parent.pos.y;
            float maxY1 = parent.pos.y + parent.size.y;
            float minY2 = other.parent.pos.y;
            float maxY2 = other.parent.pos.y + other.parent.size.y;
            // Check if the AABBs are overlapping and the top of the first collider is colliding with the bottom of the second collider.
            if (maxY1 > minY2 && minY1 < maxY2 && maxY1 > maxY2 && minY1 < maxY2) {
                return true;
            }
            return false;
        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
            // Calculate the distance between the centers of the two colliders.
            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
            // Calculate the sum of the radii of the two colliders.
            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
            // Check if the distance between the centers is less than the sum of the radii and the top of the first collider is colliding with the bottom of the second collider.
            if (distance < radiiSum && parent.pos.y + parent.size.y / 2 > other.parent.pos.y - other.parent.size.y / 2 && parent.pos.y + parent.size.y / 2 < other.parent.pos.y + other.parent.size.y / 2) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof RectCollider && other instanceof SphereCollider) {
            // Calculate the minimum and maximum y values for the AABB.
            float minY = parent.pos.y;
            float maxY = parent.pos.y + parent.size.y;
            // Check if the circle is intersecting the top side of the AABB.
            if (other.parent.pos.y + other.parent.size.y / 2 > minY && other.parent.pos.y + other.parent.size.y / 2 < maxY) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof SphereCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum y values for the AABB.
            float minY = other.parent.pos.y;
            float maxY = other.parent.pos.y + other.parent.size.y;
            // Check if the circle is intersecting the top side of the AABB.
            if (parent.pos.y + parent.size.y / 2 > minY && parent.pos.y + parent.size.y / 2 < maxY) {
                return true;
            }
            return false;
        }
        return false;
    }

	// Method for checking if this collider is colliding with the bottom side of another collider.
    // Returns true if the colliders are colliding, false otherwise.
    boolean isCollidingBottom(Collider other) {
        // Use the best method for 2D collisions based on the type of the colliders.
        if (this instanceof RectCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum y values for each collider's AABB.
            float minY1 = parent.pos.y;
            float maxY1 = parent.pos.y + parent.size.y;
            float minY2 = other.parent.pos.y;
            float maxY2 = other.parent.pos.y + other.parent.size.y;
            // Check if the AABBs are overlapping and the bottom of the first collider is colliding with the top of the second collider.
            if (maxY1 > minY2 && minY1 < maxY2 && minY1 < minY2 && maxY1 > minY2) {
                return true;
            }
            return false;
        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
            // Calculate the distance between the centers of the two colliders.
            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
            // Calculate the sum of the radii of the two colliders.
            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
            // Check if the distance between the centers is less than the sum of the radii and the bottom of the first collider is colliding with the top of the second collider.
            if (distance < radiiSum && parent.pos.y - parent.size.y / 2 < other.parent.pos.y + other.parent.size.y / 2 && parent.pos.y - parent.size.y / 2 > other.parent.pos.y - other.parent.size.y / 2) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof RectCollider && other instanceof SphereCollider) {
            // Calculate the minimum and maximum y values for the AABB.
            float minY = parent.pos.y;
            float maxY = parent.pos.y + parent.size.y;
            // Check if the circle is intersecting the bottom side of the AABB.
            if (other.parent.pos.y - other.parent.size.y / 2 > minY && other.parent.pos.y - other.parent.size.y / 2 < maxY) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof SphereCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum y values for the AABB.
            float minY = other.parent.pos.y;
            float maxY = other.parent.pos.y + other.parent.size.y;
            // Check if the circle is intersecting the bottom side of the AABB.
            if (parent.pos.y - parent.size.y / 2 > minY && parent.pos.y - parent.size.y / 2 < maxY) {
                return true;
            }
            return false;
        }
        return false;
    }

	// Method for checking if this collider is colliding with the left side of another collider.
    // Returns true if the colliders are colliding, false otherwise.
    boolean isCollidingLeft(Collider other) {
        // Use the best method for 2D collisions based on the type of the colliders.
        if (this instanceof RectCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum x values for each collider's AABB.
            float minX1 = parent.pos.x;
            float maxX1 = parent.pos.x + parent.size.x;
            float minX2 = other.parent.pos.x;
            float maxX2 = other.parent.pos.x + other.parent.size.x;
            // Check if the AABBs are overlapping and the left side of the first collider is colliding with the right side of the second collider.
            if (maxX1 > minX2 && minX1 < maxX2 && minX1 < maxX2 && maxX1 > maxX2) {
                return true;
            }
            return false;
        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
            // Calculate the distance between the centers of the two colliders.
            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
            // Calculate the sum of the radii of the two colliders.
            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
            // Check if the distance between the centers is less than the sum of the radii and the left side of the first collider is colliding with the right side of the second collider.
            if (distance < radiiSum && parent.pos.x - parent.size.x / 2 < other.parent.pos.x + other.parent.size.x / 2 && parent.pos.x - parent.size.x / 2 > other.parent.pos.x - other.parent.size.x / 2) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof RectCollider && other instanceof SphereCollider) {
            // Calculate the minimum and maximum x values for the AABB.
            float minX = parent.pos.x;
            float maxX = parent.pos.x + parent.size.x;
            // Check if the circle is intersecting the left side of the AABB.
            if (other.parent.pos.x - other.parent.size.x / 2 > minX && other.parent.pos.x - other.parent.size.x / 2 < maxX) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof SphereCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum x values for the AABB.
            float minX = other.parent.pos.x;
            float maxX = other.parent.pos.x + other.parent.size.x;
            // Check if the circle is intersecting the left side of the AABB.
            if (parent.pos.x - parent.size.x / 2 > minX && parent.pos.x - parent.size.x / 2 < maxX) {
                return true;
            }
            return false;
        }
        return false;
    }

	// Method for checking if this collider is colliding with the right side of another collider.
    // Returns true if the colliders are colliding, false otherwise.
    boolean isCollidingRight(Collider other) {
        // Use the best method for 2D collisions based on the type of the colliders.
        if (this instanceof RectCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum x values for each collider's AABB.
            float minX1 = parent.pos.x;
            float maxX1 = parent.pos.x + parent.size.x;
            float minX2 = other.parent.pos.x;
            float maxX2 = other.parent.pos.x + other.parent.size.x;
            // Check if the AABBs are overlapping and the right side of the first collider is colliding with the left side of the second collider.
            if (maxX1 > minX2 && minX1 < maxX2 && minX1 > minX2 && maxX1 < maxX2) {
                return true;
            }
            return false;
        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
            // Calculate the distance between the centers of the two colliders.
            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
            // Calculate the sum of the radii of the two colliders.
            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
            // Check if the distance between the centers is less than the sum of the radii and the right side of the first collider is colliding with the left side of the second collider.
            if (distance < radiiSum && parent.pos.x + parent.size.x / 2 > other.parent.pos.x - other.parent.size.x / 2 && parent.pos.x + parent.size.x / 2 < other.parent.pos.x + other.parent.size.x / 2) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof RectCollider && other instanceof SphereCollider) {
            // Calculate the minimum and maximum x values for the AABB.
            float minX = parent.pos.x;
            float maxX = parent.pos.x + parent.size.x;
            // Check if the circle is intersecting the right side of the AABB.
            if (other.parent.pos.x + other.parent.size.x / 2 > minX && other.parent.pos.x + other.parent.size.x / 2 < maxX) {
                return true;
            }
            return false;
        }
        // If the colliders are of different types, use the AABB vs. circle collision method.
        if (this instanceof SphereCollider && other instanceof RectCollider) {
            // Calculate the minimum and maximum x values for the AABB.
            float minX = other.parent.pos.x;
            float maxX = other.parent.pos.x + other.parent.size.x;
            // Check if the circle is intersecting the right side of the AABB.
            if (parent.pos.x + parent.size.x / 2 > minX && parent.pos.x + parent.size.x / 2 < maxX) {
                return true;
            }
            return false;
        }
        return false;
    }
	protected void dispose() {
		destroy();
	}

	protected void destroy() {
		if (GameManager.getInstance().colliders.contains(this)) {
			GameManager.getInstance().colliders.remove(this);
		}
	}
}
