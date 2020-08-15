import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_da_memoria/components/game_over.dart';
import 'package:jogo_da_memoria/components/my_app_bar_widget.dart';
import 'package:jogo_da_memoria/components/tabuleiro_widget.dart';
import 'package:jogo_da_memoria/models/carta.dart';
import 'package:jogo_da_memoria/models/pontuacao.dart';
import 'package:jogo_da_memoria/models/tabuleiro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  Tabuleiro _tabuleiro;
  Pontuacao _pontuacao = Pontuacao();
  Carta _cartaAnterior;
  bool _timeAtivado = false;
  int _linhas, _colunas, _record;

  Tabuleiro _getTabuleiro(double altura, double largura) {
    _colunas = 5;
    double tamanhoCampo = largura / _colunas;
    _linhas = (altura / tamanhoCampo).floor();
    if (_tabuleiro == null) {
      _tabuleiro = Tabuleiro(linhas: _linhas, colunas: _colunas);
    }
    return _tabuleiro;
  }

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
    _tabuleiro = new Tabuleiro(linhas: _linhas, colunas: _colunas);
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
          _novoRecord(_pontuacao.scoreInt);
          _pegarRecord();
          return;
        }
        _updateTime();
      });
    });
  }

  void _reiniciarGame() {
    setState(() {
      _tabuleiro = new Tabuleiro(linhas: _linhas, colunas: _colunas);
      _pontuacao = new Pontuacao();
      _timeAtivado = false;
      _cartaAnterior = null;
    });
  }

  void _novoRecord(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if ((prefs.getInt('record') ?? 0) < score) {
        prefs.setInt('record', score);
      }
    });
  }

  void _pegarRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _record = (prefs.getInt('record') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
            body: LayoutBuilder(builder: (ctx, constraints) {
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(
                  constraints.maxHeight,
                  constraints.maxWidth,
                ),
                onAbrir: _abrir,
              );
            }),
          ),
          GameOver(
            onReiniciar: _reiniciarGame,
            pontuacaoFinal: _pontuacao,
            record: _record,
          ),
        ],
      ),
    );
  }
}
