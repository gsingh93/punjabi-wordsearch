import 'dart:html';
import 'grid.dart';
import 'config_manager.dart' as ConfigManager;
import 'dart:js';

const int BUTTON_SIZE = 25;

const int MIN_DIM = 5;
const int MAX_DIM = 20;

void main() {
  int width = getDimensions() * BUTTON_SIZE;
  width += 600;
  querySelector('#content-inner')..style.width = width.toString() + "px";
  
  initListeners();
}

void initListeners() {
  querySelector('#generate')..onClick.listen((e) => generate());
  querySelector('#language')..onChange.listen((e) => changeLang());
}

void toggleVisibility(String element, [bool block = true]) {
  var el = querySelector(element);
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
    // TODO Display Punjabi keyboard
    querySelector('#input-words').classes.add('punjabi');
  } else {
    querySelector('#input-words').classes.remove('punjabi');
  }
}

void setLanguage() {
  String lang = ConfigManager.getLanguage();
  DivElement wordSearch = querySelector('#wordsearch');
  if (lang == "punjabi") {
    wordSearch.classes.add('punjabi');
  } else {
    wordSearch.classes.remove('punjabi');
  }
}

void generate() {
  try {
    querySelector('#download-image').style.visibility = 'hidden';
    int dim = getDimensions();    
    List<String> words = getWords();
    Grid grid = createGrid(dim, words);
    setLanguage();
    grid.display();
    displayWords(words);
    generateImage();
    querySelector('#download-image').style.visibility = 'visible';
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
  OListElement list = querySelector("#words");
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
    List<String> words = ConfigManager.getWords();
    
    int dim = ConfigManager.getDimensions();
    words.retainWhere((w) => validateWord(w, dim));
        
    if (words.length < 1) {
      throw new Exception("You must have at least one word");
    }

    return words;
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

void generateImage() {
  context.callMethod('createImage');
}