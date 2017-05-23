Integer[] arr = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18};
Menu<Integer> test = new Menu<Integer>( 50, 25, 128, "Hello world", arr );

void setup() {
  size(600, 600);
  background(255);
  test.create();
}

void draw() {
}

class Menu<T> {

  int _borderSize, _innerBorderSize, _bezel, _textSize;
  int _themeColor;
  String _title;
  T[] _contents;

  Menu( int borderSize, int innerBorderSize, int themeColor, String title, T[] contents) {
    _borderSize = borderSize;
    _bezel = borderSize/2;
    _innerBorderSize = innerBorderSize;
    _textSize = borderSize/2;
    _themeColor = themeColor;
    _title = title;
    _contents = contents;
  }

  void create() {
    // create GUI window
    fill((_themeColor+256)/2);
    rect(_borderSize, _borderSize, width-_borderSize*2, height-_borderSize*2, _bezel);

    // create title section
    fill(_themeColor);
    rect(_borderSize, _borderSize, width-_borderSize*2, 3*_bezel, _bezel, _bezel, 0, 0);

    // create title text
    fill(0);
    textAlign( CENTER, CENTER );
    textSize(_textSize);
    text(_title, _borderSize, _borderSize, width-_borderSize*2, 3*_bezel);

    // create menu items
    int maxContent = maxContent();
    for (int i = 0; i < _contents.length && i <= maxContent; i++) {
      MenuItem<T> item = new MenuItem<T>( _borderSize+_innerBorderSize, _borderSize+4*_bezel+i*(_textSize*2+_innerBorderSize/2), 
                                          width-(_borderSize+_innerBorderSize)*2, _textSize*2, 
                                          _innerBorderSize, _themeColor, _contents[i] );
      item.create();
    }
  }
  
  int maxContent() {
    return (height - _borderSize - _borderSize+4*_bezel) / (_textSize*2+_innerBorderSize/2) - 4;
  }
}

class MenuItem<T> {

  int _x, _y, _width, _height, _borderSize, _bezel;
  int _themeColor;
  T _content;

  MenuItem( int x, int y, int w, int h, int borderSize, int themeColor, T content ) {
    _x = x;
    _y = y;
    _width = w;
    _height = h;
    _borderSize = borderSize;
    _bezel = borderSize/2;
    _themeColor = themeColor;
    _content = content;
  }

  void create() {
    fill(_themeColor*5/3);
    rect(_x, _y, _width, _height, _bezel);
    fill(0);
    textAlign( CENTER, CENTER );
    text(_content.toString(), _x, _y, _width, _height);
  }
}