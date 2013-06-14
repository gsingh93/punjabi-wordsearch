import 'dart:html';
import 'grid.dart';
import 'direction.dart';
import 'configmanager.dart';

const int BUTTON_SIZE = 25;

const int MIN_DIM = 5;
const int MAX_DIM = 20;

void main() {  
  int width = getDimensions() * BUTTON_SIZE;
  width += 600;
  query('#content-inner')..style.width = width.toString() + "px";
  
  initListeners();
  
  generate();
}

void initListeners() {
  query('#automatic-radio')..onChange.listen((e) => radioToggleVisibility(e));
  query('#manual-radio')..onChange.listen((e) => radioToggleVisibility(e));
  query('#generate')..onClick.listen((e) => generate());
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
  } catch(e) { // TODO
    print("Invalid integer " + e.toString());
  }
}

List<Direction> getDirections() {
  List<Direction> dirs = new List<Direction>();
  List<CheckboxInputElement> dirElements = ConfigManager.getDirections();
  for (CheckboxInputElement dir in dirElements) {
    dirs.add(Direction.getDir(dir.value));
  }
  return dirs;
}

int getDimensions() {
  int dim = ConfigManager.getDimensions();
  if (dim >= MIN_DIM && dim <= MAX_DIM) {
    return dim;
  }
  throw dim;
}

List<String> getWords() {
  if (ConfigManager.isInputAutomatic()) {
    return <String>['hello', 'world', 'this', 'is', 'a', 'puzzle'];
  } else {
    return ConfigManager.getWords(); // TODO: Validate lengths    
  }
}

Grid createGrid(int dim, List<String> words, List<Direction> directions) {
  Grid grid = new Grid(dim, directions);
  grid.placeWords(words);
  grid.fillInBlanks();
  return grid;
}