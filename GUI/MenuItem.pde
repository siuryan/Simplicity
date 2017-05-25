class MenuItem<T> extends GUIElement {

  int _x, _y, _width, _height, _borderSize, _bezel;
  int _color;
  T _content;

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

  void update() {
    //fill(_themeColor*5/3);
    fill(_color);
    rect(_x, _y, _width, _height, _bezel);
    fill(0);
    textAlign( CENTER, CENTER );
    text(_content.toString(), _x, _y, _width, _height);
  }

  boolean overElement() {
    return overRect(_x, _y, _width, _height);
  }

  void mouseOver() {
    _color = 224;
  }

  void mouseAway() {
    _color = 255;
  }
}