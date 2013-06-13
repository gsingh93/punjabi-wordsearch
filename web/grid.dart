import 'dart:html';
import 'dart:math';
import 'wordplacer.dart';
import 'direction.dart';

class Grid {
  
  static const String letters = "abcdefghijklmnopqrstuvwxyz";

  List<List<String>> grid;
  
  Random r = new Random();
  WordPlacer wp;
  int dim;
  
  Grid(this.dim, directions) {
    grid = new List<List<String>>(dim);
    for (int i = 0; i < dim; i++) {
      grid[i] = new List<String>(dim);
    }
    
    wp = new WordPlacer(this, directions);
  }
  
  String get(int row, int col) {
    assert(row < dim && row >= 0);
    assert(col < dim && col >= 0);
    return grid[row][col];
  }
  
  void set(int row, int col, String letter) {
    assert(row < dim && row >= 0);
    assert(col < dim && col >= 0);
    assert(letter.length == 1);
    grid[row][col] = letter;
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
      if (!wp.placeWord(word)) {
        print("Word " + word + " couldn't be placed");
      }
    }
  }
  
  void fillInBlanks() {
    for (int i = 0; i < dim; i++) {
      for (int j = 0; j < dim; j++) {
        if (grid[i][j] == null) {
          grid[i][j] = randLetter();
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
        b.text = grid[i][j];
        b.classes.add("letter");
        wordsearchDiv.children.add(b);
      }
      wordsearchDiv.children.add(new Element.tag('br'));
    }
  }
  
  String randLetter() {
    return letters[r.nextInt(26)];
  }
}