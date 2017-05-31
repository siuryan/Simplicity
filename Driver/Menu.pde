/**
 class Menu<T>
 Represents a menu in the GUI; a container for MenuItems<T>.
 */
class Menu<T> extends GUIElement {

  // Instance vars
  int _borderSize, _innerBorderSize, _bezel, _textSize, _width, _height, _elementRows;
  boolean _includeBack;
  color _themeColor;
  String _title;
  int _page;
  T[] _contents;
  ArrayList<MenuItem<T>> _menuItems;

  // Overloaded constructors
  Menu( String title, int w, int h, int borderSize, int innerBorderSize, int elementRows, color themeColor, T[] contents, boolean includeBack ) {
    _borderSize = borderSize;
    _bezel = borderSize/2;
    _width = w;
    _height = h;
    _innerBorderSize = innerBorderSize;
    _elementRows = elementRows;
    _textSize = borderSize/2;
    _themeColor = themeColor;
    _title = title;
    _page = 0;
    _contents = contents;
    _includeBack = includeBack;
    _menuItems = new ArrayList<MenuItem<T>>();
  }
  Menu( String title, int w, int h, int borderSize, int innerBorderSize, int elementRows, color themeColor, T[] contents, boolean includeBack, int page ) {
    this( title, w, h, borderSize, innerBorderSize, elementRows, themeColor, contents, includeBack );
    _page = page;
  }
  
  // Accessor
  int getPage() {
    return _page;
  }
  
  // Mutator
  int setPage( int page ) {
    int foo = _page;
    _page = page;
    return foo;
  }

  /**
   Draws the shapes in the menu.
   */
  void update() {

    // create back and next buttons
    fill(255);
    noStroke();
    textAlign( CENTER, CENTER );
    textSize(_textSize*3/2);
    fill(0);
    if (_contents.length > maxContent()) {
      text("←", 0, (_height-_borderSize)/2, _borderSize, _borderSize);
      text("→", _width-_borderSize, (_height-_borderSize)/2, _borderSize, _borderSize);
    }

    // create GUI window
    stroke(0);
    float red = (255-red(_themeColor))/2+red(_themeColor);
    float green = (255-green(_themeColor))/2+green(_themeColor);
    float blue = (255-blue(_themeColor))/2+blue(_themeColor);
    fill(color(red, green, blue));
    rect(_borderSize, _borderSize, _width-_borderSize*2, _height-_borderSize*2, _bezel);

    // create title section
    fill(_themeColor);
    rect(_borderSize, _borderSize, _width-_borderSize*2, 3*_bezel, _bezel, _bezel, 0, 0);

    // create title text
    fill(0);
    textAlign( CENTER, CENTER );
    textSize(_textSize);
    text(_title, _borderSize, _borderSize, _width-_borderSize*2, 3*_bezel);

    // create exit button
    if (_includeBack) {
      textSize(_textSize*2/3);
      fill(0);
      text("Back", _borderSize, _borderSize, _borderSize*2, 3*_bezel);
    }

    // create menu items and displays them
    if (_menuItems.size() == 0) {
      textSize(_textSize);
      int maxContent = maxContent();

      // create new MenuItems
      for (int i = _page*maxContent; i < _contents.length && i <= (_page+1)*maxContent; i++) {
        MenuItem<T> item = new MenuItem<T>( _borderSize+_innerBorderSize, _borderSize+4*_bezel+(i-maxContent*_page)*(_textSize*_elementRows+_innerBorderSize/2), 
          _width-(_borderSize+_innerBorderSize)*2, _textSize*_elementRows, 
          _innerBorderSize, _contents[i] );
        _menuItems.add( item );

        // handle shading animation
        if (item.overElement()) {
          item.mouseOver();
        } else {
          item.mouseAway();
        }
        item.update();  //keeps drawing updated
      }
    }
  }

  /**
   Finds the index of the last MenuItem that can fit on the current page.
   return int - index
   */
  int maxContent() {
    return (_height - 2*_borderSize - 4*_bezel - _innerBorderSize) / (_textSize*_elementRows+_innerBorderSize/2) - 1;
  }

  /**
   Finds whether or not the mouse is over the previous page button.
   return boolean - true if over button, false otherwise
   */
  boolean overBack() {
    return overRect( 0, (_height-_borderSize)/2, _borderSize, _borderSize );
  }

  /**
   Finds whether or not the mouse is over the next page button.
   return boolean - true if over button, false otherwise
   */
  boolean overNext() {
    return overRect(_width-_borderSize, (_height-_borderSize)/2, _borderSize, _borderSize);
  }

  /**
   Finds whether or not the mouse is over the back/exit button.
   return boolean - true if over button, false otherwise
   */
  boolean overExit() {
    return overRect(_borderSize, _borderSize, _borderSize*2, 3*_bezel);
  }

  /** 
   Finds the index of an element that is currently being selected.
   return int - index if an element is currently being selected, otherwise -1
   */
  int overElement() {
    int maxContent = maxContent();
    //System.out.println(maxContent);
    //System.out.println(_contents.length);
    //System.out.println(_page);
    //System.out.println(_menuItems);
    for (int i = 0; i+(_page*maxContent) < _contents.length && i <= maxContent; i++) {
      if (_menuItems.get(i).overElement()) {
        System.out.println(_menuItems.get(i));
        return i+_page*maxContent;
      }
    }
    return -1;
  }

  /**
   Returns the contents of the menu element contained in index i.
   */
  T getElement( int i ) {
    return _contents[i];
  }

  /**
   Goes to previous page if there is a previous page.
   */
  void prevPage() {
    if (_page > 0) {
      _page--;
      update();
    }
  }
  
  /**
   Goes to next page if there is a next page.
   */
  void nextPage() {
    if (_page < _contents.length/maxContent()) {
      _page++;
      update();
    }
  }
}