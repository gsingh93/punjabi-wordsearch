import 'dart:html';
import 'grid.dart';

const MIN_DIM = 5;
const MAX_DIM = 20;

void main() {
  generate();
  query('#generate')..onClick.listen((e) => generate());
}

void generate() {
  List<String> words = getWords();
  try {
    int dim = getDimensions();
    Grid grid = createGrid(dim, words);
    grid.display();
  } on FormatException {
    print("Dimension not an integer");
  } catch(e) {
    print("Invalid integer " + e.toString());
  }
}

int getDimensions() {
  InputElement input = query("input[name='dimensions']");
  int val = int.parse(input.value);
  if (val >= MIN_DIM && val <= MAX_DIM) {
    return val;
  }
  throw val;
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