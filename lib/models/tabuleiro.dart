import 'package:flutter/cupertino.dart';

import 'carta.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  List<Carta> _listCartas = [];
  bool _reniciarTabela = false;

  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
  }) {
    _criarCartas();
  }

  void _criarCartas() {
    for (int i = 0; i < linhas; i++) {
      for (int j = 0; j < colunas; j++) {
        _listCartas.add(Carta());
      }
    }
  }

  void fecharAll() {
    int contador = 0;
    for (int i = 0; i < _listCartas.length; i++) {
      if (!_listCartas[i].existe) {
        contador++;
      }
      _listCartas[i].fechar();
    }
    if (contador >= (linhas * colunas) * (2 / 3)) {
      _reniciarTabela = true;
    }
  }

  List<Carta> getListaCartas() {
    return _listCartas;
  }

  int getColunas() {
    return colunas;
  }

  bool get reiniciarTabela {
    return _reniciarTabela;
  }
}
