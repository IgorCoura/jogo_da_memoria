class Pontuacao {
  int _score = 0;
  int _seconds = 100;
  int _addSeconds = 10;
  int _multPontuacao = 1;
  bool _gameOver = false;

  void addScore() {
    _score += _multPontuacao;
  }

  void multPontuacao() {
    _multPontuacao *= 2;
    _addSeconds ~/= 2;
  }

  void addSeconds() {
    _seconds += _addSeconds;
  }

  void secondsAdd() {
    _seconds--;
  }

  void fimDoTempo() {
    if (_seconds <= 0) {
      _gameOver = true;
    }
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
    if (_seconds >= 100) {
      return "0" + _seconds.toString();
    } else if (_seconds >= 10) {
      return "00" + _seconds.toString();
    } else if (_seconds >= 0) {
      return "000" + _seconds.toString();
    } else {
      return "0000";
    }
  }

  bool get gameOver {
    return _gameOver;
  }
}
