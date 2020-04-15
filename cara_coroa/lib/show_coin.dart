import 'package:flutter/material.dart';

class ShowCoin extends StatefulWidget {

  String srcImage;

  ShowCoin(this.srcImage);

  @override
  _ShowCoinState createState() => _ShowCoinState();

}

class _ShowCoinState extends State<ShowCoin> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff61bd8c),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.srcImage),
          Padding(padding: EdgeInsets.all(15)),
          GestureDetector(
            child: Image.asset("images/botao_voltar.png"),
            onTap: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
