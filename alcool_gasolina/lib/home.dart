import 'package:flutter/material.dart';
import 'MainHelper.dart';

const APPTITLE = "Alcool ou gasolina";
const PRIMARYCOLOR = Colors.blue;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APPTITLE),
        backgroundColor: PRIMARYCOLOR,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 50),
                child: Image(image: AssetImage("images/logo.png")),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Saiva qual a melhor opção para abastecimento do seu carro",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                    controller: alcoolController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Preço Alcool, ex 1.59",
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                    controller: gasolinaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Preço Gasolina, ex 3.15",
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  color: PRIMARYCOLOR,
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    var alcoolValue = double.tryParse(
                        alcoolController.text.replaceAll(",", "."));
                    var gasolinaValue = double.tryParse(
                        gasolinaController.text.replaceAll(",", "."));

                    if (alcoolValue == null)
                      return Helper.dialog(
                          context, "Alerta!", "Valor do alcool inválido!");
                    if (gasolinaValue == null)
                      return Helper.dialog(
                          context, "Alerta!", "Valor da gasolina inválido!");
                    var combustivel = (alcoolValue / gasolinaValue >= 0.7)
                        ? "gasolina"
                        : "alcool";
                    Helper.dialog(context, "Resultado",
                        "É melhor abastecer com $combustivel");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
