import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/components/carta_widget.dart';
import 'package:jogo_da_memoria/components/my_app_bar_widget.dart';
import 'package:jogo_da_memoria/models/carta.dart';
import 'package:jogo_da_memoria/models/my_app_bar.dart';
import 'package:jogo_da_memoria/models/tabuleiro.dart';

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  Tabuleiro _tabuleiro = Tabuleiro(colunas: 5, linhas: 7);
  MyAppBar _appBar = MyAppBar();
  Carta cartaAnterior;

  void _abrir(Carta carta) {
    if (cartaAnterior != null) {
      if (cartaAnterior == carta) {
        print("object");
        return;
      }
      setState(() {
        carta.abrir();
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          if (cartaAnterior.numIconRandom == carta.numIconRandom) {
            carta.esconder();
            cartaAnterior.esconder();
            _appBar.addScore();
          }
          _tabuleiro.fecharAll();
          cartaAnterior = null;
          if (_tabuleiro.reiniciarTabela) {
            _reniciar();
          }
        });
      });
    } else {
      setState(() {
        carta.abrir();
        cartaAnterior = carta;
      });
    }
  }

  void _reniciar() {
    _tabuleiro = new Tabuleiro(linhas: 7, colunas: 5);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: MyAppBarWidget(
            appBar: _appBar,
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          child: GridView.count(
            crossAxisCount: _tabuleiro.getColunas(),
            children: _tabuleiro.getListaCartas().map((e) {
              return CartaWidget(
                carta: e,
                onAbrir: _abrir,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
