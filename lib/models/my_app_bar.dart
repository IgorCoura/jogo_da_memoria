class MyAppBar {
  int _score = 0;
  final DateTime _time = DateTime.now();

  void addScore() {
    _score += 2;
  }

  String get score {
    if (_score < 10) {
      return "000" + _score.toString();
    } else if (_score < 100) {
      return "00" + _score.toString();
    } else if (_score < 1000) {
      return "0" + _score.toString();
    } else {
      return _score.toString();
    }
  }

  String get time {
    return _time.toString();
  }
}
