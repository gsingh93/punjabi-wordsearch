library config_manager;

import 'dart:html';
import 'direction.dart';

String getLanguage() {
  SelectElement dropdown = querySelector('#language');
  return dropdown.value;
}

List<Direction> getDirections() {
  List<Direction> dirs = new List<Direction>();
  List<CheckboxInputElement> dirElements = querySelectorAll('input[name="directions"]');
  for (CheckboxInputElement dir in dirElements) {
    dirs.add(Direction.getDir(dir.value));
  }
  
  return dirs;
}

int getDimensions() {
  InputElement input = querySelector("input[name='dimensions']");
  try {
    return int.parse(input.value);
  } on FormatException {
    throw new Exception("The dimension you entered is not a valid integer"); 
  }
}

List<String> getWords() {
  TextAreaElement textArea = querySelector("#input-words textarea[name='input-words']");
  return textArea.value.split("\n");
}