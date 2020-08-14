import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/pontuacao.dart';

class MyAppBarWidget extends StatelessWidget {
  final Pontuacao pontuacao;

  MyAppBarWidget({
    @required this.pontuacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("Jogo da Memória"),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      children: [Text("Time: "), Text(pontuacao.time)],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Score: "),
                        Text(this.pontuacao.score),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
