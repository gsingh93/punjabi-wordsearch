import 'dart:html';
import 'dart:math';
import 'grid.dart';

void main() {
  List<String> words = getWords();
  int dim = getDimensions();
  Grid grid = createGrid(dim, words);
  grid.display();
}

int getDimensions() {
  return 10;
}

List<String> getWords() {
  return <String>['hello', 'world', 'this', 'is', 'a', 'puzzle'];
}

Grid createGrid(int dim, List<String> words) {
  Grid grid = new Grid(dim);
  grid.placeWords(words);
  grid.fillInBlanks();
  return grid;
}