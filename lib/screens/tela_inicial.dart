import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String _record = "0000";

  void _pegarRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int temp = (prefs.getInt('record') ?? 0);
    setState(() {
      if (temp < 10) {
        _record = "000" + temp.toString();
      } else if (temp < 100) {
        _record = "00" + temp.toString();
      } else if (temp < 1000) {
        _record = "0" + temp.toString();
      } else {
        _record = temp.toString();
      }
    });
  }

  _TelaInicialState() {
    _pegarRecord();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Jogo da Mémoria",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "record:" + _record,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.pushNamed(context, '/second'),
                child: Text(
                  "Iniciar",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
