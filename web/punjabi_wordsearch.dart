import 'dart:html';
import 'grid.dart';
import 'direction.dart';
import 'config_manager.dart' as ConfigManager;
import 'word_placer.dart';

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
  try {
    int dim = getDimensions();    
    List<String> words = getWords();
    Grid grid = createGrid(dim, words);
    setLanguage();
    grid.display();
    displayWords(words);
  } catch(e, stackTrace) {
    String errorMessage = "An error occurred: " + e.toString();
    print(errorMessage);
    print(stackTrace);
    window.alert(errorMessage);
  }
}

Grid createGrid(int dim, List<String> words) {
  Grid grid = new Grid(dim);
  grid.placeWords(words);
  grid.fillInBlanks();
  return grid;
}

void displayWords(List<String> words) {
  OListElement list = query("#words");
  list.children.clear();
  for (String word in words) {
    LIElement elt = new LIElement();
    elt.text = word;
    list.append(elt);
  }
}

int getDimensions() {
  int dim = ConfigManager.getDimensions();
  if (dim >= MIN_DIM && dim <= MAX_DIM) {
    return dim;
  } else {
    throw new Exception(dim.toString() + " is an invalid dimension. "
        + "The dimension must be between " + MIN_DIM.toString() + " and "
        + MAX_DIM.toString() + ".");
  }
}

List<String> getWords() {
  if (ConfigManager.isInputAutomatic()) {
    int numWords = ConfigManager.getNumWords();
    if (numWords < 1) {
      throw new Exception("You must have at least one word");
    }
    // TODO
    return <String>['hello', 'world', 'this', 'is', 'a', 'puzzle'];
  } else {
    List<String> words = ConfigManager.getWords();
    
    int dim = ConfigManager.getDimensions();
    words.retainWhere((w) => validateWord(w, dim));
        
    if (words.length < 1) {
      throw new Exception("You must have at least one word");
    }

    return words;
  }
}

bool validateWord(String word, int dim) {
  if (word.length == 0) {
    return false;
  }
  if (word.length > dim) {
    String errorMessage = "The word " + word + " is " + word.length.toString() 
        + " letters long, but the largest word that can fit on the grid is only "
        + dim.toString() + " letters long";
    throw new Exception(errorMessage);
  }
  
  // TODO Word should only contain chars from charset
  
  return true;
}