import 'package:atmconsultoria/client.dart';
import 'package:atmconsultoria/company.dart';
import 'package:atmconsultoria/contact.dart';
import 'package:atmconsultoria/service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ATM Consultoria"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Image.asset("images/logo.png"),
              onTap: (){ print("logo"); },
            ),
            Padding(padding: EdgeInsets.all(18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset("images/menu_empresa.png"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Company()
                    ));
                  },
                ),
                Padding(padding: EdgeInsets.all(18)),
                GestureDetector(
                  child: Image.asset("images/menu_servico.png"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Service()
                    ));
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset("images/menu_cliente.png"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Client()
                    ));
                  },
                ),
                Padding(padding: EdgeInsets.all(18)),
                GestureDetector(
                  child: Image.asset("images/menu_contato.png"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Contact()
                    ));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
