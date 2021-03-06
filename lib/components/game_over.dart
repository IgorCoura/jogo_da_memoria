import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/pontuacao.dart';

class GameOver extends StatelessWidget {
  final Pontuacao pontuacaoFinal;
  final void Function() onReiniciar;
  final int record;

  GameOver({
    @required this.pontuacaoFinal,
    @required this.onReiniciar,
    @required this.record,
  });

  String get _recordToString {
    if (record < 10) {
      return "000" + record.toString();
    } else if (record < 100) {
      return "00" + record.toString();
    } else if (record < 1000) {
      return "0" + record.toString();
    } else {
      return record.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return pontuacaoFinal.gameOver
        ? Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.9),
              borderRadius: BorderRadius.circular(30),
            ),
            width: 300,
            height: 300,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "GameOver",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Score:",
                                      style: TextStyle(
                                        fontSize: 38,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      " " + pontuacaoFinal.score,
                                      style: TextStyle(
                                        fontSize: 35,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Record:",
                                      style: TextStyle(
                                        fontSize: 24,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      " " + _recordToString,
                                      style: TextStyle(
                                        fontSize: 22,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              color: Colors.red,
                              onPressed: () => onReiniciar(),
                              child: Text(
                                "Reiniciar",
                                style: TextStyle(
                                  fontSize: 24,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )
        : Container();
  }
}
