import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Clientes"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset("images/detalhe_cliente.png"),
                  Padding(padding: EdgeInsets.all(8)),
                  Text("Clientes",
                      style: TextStyle(color: Color(0xffb9c941)))
                ],
              ),
              Padding(padding: EdgeInsets.all(16)),
              Image.asset("images/cliente1.png"),
              Text("Empresa de software"),
              Padding(padding: EdgeInsets.all(8)),
              Image.asset("images/cliente2.png"),
              Text("Empresa de consultoria"),
            ],
          ),
        ),
      ),
    );
  }
}
