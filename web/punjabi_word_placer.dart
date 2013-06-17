import 'word_placer.dart';
import 'grid.dart';
import 'direction.dart';

class PunjabiWordPlacer extends WordPlacer {
  PunjabiWordPlacer(Grid g, List<Direction> d) : super.init(g, d);

  static const List<String> _LETTERS = const ["a","A","e","s","h","k","K","g","G","|","c","C","j","J","\\","t","T","f","F","x","q","Q","d","D","n","p","P","b","B","m","X","r","l","v","V","S","^","Z","z","&"];
  static const List<String> _VOWELS = const ["i","I","O","o","Y","y","u","U","w"];

  static const double _VOWEL_PROBABILITY = 0.4;
  
  int getWordLength(String word) {
    return _countLetters(word);
  }
  
  void putWordInGrid(String word, int row, int col, Direction dir) {
    
  }
  
  String randLetter() {
    double val = r.nextDouble();
    if (val > _VOWEL_PROBABILITY) {
      // TODO Return a vowel with a compatible letter
      return _LETTERS[r.nextInt(_LETTERS.length)]; 
    } else {
      return _LETTERS[r.nextInt(_LETTERS.length)]; 
    }
  }
  
  int _countLetters(String word) {
    int numLetters = 0;
    for (int i = 0; i < word.length; i++) {
      if (_isLetter(word[i])) {
        numLetters++;
      }
    }
    return numLetters;
  }
  
  bool _isLetter(String letter) {
    assert(letter.length == 1);
    if (_LETTERS.contains(letter)) {
      return true;
    } else {
      return false;
    }
  }
}