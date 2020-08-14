import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Carta {
  bool _aberto = false;
  bool _existe = true;

  final List<IconData> listIcons = [
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.account_circle,
    Icons.add,
    Icons.airline_seat_flat,
    Icons.all_inclusive,
    Icons.bluetooth,
    Icons.block,
  ];

  int _numIconRandom = Random().nextInt(8);

  void abrir() {
    if (_aberto) {
      return;
    }
    _aberto = true;
  }

  void fechar() {
    if (_aberto) {
      _aberto = false;
    }
  }

  void esconder() {
    _existe = !_existe;
  }

  bool get aberto {
    return _aberto;
  }

  bool get existe {
    return _existe;
  }

  IconData get oneIcon {
    return listIcons[_numIconRandom];
  }

  int get numIconRandom {
    return _numIconRandom;
  }
}
