//// To add the new functionality you specified to the GameControl class, you can add a new method called setInputKeyCode that takes in a String action and an int keyCode as parameters and maps the keyCode to the input action.

//// You can then modify the isInputActive method to check if the keyCode for the input action is being pressed using the keyCodePressed function provided by Processing.

//// Here is an example of how you can modify the GameControl class to add the new functionality:

//// // Copy code
//class GameControl {
//    // Map of input actions to keys.
//    Map < String, Integer > inputKeys;
//    // Map of input actions to key codes.
//    Map < String, Integer > inputKeyCodes;
//    // Map of input actions to controller buttons.
//    Map < String, Integer > inputButtons;
//    // Map of input actions to controller axes.
//    Map < String, Integer > inputAxes;

//    // Constructor for the GameControl class.
//    GameControl() {
//        inputKeys = new HashMap < String, Integer > ();
//        inputKeyCodes = new HashMap < String, Integer > ();
//        inputButtons = new HashMap < String, Integer > ();
//        inputAxes = new HashMap < String, Integer > ();
//    }

//    // Method for setting the key for an input action.
//    void setInputKey(String action, int key) {
//        inputKeys.put(action, key);
//    }

//    // Method for setting the key code for an input action.
//    void setInputKeyCode(String action, int keyCode) {
//        inputKeyCodes.put(action, keyCode);
//    }

//    // Method for setting the controller button for an input action.
//    void setInputButton(String action, int button) {
//        inputButtons.put(action, button);
//    }

//    // Method for setting the controller axis for an input action.
//    void setInputAxis(String action, int axis) {
//        inputAxes.put(action, axis);
//    }

//    // Method for checking if an input action // Clement Abel // continue is active.
//    boolean isInputActive(String action) {
//        // Check if the key for the input action is being pressed.
//        if (inputKeys.containsKey(action) && keyPressed && key == inputKeys.get(action)) {
//            return true;
//        }
//        // Check if the key code for the input action is being pressed.
//        if (inputKeyCodes.containsKey(action) && keyCodePressed && keyCode == inputKeyCodes.get(action)) {
//            return true;
//        }
//        // Check if the controller button for the input action is being pressed.
//        if (inputButtons.containsKey(action) && controller.getButton(inputButtons.get(action))) {
//            return true;
//        }
//        // Check if the controller axis for the input action is above a certain threshold.
//        if (inputAxes.containsKey(action) && abs(controller.getAxis(inputAxes.get(action))) > 0.5) {
//            return true;
//        }
//        return false;
//    }
//}

//import com.tlaen.jgamepad.*;

//GameObject gameObject;

//void setup() {
//    gameObject = new GameObject();
//    gameObject.setInputKeys();
//}

//void draw() {
//    background(255);

//    // Update the game object.
//    gameObject.update();

//    // Draw the game object.
//    gameObject.draw();
//}

//// Key pressed event handler.
//void keyPressed() {
//    // Check if the up input action is active.
//    if (gameObject.controller.isInputActive("up")) {
//        // Move the game object up.
//        gameObject.pos.y -= gameObject.speed;
//    }
//    // Check if the down input action is active.
//    if (gameObject.controller.isInputActive("down")) {
//        // Move the game object down.
//        gameObject.pos.y += gameObject.speed;
//    }
//    // Check if the left input action is active.
//    if (gameObject.controller.isInputActive("left")) {
//        // Move the game object left.
//        gameObject.pos.x -= gameObject.speed;
//    }
//    // Check if the right input action is active.
//    if (gameObject.controller.isInputActive("right")) {
//        // Move the game object right.
//        gameObject.pos.x += gameObject.speed;
//    }
//    // Check if the jump input action is active.
//    if (gameObject.controller.isInputActive("jump")) {
//        // Jump with the game object.
//        gameObject.jump();
//    }
//}


//// Clement Abel
//// add an onSeparation method to the collider
//// To add an onSeparation method to the Collider class that is called when two colliders are no longer intersecting, you can modify the handleCollisions method to call the onSeparation method on the parent game object when the colliders are no longer intersecting.

//// Here's an example of how you can modify the Collider class to add the onSeparation method:

//// Copy code
//class Collider implements Collidable {
//    ArrayList < Collider > collisions;
//    GameObject parent;

//    Collider(GameObject parent) {
//        this.parent = parent;
//        collisions = new ArrayList <Collider>();
//    }

//    // Method for handling collisions.
//    void handleCollisions() {
//        // Loop through the list of colliders that are currently colliding with this collider.
//        for (int i = 0; i < collisions.size(); i++) {
//            Collider other = collisions.get(i);
//            // If the colliders are no longer intersecting, remove the other collider from the list.
//            if (!intersect(other)) {
//                collisions.remove(other);
//                parent.onSeparation(other.parent);
//            } else {
//                if (isCollidingTop(other)) {
//                    parent.onCollisionTop(other.parent);
//                }
//                if (isCollidingBottom(other)) {
//                    parent.onCollisionBottom(other.parent);
//                }
//                if (isCollidingLeft(other)) {
//                    parent.onCollisionLeft(other.parent);
//                }
//                if (isCollidingRight(other)) {
//                    parent.onCollisionRight(other.parent);
//                }
//                if (isColliding(other)) {
//                    parent.onCollision(other.parent);
//                }
//            }
//        }
//    }

//    // Method for detecting collisions.
//    void detectCollisions() {
//        // Loop through the list of all colliders in the game.
//        for (int i = 0; i < colliders.size(); i++) {
//            Collider other = colliders.get(i);
//            // If the colliders are intersecting, add the other collider to the list of colliders that are colliding with this collider.
//            if (intersect(other)) {
//                collisions.add(other);
//            }
//        }
//    }

//    // Method for checking if this collider is intersecting with another collider.
//    // Returns true if the colliders are intersecting, false otherwise.
//    boolean intersect(Collider other) {
//        // Use the best method for 2D collisions based on the type of the colliders.
//        if (this instanceof RectCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum x and y values for each collider's AABB.
//            float minX1 = parent.pos.x;
//            float maxX1 = parent.pos.x + parent.size.x;
//            float minY1 = parent.pos.y;
//            float maxY1 = parent.pos.y + parent.size.y;
//            float minX2 = other.parent.pos.x;
//            float maxX2 = other.parent.pos.x + other.parent.size.x;
//            float minY2 = other.parent.pos.y;
//            float maxY2 = other.parent.pos.y + other.parent.size.y;

//            // Copy code
//            // Check if the AABBs are overlapping (i.e. if there is a collision).
//            if (maxX1 > minX2 && minX1 < maxX2 && maxY1 > minY2 && minY1 < maxY2) {
//                return true;
//            }
//            return false;
//        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
//            // Calculate the distance between the centers of the two colliders.
//            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
//            // Calculate the sum of the radii of the two colliders.
//            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
//            // Check if the distance between the centers is less than the sum of the radii (i.e. if there is a collision).
//            if (distance < radiiSum) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof RectCollider && other instanceof SphereCollider) {
//            // Calculate the minimum and maximum x and y values for the AABB.
//            float minX = parent.pos.x;
//            float maxX = parent.pos.x + parent.size.x;
//            float minY = parent.pos.y;
//            float maxY = parent.pos.y + parent.size.y;
//            // Check if the circle is intersecting the AABB.
//            if (other.parent.pos.x - other.parent.size.x / 2 > minX &&
//                other.parent.pos.x + other.parent.size.x / 2 < maxX &&
//                other.parent.pos.y - other.parent.size.y / 2 > minY &&
//                other.parent.pos.y + other.parent.size.y / 2 < maxY) {
//                return true;
//            }
//            // Check if the circle is intersecting any of the edges of the AABB.
//            if (dist(other.parent.pos.x, other.parent.pos.y, minX, minY) < other.parent.size.x / 2 ||
//                dist(other.parent.pos.x, other.parent.pos.y, maxX, minY) < other.parent.size.x / 2 ||
//                dist(other.parent.pos.x, other.parent.pos.y, minX, maxY) < other.parent.size.x / 2 ||
//                dist(other.parent.pos.x, other.parent.pos.y, maxX, maxY) < other.parent.size.x / 2) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof SphereCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum x and y values for the AABB.
//            float minX = other.parent.pos.x;
//            float maxX = other.parent.pos.x + other.parent.size.x;
//            float minY = other.parent.pos.y;
//            float maxY = other.parent.pos.y + other.parent.size.y;
//            // Check if the circle is intersecting the AABB.
//            if (parent.pos.x - parent.size.x / 2 > minX &&
//                parent.pos.x + parent.size.x / 2 < maxX &&
//                parent.pos.y - parent.size.y / 2 > minY &&
//                parent.pos.y + parent.size.y / 2 < maxY) {
//                return true;
//            }
//            // Check if the circle is intersecting any of the edges of the AABB.
//            if (dist(parent.pos.x, parent.pos.y, minX, minY) < parent.size.x / 2 ||
//                dist(parent.pos.x, parent.pos.y, maxX, minY) < parent.size.x / 2 ||
//                dist(parent.pos.x, parent.pos.y, minX, maxY) < parent.size.x / 2 ||
//                dist(parent.pos.x, parent.pos.y, maxX, maxY) < parent.size.x / 2) {
//                return true;
//            }
//            return false;
//        }
//        return false;
//    }

//    // Method for checking if this collider is colliding with the top side of another collider.
//    // Returns true if the colliders are colliding, false otherwise.
//    boolean isCollidingTop(Collider other) {
//        // Use the best method for 2D collisions based on the type of the colliders.
//        if (this instanceof RectCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum y values for each collider's AABB.
//            float minY1 = parent.pos.y;
//            float maxY1 = parent.pos.y + parent.size.y;
//            float minY2 = other.parent.pos.y;
//            float maxY2 = other.parent.pos.y + other.parent.size.y;
//            // Check if the AABBs are overlapping and the top of the first collider is colliding with the bottom of the second collider.
//            if (maxY1 > minY2 && minY1 < maxY2 && maxY1 > maxY2 && minY1 < maxY2) {
//                return true;
//            }
//            return false;
//        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
//            // Calculate the distance between the centers of the two colliders.
//            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
//            // Calculate the sum of the radii of the two colliders.
//            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
//            // Check if the distance between the centers is less than the sum of the radii and the top of the first collider is colliding with the bottom of the second collider.
//            if (distance < radiiSum && parent.pos.y + parent.size.y / 2 > other.parent.pos.y - other.parent.size.y / 2 && parent.pos.y + parent.size.y / 2 < other.parent.pos.y + other.parent.size.y / 2) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof RectCollider && other instanceof SphereCollider) {
//            // Calculate the minimum and maximum y values for the AABB.
//            float minY = parent.pos.y;
//            float maxY = parent.pos.y + parent.size.y;
//            // Check if the circle is intersecting the top side of the AABB.
//            if (other.parent.pos.y + other.parent.size.y / 2 > minY && other.parent.pos.y + other.parent.size.y / 2 < maxY) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof SphereCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum y values for the AABB.
//            float minY = other.parent.pos.y;
//            float maxY = other.parent.pos.y + other.parent.size.y;
//            // Check if the circle is intersecting the top side of the AABB.
//            if (parent.pos.y + parent.size.y / 2 > minY && parent.pos.y + parent.size.y / 2 < maxY) {
//                return true;
//            }
//            return false;
//        }
//        return false;
//    }

//    // Method for checking if this collider is colliding with the bottom side of another collider.
//    // Returns true if the colliders are colliding, false otherwise.
//    boolean isCollidingBottom(Collider other) {
//        // Use the best method for 2D collisions based on the type of the colliders.
//        if (this instanceof RectCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum y values for each collider's AABB.
//            float minY1 = parent.pos.y;
//            float maxY1 = parent.pos.y + parent.size.y;
//            float minY2 = other.parent.pos.y;
//            float maxY2 = other.parent.pos.y + other.parent.size.y;
//            // Check if the AABBs are overlapping and the bottom of the first collider is colliding with the top of the second collider.
//            if (maxY1 > minY2 && minY1 < maxY2 && minY1 < minY2 && maxY1 > minY2) {
//                return true;
//            }
//            return false;
//        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
//            // Calculate the distance between the centers of the two colliders.
//            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
//            // Calculate the sum of the radii of the two colliders.
//            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
//            // Check if the distance between the centers is less than the sum of the radii and the bottom of the first collider is colliding with the top of the second collider.
//            if (distance < radiiSum && parent.pos.y - parent.size.y / 2 < other.parent.pos.y + other.parent.size.y / 2 && parent.pos.y - parent.size.y / 2 > other.parent.pos.y - other.parent.size.y / 2) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof RectCollider && other instanceof SphereCollider) {
//            // Calculate the minimum and maximum y values for the AABB.
//            float minY = parent.pos.y;
//            float maxY = parent.pos.y + parent.size.y;
//            // Check if the circle is intersecting the bottom side of the AABB.
//            if (other.parent.pos.y - other.parent.size.y / 2 > minY && other.parent.pos.y - other.parent.size.y / 2 < maxY) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof SphereCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum y values for the AABB.
//            float minY = other.parent.pos.y;
//            float maxY = other.parent.pos.y + other.parent.size.y;
//            // Check if the circle is intersecting the bottom side of the AABB.
//            if (parent.pos.y - parent.size.y / 2 > minY && parent.pos.y - parent.size.y / 2 < maxY) {
//                return true;
//            }
//            return false;
//        }
//        return false;
//    }

//    // Method for checking if this collider is colliding with the left side of another collider.
//    // Returns true if the colliders are colliding, false otherwise.
//    boolean isCollidingLeft(Collider other) {
//        // Use the best method for 2D collisions based on the type of the colliders.
//        if (this instanceof RectCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum x values for each collider's AABB.
//            float minX1 = parent.pos.x;
//            float maxX1 = parent.pos.x + parent.size.x;
//            float minX2 = other.parent.pos.x;
//            float maxX2 = other.parent.pos.x + other.parent.size.x;
//            // Check if the AABBs are overlapping and the left side of the first collider is colliding with the right side of the second collider.
//            if (maxX1 > minX2 && minX1 < maxX2 && minX1 < maxX2 && maxX1 > maxX2) {
//                return true;
//            }
//            return false;
//        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
//            // Calculate the distance between the centers of the two colliders.
//            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
//            // Calculate the sum of the radii of the two colliders.
//            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
//            // Check if the distance between the centers is less than the sum of the radii and the left side of the first collider is colliding with the right side of the second collider.
//            if (distance < radiiSum && parent.pos.x - parent.size.x / 2 < other.parent.pos.x + other.parent.size.x / 2 && parent.pos.x - parent.size.x / 2 > other.parent.pos.x - other.parent.size.x / 2) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof RectCollider && other instanceof SphereCollider) {
//            // Calculate the minimum and maximum x values for the AABB.
//            float minX = parent.pos.x;
//            float maxX = parent.pos.x + parent.size.x;
//            // Check if the circle is intersecting the left side of the AABB.
//            if (other.parent.pos.x - other.parent.size.x / 2 > minX && other.parent.pos.x - other.parent.size.x / 2 < maxX) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof SphereCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum x values for the AABB.
//            float minX = other.parent.pos.x;
//            float maxX = other.parent.pos.x + other.parent.size.x;
//            // Check if the circle is intersecting the left side of the AABB.
//            if (parent.pos.x - parent.size.x / 2 > minX && parent.pos.x - parent.size.x / 2 < maxX) {
//                return true;
//            }
//            return false;
//        }
//        return false;
//    }

//    // Method for checking if this collider is colliding with the right side of another collider.
//    // Returns true if the colliders are colliding, false otherwise.
//    boolean isCollidingRight(Collider other) {
//        // Use the best method for 2D collisions based on the type of the colliders.
//        if (this instanceof RectCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum x values for each collider's AABB.
//            float minX1 = parent.pos.x;
//            float maxX1 = parent.pos.x + parent.size.x;
//            float minX2 = other.parent.pos.x;
//            float maxX2 = other.parent.pos.x + other.parent.size.x;
//            // Check if the AABBs are overlapping and the right side of the first collider is colliding with the left side of the second collider.
//            if (maxX1 > minX2 && minX1 < maxX2 && minX1 > minX2 && maxX1 < maxX2) {
//                return true;
//            }
//            return false;
//        } else if (this instanceof SphereCollider && other instanceof SphereCollider) {
//            // Calculate the distance between the centers of the two colliders.
//            float distance = dist(parent.pos.x, parent.pos.y, other.parent.pos.x, other.parent.pos.y);
//            // Calculate the sum of the radii of the two colliders.
//            float radiiSum = parent.size.x / 2 + other.parent.size.x / 2;
//            // Check if the distance between the centers is less than the sum of the radii and the right side of the first collider is colliding with the left side of the second collider.
//            if (distance < radiiSum && parent.pos.x + parent.size.x / 2 > other.parent.pos.x - other.parent.size.x / 2 && parent.pos.x + parent.size.x / 2 < other.parent.pos.x + other.parent.size.x / 2) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof RectCollider && other instanceof SphereCollider) {
//            // Calculate the minimum and maximum x values for the AABB.
//            float minX = parent.pos.x;
//            float maxX = parent.pos.x + parent.size.x;
//            // Check if the circle is intersecting the right side of the AABB.
//            if (other.parent.pos.x + other.parent.size.x / 2 > minX && other.parent.pos.x + other.parent.size.x / 2 < maxX) {
//                return true;
//            }
//            return false;
//        }
//        // If the colliders are of different types, use the AABB vs. circle collision method.
//        if (this instanceof SphereCollider && other instanceof RectCollider) {
//            // Calculate the minimum and maximum x values for the AABB.
//            float minX = other.parent.pos.x;
//            float maxX = other.parent.pos.x + other.parent.size.x;
//            // Check if the circle is intersecting the right side of the AABB.
//            if (parent.pos.x + parent.size.x / 2 > minX && parent.pos.x + parent.size.x / 2 < maxX) {
//                return true;
//            }
//            return false;
//        }
//        return false;
//    }
//}

//// Example usage:

//// Create a new collider for a game object.
//Collider collider = new Collider(this);

//// In the update method:

//// Detect collisions with other colliders.
//collider.detectCollisions();

//// Handle collisions with other colliders.
//collider.handleCollisions();

//// In the draw method:

//// Draw the collider for debugging.
//collider.draw();

//// I hope this helps! Let me know if you have any further questions or if you need further assistance.

//// To use this in your game, you will need to add the collider to a list of colliders that are updated and drawn each frame. You can do this by creating a static list of colliders in your main sketch class:

//// Copy code
//ArrayList < Collider > colliders = new ArrayList < Collider > ();
//// Then, in the setup method, you can add the collider to the list:

//// Copy code
//colliders.add(collider);
//// In the draw method, you can loop through the list of colliders and call the draw method for each one:

//// Copy code
//for (int i = 0; i < colliders.size(); i++) {
//    colliders.get(i).draw();
//}
//// Finally, in the update method, you can loop through the list of colliders and call the detectCollisions and handleCollisions methods for each one:

//// Copy code
//for (int i = 0; i < colliders.size(); i++) {
//    colliders.get(i).detectCollisions();
//    colliders.get(i).handleCollisions();
//}
//// This will update and draw all of the colliders in your game each frame.

//// I hope this helps! Let me know if you have any further questions or if you need further assistance.
// void setInputKey(String action, int key) {
//         inputKeys.put(action, key);
//         switch(action) {
//             case "left":
//                 setInputButton(action, GCP.LEFT_JOYSTICK_LEFT);
//                 setInputAxis(action, GCP.LEFT_JOYSTICK_HORIZ);
//                 setInputKeyCode(action, KeyEvent.VK_LEFT);
//                 break;
//             case "right":
//                 setInputButton(action, GCP.LEFT_JOYSTICK_RIGHT);
//                 setInputAxis(action, GCP.LEFT_JOYSTICK_HORIZ);
//                 setInputKeyCode(action, KeyEvent.VK_RIGHT);
//                 break;
//             case "up":
//                 setInputButton(action, GCP.LEFT_JOYSTICK_UP);
//                 setInputAxis(action, GCP.LEFT_JOYSTICK_VERT);
//                 setInputKeyCode(action, KeyEvent.VK_UP);
//                 break;
//             case "down":
//                 setInputButton(action, GCP.LEFT_JOYSTICK_DOWN);
//                 setInputAxis(action, GCP.LEFT_JOYSTICK_VERT);
//                 setInputKeyCode(action, KeyEvent.VK_DOWN);
//                 break;
//             case "jump":
//                 setInputButton(action, GCP.A_BUTTON);
//                 setInputAxis(action, GCP.RIGHT_TRIGGER);
//                 setInputKeyCode(action, KeyEvent.VK_SPACE);
//                 break;
//             default:
//                 setInputKeyCode(action, key);
//                 break;
//         }
//     }

//     void setInputKeyCode(String action, int keyCode) {
//         inputKeyCodes.put(action, keyCode);
//         gcp.assignKey(action, keyCode);
//     }

//     void setInputButton(String action, int button) {
//         inputButtons.put(action, button);
//         gcp.assignButton(action, button);
//     }

//     void setInputAxis(String action, int axis) {
//         inputAxes.put(action, axis);
//         gcp.assignAxis(action, axis);
//     }

//     boolean isInputActive(String action) {
//         if (inputKeys.containsKey(action) && keyPressed && key == inputKeys.get(action)) {
//             return true;
//         }
//         if (inputKeyCodes.containsKey(action) && keyPressed && keyCode == inputKeyCodes.get(action)) {
//             return true;
//         }
//         if (inputButtons.containsKey(action) && getButton(action)) {
//             return true;
//         }
//         if (inputAxes.containsKey(action) && abs(getAxis(inputAxes.get(action))) > 0.5f) {
//             return true;
//         }
//         return false;
//     }

//     float getAxis(String axisName) {
//         Controller[] controllers = ControllerEnvironment.getDefaultEnvironment().getControllers();
//         // Iterate over the controllers and try to find the one with the specified axis
//         for (Controller controller : controllers) {
//             if (controller.getType() == Controller.Type.STICK || controller.getType() == Controller.Type.GAMEPAD) {
//                 // Check each component (axis or button) on the controller
//                 for (Component component : controller.getComponents()) {
//                     // Check if the component's name matches the specified axis name
//                     if (component.getName().equalsIgnoreCase(axisName)) {
//                         // Return the component's current value
//                         return component.getPollData();
//                     }
//                 }
//             }
//         }

//         // If the specified axis was not found, return 0
//         return 0;
//     }

//     float getAxis(float axis) {
//         Controller[] controllers = ControllerEnvironment.getDefaultEnvironment().getControllers();
//         // Iterate over the controllers and try to find the one with the specified axis
//         for (Controller controller : controllers) {
//             if (controller.getType() == Controller.Type.STICK || controller.getType() == Controller.Type.GAMEPAD) {
//                 // Check each component (axis or button) on the controller
//                 for (Component component : controller.getComponents()) {
//                     // Check if the component's index matches the specified axis index
//                     if (component.getIdentifier() == axis) {
//                         // Return the component's current value
//                         return component.getPollData();
//                     }
//                 }
//             }
//         }

//         // If the specified axis was not found, return 0
//         return 0;
//     }

//     boolean getButton(String buttonName) {
//         Controller[] controllers = ControllerEnvironment.getDefaultEnvironment().getControllers();
//         // Iterate over the controllers and try to find the one with the specified button
//         for (Controller controller : controllers) {
//             if (controller.getType() == Controller.Type.STICK || controller.getType() == Controller.Type.GAMEPAD) {
//                 // Check each component (axis or button) on the controller
//                 for (Component component : controller.getComponents()) {
//                     // Check if the component is a button and its name or identifier matches the specified button name
//                     if (component.getType() == Component.Type.BUTTON && (component.getName().equalsIgnoreCase(buttonName) || component.getIdentifier().getName().equalsIgnoreCase(buttonName))) {
//                         // Return the component's current state
//                         return component.getPollData() == 1.0f;
//                     }
//                 }
//             }
//         }

//         // If the specified button was not found, return false
//         return false;
//     }

//     void update() {
//         if (isInputActive("left")) {
//             println("left");
//         }
//         if (isInputActive("right")) {
//             println("right");
//         }
//         if (isInputActive("up")) {
//             println("up");
//         }
//         if (isInputActive("down")) {
//             println("down");
//         }
//         if (isInputActive("jump")) {
//             println("jump");
//         }
//     }