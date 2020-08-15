import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/screens/tela_inicial.dart';

import 'screens/game_app.dart';

void main() => runApp(MaterialApp(
      title: "Nome das rotas",
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
        '/second': (context) => GameApp(),
      },
      debugShowCheckedModeBanner: false,
    ));
