import 'dart:async';

class Game{
  static int tries = 0;
  static List<String> selectedChar = [];

  final List<String> words_list;
  static final Set<String> letter = new Set<String>();

  late List<String> _guess;
  late int _wrongGuess;

  StreamController<Null> _Win = new StreamController<Null>.broadcast();
  Stream<Null> get Win => _Win.stream;

  StreamController<Null> _Lose = new StreamController<Null>.broadcast();
  Stream<Null> get Lose => _Lose.stream;

  StreamController<int> _Wrong = new StreamController<int>.broadcast();
  Stream<int> get Wrong => _Wrong.stream;

  StreamController<String> _Right = new StreamController<String>.broadcast();
  Stream<String> get Right => _Right.stream;

  StreamController<String> _Change = new StreamController<String>.broadcast();
  Stream<String> get Change => _Change.stream;

  Game(List<String> words) : words_list = new List<String>.from(words);

  int get wrongGuess => _wrongGuess;
  List<String> get guess => _guess;
  String get fullWord => guess.join();

  String get wordForDisplay => guess.map((String letter) =>
  letter.contains(letter) ? letter : "_").join();

  bool get isWordComplete {
    for (String letter in _guess) {
      if (!letter.contains(letter)) {
        return false;
      }
    }

    return true;
  }
  void newGame() {
    words_list.shuffle();
    _guess = words_list.first.split('');
    _wrongGuess = 0;
    letter.clear();
    _Change.add(wordForDisplay);
  }

  void guessLetter(String letter) {
    _guess.add(letter);

    if (_guess.contains(letter)) {
      _Right.add(letter);

      if (isWordComplete) {
        _Change.add(fullWord);
        _Win.add(null);
      }
      else {
        _Change.add(wordForDisplay);
      }
    }
    else {
      _wrongGuess++;

      _Wrong.add(_wrongGuess);

      if (_wrongGuess == tries) {
        _Change.add(fullWord);
        _Lose.add(null);
      }
    }
  }
  void EndGame() {
    _Win.close();
    if (_wrongGuess == 8) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('GAME OVER'),
            content: Text('YOU HAVE LOST THE GAME'),
            actions: <Widget>[
              FlatButton(
                child: Text('New Game'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    _Wrong.close();
    _Right.close();
    _Change.close();
  }

}