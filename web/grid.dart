library grid;

import 'dart:html';
import 'word_placer.dart';
import 'config_manager.dart';

class Grid {
  List<List<String>> _grid;
  
  WordPlacer _wp;
  int dim;
  
  Grid(this.dim) {
    _grid = new List<List<String>>(dim);
    for (int i = 0; i < dim; i++) {
      _grid[i] = new List<String>(dim);
    }
    
    _wp = new WordPlacer(getLanguage(), this, getDirections());
  }
  
  String get(int row, int col) {
    assert(row < dim && row >= 0);
    assert(col < dim && col >= 0);
    return _grid[row][col];
  }
  
  void set(int row, int col, String letter) {
    assert(row < dim && row >= 0);
    assert(col < dim && col >= 0);
    _grid[row][col] = letter;
  }
  
  int strLengthCompare(String a, String b) {
    if (a.length == b.length) {
      return 0;
    } else if (a.length < b.length) {
      return 1;
    } else {
      return -1;
    }
  }
  
  void placeWords(List<String> words) {
    words.sort((a, b) => strLengthCompare(a, b));
    for (String word in words) {
      if (!_wp.placeWord(word)) {
        print("Word " + word + " couldn't be placed");
      }
    }
  }
  
  void fillInBlanks() {
    for (int i = 0; i < dim; i++) {
      for (int j = 0; j < dim; j++) {
        if (_grid[i][j] == null) {
          _grid[i][j] = _wp.randLetter();
        }
      }
    }
  }
  
  void display() {
    DivElement wordsearchDiv = query("#wordsearch");
    wordsearchDiv.innerHtml = "";
    for (int i = 0; i < dim; i++) {
      for (int j = 0; j < dim; j++) {
        ButtonElement b = new ButtonElement();
        b.text = _grid[i][j];
        b.classes.add("letter");
        wordsearchDiv.children.add(b);
      }
      wordsearchDiv.children.add(new Element.tag('br'));
    }
  }
}