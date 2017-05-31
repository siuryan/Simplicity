/**
 abstract class GUIElement
 Provides methods for GUI subclasses and forces them to override update().
 */
abstract class GUIElement {

  /**
   Finds whether or not the mouse is currently inside a rectangle with the specified coords.
   params:
   - int x: x coord of top left corner
   - int y: y coord of top left corner
   - int width: width of rectangle
   - int height: height of rectangle
   returns boolean - returns true if mouse is inside the specified rectangle, false otherwise
   */
  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }

  // abstract method to be implemented by subclasses
  abstract void update();
}