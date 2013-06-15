library config_manager;

import 'dart:html';
import 'direction.dart';

String getLanguage() {
  SelectElement dropdown = query('#language');
  return dropdown.value;
}

List<Direction> getDirections() {
  List<Direction> dirs = new List<Direction>();
  List<CheckboxInputElement> dirElements = queryAll('input[name="directions"]');
  for (CheckboxInputElement dir in dirElements) {
    dirs.add(Direction.getDir(dir.value));
  }
  
  return dirs;
}

bool isInputAutomatic() {
  RadioButtonInputElement rb = query('#automatic-radio');
  return rb.checked;
}

bool isInputManual() {
  RadioButtonInputElement rb = query('#manual-radio');
  return rb.checked;
}

int getDimensions() {
  InputElement input = query("input[name='dimensions']");
  try {
    return int.parse(input.value);
  } on FormatException {
    throw new Exception("The dimension you entered is not a valid integer"); 
  }
}

int getNumWords() {
  assert(isInputAutomatic());
  InputElement input = query('#num-words input[name="num-words"]');
  try {
    return int.parse(input.value);
  } on FormatException {
    throw new Exception("The number you entered is not a valid integer"); 
  }
}

List<String> getWords() {
  TextAreaElement textArea = query("#input-words textarea[name='input-words']");
  return textArea.value.split("\\n");
}