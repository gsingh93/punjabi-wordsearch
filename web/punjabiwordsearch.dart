import 'dart:html';
import 'grid.dart';
import 'direction.dart';

const int BUTTON_SIZE = 25;

const int MIN_DIM = 5;
const int MAX_DIM = 20;

void main() {  
  int width = getDimensions() * BUTTON_SIZE;
  width += 600;
  query('#content-inner')..style.width = width.toString() + "px";
  
  initListeners();
  
  generate();
  query('#generate')..onClick.listen((e) => generate());
}

void initListeners() {
  query('#automatic-radio')..onChange.listen((e) => radioToggleVisibility(e));
  query('#manual-radio')..onChange.listen((e) => radioToggleVisibility(e));
}

void radioToggleVisibility(event) {
  toggleVisibility("#input-words");
  toggleVisibility("#num-words");
}

void toggleVisibility(String element, [bool block = true]) {
  var el = query(element);
  String display = el.style.display;
  
  if (display == "none") {
    if (block) {
      display = "block";
    } else {
      display = "inline";
    }
  } else {
    display = "none";
  }
  
  el.style.display = display;
}

void generate() {
  List<String> words = getWords();
  try {
    int dim = getDimensions();
    List<Direction> dirs = getDirections();
    if (dirs.length < 1) {
      print("Not enough directions checked");
      return;
    }
    Grid grid = createGrid(dim, words, dirs);
    grid.display();
  } on FormatException {
    print("Dimension not an integer");
  } catch(e) {
    print("Invalid integer " + e.toString());
  }
}

List<Direction> getDirections() {
  List<Direction> dirs = new List<Direction>();
  ElementList<CheckboxInputElement> dirElements = queryAll('input[name="directions"]');
  for (CheckboxInputElement dir in dirElements) {
    dirs.add(Direction.getDir(dir.value));
  }
  return dirs;
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

Grid createGrid(int dim, List<String> words, List<Direction> directions) {
  Grid grid = new Grid(dim, directions);
  grid.placeWords(words);
  grid.fillInBlanks();
  return grid;
}