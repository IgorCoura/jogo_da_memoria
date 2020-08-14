import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/my_app_bar.dart';

class MyAppBarWidget extends StatelessWidget {
  final MyAppBar appBar;

  MyAppBarWidget({
    @required this.appBar,
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
                      children: [Text("Time: "), Text("0000")],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Score: "),
                        Text(this.appBar.score),
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
