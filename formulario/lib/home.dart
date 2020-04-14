import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _nameController = TextEditingController();
  bool _checkbox1 = false;
  bool _checkbox2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Formulário")
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Nome"
              ),
              controller: _nameController,
            ),
            Checkbox(
              value: _checkbox1,
              onChanged: (value){
                setState(() {
                  _checkbox1 = value;
                });
              },
            ),
            CheckboxListTile(
              value: _checkbox2,
              title: Text("Checkbox 2"),
              subtitle: Text("Sub titulo"),
              onChanged: (value){
                setState(() {
                  _checkbox2 = value;
                });
              },
            ),
            RaisedButton(
              child: Text("Salvar"),
              onPressed: (){
                print("Nome: " + _nameController.text);
                print("Checkbox 1: " + _checkbox1.toString());
                print("Checkbox 2: " + _checkbox2.toString());
              }
            )
          ],
        ),
      ),
    );
  }
}
