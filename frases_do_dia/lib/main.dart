import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeStateFul(),
  ));
}

class HomeStateFul extends StatefulWidget {
  @override
  _HomeStateFulState createState() => _HomeStateFulState();
}

class _HomeStateFulState extends State<HomeStateFul> {

  var _texto = "Wictor de Oliveira";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Frases do dia"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              onPressed: (){
                setState(() {
                  _texto = "Curso Flutter";
                });
              },
              color: Colors.amber,
              child: Text("Clique aqui"),
            ),
            Text("Nome: $_texto")
          ],
        ),
      )
    );

  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var _titulo = "Frases do dia";

    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        backgroundColor: Colors.green,
      ),
      body: Text("Conteúdo"),
      bottomNavigationBar: BottomAppBar(),
    );

  }
}
