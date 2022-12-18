import java.util.*;
PApplet main = this;
int[][] levelMap;
float[][] lvlMap;
float prevTime = 0;
float newMapTime = 15000;
int mapGenerations = 0;

final float FPS = 120;
final float GAMESPEED = 60;
float currentTime, time_passed;
Player me;
void setup() {
  size(720, 480);
  surface.setResizable(true);
  frameRate(FPS);
  // rectMode(CENTER);
  // textAlign(CENTER, CENTER);
  drawPlatform(width/30, new PVector(0, 0), new PVector(30, 30)); // top
  //drawPlatform(2, new PVector(width-(2*30), 60), new PVector(30, 30)); // two piece
  //drawPlatform(5, new PVector(0, height/4), new PVector(30, 30)); // 5 edge piece
  //drawPlatform(5, new PVector(60, height/4+30), new PVector(30, 30)); // 5 edge piece
  //drawPlatform(5, new PVector(120, height/4+60), new PVector(30, 30)); // 5 edge piece
  //drawPlatform(5, new PVector(180, height/4+90), new PVector(30, 30)); // 5 edge piece
  //drawPlatform(5, new PVector(width/2, height/2), new PVector(30, 30)); // 5 center piece
  //drawPlatform(2, new PVector(width-(2*30), height/2), new PVector(30, 30)); // two piece
  //drawPlatform(2, new PVector(width-(2*30), height/2+60), new PVector(30, 30)); // two piece
  //drawPlatform(width/60, new PVector(width-((width/60)*30), height-90), new PVector(30, 30)); // bottom
  //drawPlatform(width/60, new PVector(width-((width/60)*30), height-60), new PVector(30, 30)); // bottom
  drawPlatform(width/30, new PVector(0, height-30), new PVector(30, 30)); // bottom
  levelMap = new int[width/30][height/28];
  newMap();
  currentTime = prevTime = millis();
  PVector start = new PVector(width/2, height/2);
  me = new Player(start, new PVector(25, 25));
  GameManager.getInstance().Render();
}
void draw() {
  // time detla stuff
  background(0);
  GameManager.getInstance().Update(millis());
  //println("FPS: " + frameRate);
}

//void repaint(float time) {
//  if (time >= 60) {
//    for (GameObject g : platforms) {
//      g.update();
//    }
//    me.update();
//  }
//}

void keyPressed() {
  //for (GameControl c: GameManager.getInstance().controllers) {
  //    // Check if the up input action is active.
  //  if (c.isInputActive("up")) {
  //    // Move the game object up.
  //    c.parent.pos.y -= c.parent.vel.y;
  //  }
  //  // Check if the down input action is active.
  //  if (c.isInputActive("down")) {
  //    // Move the game object down.
  //    c.parent.pos.y += c.parent.vel.y;
  //  }
  //  // Check if the left input action is active.
  //  if (c.isInputActive("left")) {
  //    // Move the game object left.
  //    c.parent.pos.x -= c.parent.vel.x;
  //  }
  //  // Check if the right input action is active.
  //  if (c.isInputActive("right")) {
  //    // Move the game object right.
  //    c.parent.pos.x += c.parent.vel.x;
  //  }
  //  // Check if the jump input action is active.
  //  if (c.isInputActive("jump")) {
  //    // Jump with the game object.
  //    c.parent.onJump();
  //  }
  //}
}

void keyReleased() {
  if (key == 'G' || key == 'g') {
    newMap();
    prevTime = millis();
  }
  if (key == 'R' || key == 'r') {
    me.pos.set(random(45, width-45), random(45, height-45));
  }
}

void newMap() {
  for (int i = 0; i < GameManager.getInstance().gameObjects.size(); i++) {
    GameObject g = GameManager.getInstance().gameObjects.get(i);
    if (g instanceof Platform) {
      GameManager.getInstance().Destroy(g);
    }
  }
  GenerateMap();
  LoadMap(levelMap);
  mapGenerations++;
}

void drawPlatform(int amt, PVector pos, PVector size) {
  for (int i = 0; i < amt; i++) {
    //new Platform(new PVector(abs(width-((pos.x+(size.x/2)) + (i * size.x))), pos.y+(size.y/2)), size);
    //Platform p = new Platform(new PVector(abs(((pos.x+(size.x/2)) + (i * size.x))), pos.y+(size.y/2)), size);
    //Platform p = new Platform(new PVector(abs(((pos.x+(size.x)) + (i * size.x))), pos.y-(size.y/2)), size);
    // we are no longer usign center mode for platforms
    Platform p = new Platform(new PVector(abs(((pos.x) + (i * size.x))), pos.y), size);
    if (i % 5 == 0) {
      //p.isSolid = true;
      p.bouncy = true;
    }
  }
}

void GenerateMap() {
  int x = width/30;
  int y = height/28;
  int[][] map = new int[x][y];
  //println(map.length);
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[i].length; j++) {
      float val = random(0, 100);
      float nv = noise(val);
      println(nv);
      if (j <= (int) (.5 * map.length)) {
        map[i][j] = nv < .3 ? 0 : 1;
      } else if (j >= (int) (.7 * map.length)) {
        map[i][j] = nv < .6 ? 1 : 0;
      } else {
        map[i][j] = nv <= .3 ? 0 : 1;
      }
      println(i +"-" + j + " - rowcol: " + map[i][j]);
    }
  }
  levelMap = map;
  JSONArray saveArr = arrayToJson(levelMap);
  saveJSONArray(saveArr, dataPath("./maps/Generation_" + mapGenerations + ".json"), "compact");
}

JSONArray arrayToJson(int[][] arr) {
  JSONArray ja = new JSONArray();
  for (int[] ar : arr) {
    JSONArray j = new JSONArray();
    ja.append(j);
    for (int a : ar) {
      j.append(a);
    }
  }
  return ja;
}

void LoadMap(int[][] map) {
  drawPlatform(width/30, new PVector(0, 0), new PVector(30, 30)); // top
  //for (int i = 0; i < map.length; i++) {
  //  for (int j = 0; j < map[i].length; j++) {
  //    if (map[i][j] == 0) {
  //      new Platform(new PVector((i*30)+15, (j*30)+45), new PVector(30, 30));
  //      //drawPlatform(1, new PVector(i+j*30, (i+j)*30), new PVector(30, 30));
  //    }
  //  }
  //}
  drawPlatform(width/30, new PVector(0, height-30), new PVector(30, 30)); // bottom
  println(GameManager.getInstance().gameObjects.size() + " GameObjects loaded");
  //println(platforms.size() + " Platforms loaded");
}
