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
  query('#automatic-radio')..onChange.listen((e) => radioChanged(e));
  query('#manual-radio')..onChange.listen((e) => radioChanged(e));
  query('#generate')..onClick.listen((e) => generate());
  query('#language')..onChange.listen((e) => changeLang());
}

void radioChanged(event) {
  toggleVisibility("#input-words");
  toggleVisibility("#num-words");
  
  if (ConfigManager.isInputManual()) {
    // TODO Display Punjabi keyboard
  }
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

void changeLang() {
  if (ConfigManager.getLanguage() == "punjabi") {
    if (ConfigManager.isInputManual()) {
      // TODO Display Punjabi keyboard
    }
    query('#input-words').classes.add('punjabi');
  } else {
    query('#input-words').classes.remove('punjabi');
  }
}

void setLanguage() {
  String lang = ConfigManager.getLanguage();
  DivElement wordSearch = query('#wordsearch');
  if (lang == "punjabi") {
    wordSearch.classes.add('punjabi');
  } else {
    wordSearch.classes.remove('punjabi');
  }
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
    setLanguage();
    grid.display();
  } on FormatException {
    String errorMessage = "The dimension not an integer";
    print(errorMessage);
    window.alert(errorMessage);
  } catch(e) {
    String errorMessage = "An error occurred: " + e.toString();
    print(errorMessage);
    window.alert(errorMessage);
  }
}

Grid createGrid(int dim, List<String> words, List<Direction> directions) {
  Grid grid = new Grid(dim, directions);
  grid.placeWords(words);
  grid.fillInBlanks();
  return grid;
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
  try {
    int dim = ConfigManager.getDimensions();
    if (dim >= MIN_DIM && dim <= MAX_DIM) {
      return dim;
    } else {
      throw new Exception(dim.toString() + " is an invalid dimension");
    }
  } on FormatException {
    // TODO Get invalid dim
    throw new Exception("Invalid dimension ");
  }
}

List<String> getWords() {
  if (ConfigManager.isInputAutomatic()) {
    return <String>['hello', 'world', 'this', 'is', 'a', 'puzzle'];
  } else {
    int dim = ConfigManager.getDimensions();
    List<String> words = ConfigManager.getWords();
    print(words.length);
    for (String word in words) {
      print(word);
      if (word.length > dim) {
        String errorMessage = "The word " + word + " is " + word.length.toString() 
            + "letters long, but the largest word that can fit on the grid is only "
            + dim.toString() + " letters long";
        throw new Exception(errorMessage);
      }
    }
    return words;
  }
}