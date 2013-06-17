library word_placer;

import 'dart:math';
import 'grid.dart';
import 'direction.dart';
import 'english_word_placer.dart';
import 'punjabi_word_placer.dart';

abstract class WordPlacer {
    List<Direction> _directions;
    static const int MAX_TRIES = 10;

    Grid grid;
    Random r = new Random();

    factory WordPlacer(String language, Grid grid, List<Direction> dirs) {
      if (dirs.length < 1) {
        throw new Exception("Not enough directions checked");
      }
      
      switch(language) {
        case "punjabi":
          return new PunjabiWordPlacer(grid, dirs);
        case "english":
          return new EnglishWordPlacer(grid, dirs);
        default:
          assert(false);
      }
    }
    
    WordPlacer.init(this.grid, this._directions);
    
    bool placeWord(String word) {
      for (int i = 0; i < MAX_TRIES; i++) {
        // Choose a valid starting position
        int row = r.nextInt(grid.dim);
        int col = r.nextInt(grid.dim);
        
        if (grid.get(row, col) != null) {
          continue;
        }
        
        // Choose a valid direction
        Direction direction;
        int length = getWordLength(word);
        for (Direction dir in _directions) {
          if (_checkIfRoom(row, col, length, dir)) {
            direction = dir;
            break;
          }
        }
        if (direction == null) {
          continue;
        }
        
        // Place word in that direction
        putWordInGrid(word, row, col, direction);
        return true;
      }
      return false;
    }
    
    bool _checkIfRoom(int row, int col, int length, Direction dir) {
      for (int i = 0; i < length; i++) {
        int newRow = row + i * dir.deltaRow;
        int newCol = col + i * dir.deltaCol;
        
        if (newRow >= grid.dim || newRow < 0 ||
            newCol >= grid.dim || newCol < 0) {
          return false;
        }
        
        if (grid.get(newRow, newCol) != null) {
          return false;
        }
      }
      return true;
    }
    
    int getWordLength(String word);
    void putWordInGrid(String word, int row, int col, Direction dir);
    String randLetter();
}