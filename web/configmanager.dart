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
    CheckboxInputElement cb = query('#automatic-radio');
    return cb.checked;
  }
  
  static bool isInputManual() {
    CheckboxInputElement cb = query('#manual-radio');
    return cb.checked;
  }
  
  static int getDimensions() {
    InputElement input = query("input[name='dimensions']");
    return int.parse(input.value);
  }
  
  static List<String> getWords() {
    TextAreaElement textArea = query("#input-words textarea[name='input-words']");
    return textArea.value.split("\\n");
  }
}