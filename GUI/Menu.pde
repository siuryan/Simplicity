class Menu<T> extends GUIElement<T> {

  int _borderSize, _innerBorderSize, _bezel, _textSize;
  color _themeColor;
  String _title;
  int _page;
  T[] _contents;
  ArrayList<MenuItem<T>> _menuItems;

  Menu( int borderSize, int innerBorderSize, color themeColor, String title, T[] contents) {
    _borderSize = borderSize;
    _bezel = borderSize/2;
    _innerBorderSize = innerBorderSize;
    _textSize = borderSize/2;
    _themeColor = themeColor;
    _title = title;
    _page = 0;
    _contents = contents;
    _menuItems = new ArrayList<MenuItem<T>>();
  }

  void update() {
    // create back and next buttons
    fill(255);
    noStroke();
    textAlign( CENTER, CENTER );
    textSize(_textSize*3/2);
    rect(0, (width-_borderSize)/2, _borderSize, _borderSize);
    rect(width-_borderSize, (height-_borderSize)/2, _borderSize, _borderSize);
    fill(0);
    text("←", 0, (height-_borderSize)/2, _borderSize, _borderSize);
    text("→", width-_borderSize, (height-_borderSize)/2, _borderSize, _borderSize);

    // create GUI window
    stroke(0);
    float red = (255-red(_themeColor))/2+red(_themeColor);
    float green = (255-green(_themeColor))/2+green(_themeColor);
    float blue = (255-blue(_themeColor))/2+blue(_themeColor);
    fill(color(red, green, blue));
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
    for (int i = _page*maxContent; i < _contents.length && i <= (_page+1)*maxContent; i++) {
      MenuItem<T> item = new MenuItem<T>( _borderSize+_innerBorderSize, _borderSize+4*_bezel+(i-maxContent*_page)*(_textSize*2+_innerBorderSize/2), 
        width-(_borderSize+_innerBorderSize)*2, _textSize*2, 
        _innerBorderSize, _contents[i] );
      _menuItems.add( item );
      if (item.overElement()) {
        item.mouseOver();
      } else {
        item.mouseAway();
      }
      item.update();
    }
  }

  int maxContent() {
    return (height - _borderSize - _borderSize+4*_bezel - _innerBorderSize) / (_textSize*2+_innerBorderSize/2) - 4;
  }

  boolean overBack() {
    return overRect( 0, (height-_borderSize)/2, _borderSize, _borderSize );
  }

  boolean overNext() {
    return overRect(width-_borderSize, (height-_borderSize)/2, _borderSize, _borderSize);
  }

  int overElement() {
    int maxContent = maxContent();
    for (int i = 0; i <= maxContent; i++) {
      if (_menuItems.get(i).overElement() && i+_page*maxContent < _contents.length) {
        return i+_page*maxContent;
      }
    }
    return -1;
  }
  
  T getElement( int i ) {
    return _contents[i];
  }

  void prevPage() {
    if (_page > 0) {
      _page--;
      update();
    }
  }

  void nextPage() {
    if (_page < _contents.length/maxContent()) {
      _page++;
      update();
    }
  }
}