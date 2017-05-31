/**
 class MenuItem<T>
 Represents each element contained in a Menu.
 */
class MenuItem<T> extends GUIElement {

  // Instance vars
  int _x, _y, _width, _height, _borderSize, _bezel;
  int _color;
  T _content;

  // Overloaded constructor
  MenuItem( int x, int y, int w, int h, int borderSize, T content ) {
    _x = x;
    _y = y;
    _width = w;
    _height = h;
    _borderSize = borderSize;
    _bezel = borderSize/2;
    _color = 255;
    _content = content;
  }

  /**
   Draws the menu element and text contents.
   */
  void update() {
    //fill(_themeColor*5/3);
    fill(_color);
    rect(_x, _y, _width, _height, _bezel);
    fill(0);
    textAlign( CENTER, CENTER );
    text(_content.toString(), _x, _y, _width, _height);
  }

  /**
   Returns whether or not the mouse cursor is currently in the rectangle containing the element.
   */
  boolean overElement() {
    return overRect(_x, _y, _width, _height);
  }

  // change color of element when mouse hovers over the element
  void mouseOver() {
    _color = 224;
  }

  // reset color
  void mouseAway() {
    _color = 255;
  }
}