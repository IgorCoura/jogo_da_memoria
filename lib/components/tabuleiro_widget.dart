import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/components/carta_widget.dart';
import 'package:jogo_da_memoria/models/tabuleiro.dart';
import '../models/carta.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Carta) onAbrir;

  TabuleiroWidget({
    @required this.tabuleiro,
    @required this.onAbrir,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.getColunas(),
        children: tabuleiro.getListaCartas().map((e) {
          return CartaWidget(
            carta: e,
            onAbrir: onAbrir,
          );
        }).toList(),
      ),
    );
  }
}
