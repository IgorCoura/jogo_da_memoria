import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/carta.dart';

class CartaWidget extends StatelessWidget {
  final Carta carta;
  final Function(Carta) onAbrir;

  CartaWidget({
    @required this.carta,
    @required this.onAbrir,
  });

  Widget estadoDaCarta() {
    if (carta.aberto) {
      return Container(
        color: Colors.red,
        child: Icon(carta.oneIcon),
      );
    } else {
      return Container(
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return carta.existe
        ? InkWell(
            onTap: () => onAbrir(carta),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: estadoDaCarta(),
            ),
          )
        : Container(
            child: null,
          );
  }
}
