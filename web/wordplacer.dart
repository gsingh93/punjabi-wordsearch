import 'dart:math';
import 'grid.dart';

class Direction {
  final int deltaRow;
  final int deltaCol;
  
  const Direction(this.deltaRow, this.deltaCol);
  
  static const N = const Direction(1, 0);
  static const S = const Direction(-1, 0);
  static const E = const Direction(0, 1);
  static const W = const Direction(0, -1);
  static const NW = const Direction(1, -1);
  static const SW = const Direction(-1, -1);
  static const NE = const Direction(1, 1);
  static const SE = const Direction(-1, 1);
  
  static get values => [N, S, E, W, NW, SW, NE, SE];
}

class WordPlacer {
  static List<Direction> directions = [];
  static const int MAX_TRIES = 10;

  Grid grid;
  Random r = new Random();

  WordPlacer(this.grid);
  
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
      for (Direction dir in Direction.values) {
        if (checkIfRoom(row, col, word.length, dir)) {
          direction = dir;
          break;
        }
      }
      if (direction == null) {
        continue;
      }
      
      // Place word in that direction
      for (int i = 0; i < word.length; i++) {
        int newRow = row + i * direction.deltaRow;
        int newCol = col + i * direction.deltaCol;
        grid.set(newRow, newCol, word[i]);
      }
      return true;
    }
    return false;
  }
  
  bool checkIfRoom(int row, int col, int length, Direction dir) {
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
}