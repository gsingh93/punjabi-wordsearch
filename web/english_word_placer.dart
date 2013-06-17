library english_word_placer;

import 'dart:math';
import 'grid.dart';
import 'direction.dart';
import 'word_placer.dart';

class EnglishWordPlacer extends WordPlacer {
  
  static const String _LETTERS = "abcdefghijklmnopqrstuvwxyz";
  
  EnglishWordPlacer(Grid g, List<Direction> d) : super.init(g, d);
  
  int getWordLength(String word) {
    return word.length;
  }
  
  void putWordInGrid(String word, int row, int col, Direction dir) {
    for (int i = 0; i < word.length; i++) {
      int newRow = row + i * dir.deltaRow;
      int newCol = col + i * dir.deltaCol;
      grid.set(newRow, newCol, word[i]);
    }
  }  
  
  String randLetter() {
    return _LETTERS[r.nextInt(26)];
  }
}