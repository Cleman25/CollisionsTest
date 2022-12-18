//import com.tlaen.jgamepad.*;
import java.awt.event.KeyEvent;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

class GameControl {
    GCP gcp;
    ControlIO control;
    ControlDevice mouse, keyboard, mouseKeyboard, stick, gamepad, active;
    ControlButton button;
    ControlHat hat;
    ControlSlider slider;
    ArrayList<ControlDevice> devices;
    HashMap<String, Integer> inputKeys;
    HashMap<String, Integer> inputButtons;
    HashMap<String, Float> inputAxes;
    GameObject parent;

    GameControl(GameObject parent) {
        this.parent = parent;
        inputKeys = new HashMap<String, Integer>();
        inputButtons = new HashMap<String, Integer>();
        inputAxes = new HashMap<String, Float>();
        control = ControlIO.getInstance(main);
        gcp = new GCP();
        // device = control.filter(GCP.STICK | GCP.GAMEPAD | GCP.MOUSE).getDevice();
        mouse = control.filter(GCP.MOUSE).getDevice();
        keyboard = control.filter(GCP.KEYBOARD).getDevice();
        mouseKeyboard = control.filter(GCP.MOUSE | GCP.KEYBOARD).getDevice();
        stick = control.filter(GCP.STICK).getDevice();
        gamepad = control.filter(GCP.GAMEPAD).getDevice();
        active = mouseKeyboard;
        devices = new ArrayList<ControlDevice>();
        devices.add(mouse);
        devices.add(keyboard);
        devices.add(mouseKeyboard);
        devices.add(stick);
        devices.add(gamepad);
        println("GameControl initialized");
    }

    void switchDevice(String device) {
        switch(device) {
            case "mouse":
                active = mouse;
                println("Device set to mouse");
                setInput(devices.get(0), "left", KeyEvent.VK_A);
                setInput(devices.get(0), "right", KeyEvent.VK_D);
                setInput(devices.get(0), "up", KeyEvent.VK_W);
                setInput(devices.get(0), "down", KeyEvent.VK_S);
                setInput(devices.get(0), "jump", KeyEvent.VK_SPACE);
                setInput(devices.get(0), "shoot", KeyEvent.VK_SHIFT);
                setInput(devices.get(0), "reload", KeyEvent.VK_R);
                setInput(devices.get(0), "pause", KeyEvent.VK_ESCAPE);
                setInput(devices.get(0), "menu", KeyEvent.VK_ENTER);
                setInput(devices.get(0), "quit", KeyEvent.VK_Q);
                break;
            case "keyboard":
                active = keyboard;
                println("Device set to keyboard");
                setInput(devices.get(1), "left", KeyEvent.VK_LEFT);
                setInput(devices.get(1), "right", KeyEvent.VK_RIGHT);
                setInput(devices.get(1), "up", KeyEvent.VK_UP);
                setInput(devices.get(1), "down", KeyEvent.VK_DOWN);
                setInput(devices.get(1), "jump", KeyEvent.VK_SPACE);
                setInput(devices.get(1), "shoot", KeyEvent.VK_SHIFT);
                setInput(devices.get(1), "reload", KeyEvent.VK_R);
                setInput(devices.get(1), "pause", KeyEvent.VK_ESCAPE);
                setInput(devices.get(1), "menu", KeyEvent.VK_ENTER);
                setInput(devices.get(1), "quit", KeyEvent.VK_Q);
                break;
            case "mouseKeyboard":
                active = mouseKeyboard;
                println("Device set to mouseKeyboard");
                setInput(devices.get(2), "left", KeyEvent.VK_A);
                setInput(devices.get(2), "right", KeyEvent.VK_D);
                setInput(devices.get(2), "up", KeyEvent.VK_W);
                setInput(devices.get(2), "down", KeyEvent.VK_S);
                setInput(devices.get(2), "jump", KeyEvent.VK_SPACE);
                setInput(devices.get(2), "shoot", KeyEvent.VK_SHIFT);
                setInput(devices.get(2), "reload", KeyEvent.VK_R);
                setInput(devices.get(2), "pause", KeyEvent.VK_ESCAPE);
                setInput(devices.get(2), "menu", KeyEvent.VK_ENTER);
                setInput(devices.get(2), "quit", KeyEvent.VK_Q);
                break;
            case "stick":
                active = stick;
                println("Device set to stick");
                setInput(devices.get(3), "left", GCP.AXIS_X);
                break;
            case "gamepad":
                active = gamepad;
                println("Device set to gamepad");
                break;
            default:
                active = mouseKeyboard;
                println("Unsupported device: " + device + ". Using mouseKeyboard instead.");
                println("Supported devices: mouse, keyboard, mouseKeyboard, stick, gamepad");
                break;
        }
    }

    void setInput(device, action, input) {
        switch(device) {
            case "mouse":
                inputButtons.put(action, input);
                break;
            case "keyboard":
                inputKeys.put(action, input);
                break;
            case "mouseKeyboard":
                inputButtons.put(action, input);
                break;
            case "stick":
                inputAxes.put(action, input);
                break;
            case "gamepad":
                inputButtons.put(action, input);
                break;
            default:
                println("Unsupported device: " + device + ". Using mouseKeyboard instead.");
                println("Supported devices: mouse, keyboard, mouseKeyboard, stick, gamepad");
                break;
        }
    }
    
}
