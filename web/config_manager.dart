library configmanager;

import 'dart:html';
import 'direction.dart';

class ConfigManager {
  static String getLanguage() {
    SelectElement dropdown = query('#language');
    return dropdown.value;
  }
  
  static List<Direction> getDirections() {
    List<Direction> dirs = new List<Direction>();
    List<CheckboxInputElement> dirElements = queryAll('input[name="directions"]');
    for (CheckboxInputElement dir in dirElements) {
      dirs.add(Direction.getDir(dir.value));
    }
    
    return dirs;
  }
  
  static bool isInputAutomatic() {
    RadioButtonInputElement rb = query('#automatic-radio');
    return rb.checked;
  }
  
  static bool isInputManual() {
    RadioButtonInputElement rb = query('#manual-radio');
    return rb.checked;
  }
  
  static int getDimensions() {
    InputElement input = query("input[name='dimensions']");
    try {
      return int.parse(input.value);
    } on FormatException {
      throw new Exception("The dimension you entered is not a valid integer"); 
    }
  }
  
  static int getNumWords() {
    assert(isInputAutomatic());
    InputElement input = query('#num-words input[name="num-words"]');
    try {
      return int.parse(input.value);
    } on FormatException {
      throw new Exception("The number you entered is not a valid integer"); 
    }
  }
  
  static List<String> getWords() {
    TextAreaElement textArea = query("#input-words textarea[name='input-words']");
    return textArea.value.split("\\n");
  }
}