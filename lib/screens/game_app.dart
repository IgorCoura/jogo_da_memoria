import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/components/carta_widget.dart';
import 'package:jogo_da_memoria/components/game_over.dart';
import 'package:jogo_da_memoria/components/my_app_bar_widget.dart';
import 'package:jogo_da_memoria/models/carta.dart';
import 'package:jogo_da_memoria/models/pontuacao.dart';
import 'package:jogo_da_memoria/models/tabuleiro.dart';

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  Tabuleiro _tabuleiro = Tabuleiro(colunas: 5, linhas: 7);
  Pontuacao _pontuacao = Pontuacao();
  Carta _cartaAnterior;
  bool _timeAtivado = false;

  void _abrir(Carta carta) {
    if (_pontuacao.gameOver) {
      return;
    }
    if (!_timeAtivado) {
      _updateTime();
      _timeAtivado = true;
    }
    if (_cartaAnterior != null) {
      if (_cartaAnterior == carta) {
        return;
      }
      setState(() {
        carta.abrir();
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          if (_cartaAnterior.numIconRandom == carta.numIconRandom) {
            carta.esconder();
            _cartaAnterior.esconder();
            _pontuacao.addScore();
            _pontuacao.addSeconds();
          }
          _tabuleiro.fecharAll();
          _cartaAnterior = null;
          if (_tabuleiro.reiniciarTabela) {
            _reniciarTabuleiro();
          }
        });
      });
    } else {
      setState(() {
        carta.abrir();
        _cartaAnterior = carta;
      });
    }
  }

  void _reniciarTabuleiro() {
    _tabuleiro = new Tabuleiro(linhas: 7, colunas: 5);
    _pontuacao.multPontuacao();
  }

  void _updateTime() {
    setState(() {
      Timer(Duration(seconds: 1), () {
        setState(() {
          _pontuacao.fimDoTempo();
        });
        _pontuacao.secondsAdd();
        if (_pontuacao.gameOver) {
          return;
        }
        _updateTime();
      });
    });
  }

  void _reiniciarGame() {
    setState(() {
      _tabuleiro = new Tabuleiro(linhas: 7, colunas: 5);
      _pontuacao = new Pontuacao();
      _timeAtivado = false;
      _cartaAnterior = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: MyAppBarWidget(
                pontuacao: _pontuacao,
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
          GameOver(
            onReiniciar: _reiniciarGame,
            pontuacaoFinal: _pontuacao,
          ),
        ],
      ),
    );
  }
}
