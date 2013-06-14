library configmanager;

import 'dart:html';

class ConfigManager {
  static String getLanguage() {
    SelectElement dropdown = query('#language');
    return dropdown.value;
  }
  
  static List<CheckboxInputElement> getDirections() {
    return queryAll('input[name="directions"]');
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