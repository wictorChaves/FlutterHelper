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
  int _radio1 = 1;
  String _radio2 = "masculino";
  bool _switch1 = false;
  bool _switch2 = false;
  double _slider = 5;
  String _sliderLavel = "5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Nome"),
                controller: _nameController,
              ),
              CheckboxListTile(
                value: _checkbox2,
                title: Text("Checkbox 2"),
                subtitle: Text("Sub titulo"),
                onChanged: (value) {
                  setState(() {
                    _checkbox2 = value;
                  });
                },
              ),
              SwitchListTile(
                value: _switch2,
                title: Text("Switch 2"),
                subtitle: Text("Sub titulo"),
                onChanged: (value) {
                  setState(() {
                    _switch2 = value;
                  });
                },
              ),
              RadioListTile(
                value: "masculino",
                groupValue: _radio2,
                title: Text("Masculino"),
                subtitle: Text("Sub titulo"),
                onChanged: (value) {
                  setState(() {
                    _radio2 = "masculino";
                  });
                },
              ),
              RadioListTile(
                value: "feminino",
                groupValue: _radio2,
                title: Text("Feminino"),
                subtitle: Text("Sub titulo"),
                onChanged: (value) {
                  setState(() {
                    _radio2 = "feminino";
                  });
                },
              ),
              Slider(
                value: _slider,
                min: 0,
                max: 10,
                divisions: 10,
                label: _sliderLavel,
                activeColor: Colors.blue,
                inactiveColor: Colors.blueGrey,
                onChanged: (value) {
                  setState(() {
                    _slider = value;
                    _sliderLavel = value.toString();
                  });
                },
              ),
              Row(children: [
                Checkbox(
                  value: _checkbox1,
                  onChanged: (value) {
                    setState(() {
                      _checkbox1 = value;
                    });
                  },
                ),
                Radio(
                  value: 1,
                  groupValue: _radio1,
                  onChanged: (value) {
                    setState(() {
                      _radio1 = 1;
                    });
                  },
                ),
                Radio(
                  value: 2,
                  groupValue: _radio1,
                  onChanged: (value) {
                    setState(() {
                      _radio1 = 2;
                    });
                  },
                ),
                Switch(
                  value: _switch1,
                  onChanged: (value) {
                    setState(() {
                      _switch1 = value;
                    });
                  },
                )
              ]),
              RaisedButton(
                  child: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    print("Nome: " + _nameController.text);
                    print("Checkbox 1: " + _checkbox1.toString());
                    print("Checkbox 2: " + _checkbox2.toString());
                    print("Radio 1: " + _radio1.toString());
                    print("Radio 2: " + _radio2.toString());
                    print("Switch 1: " + _switch1.toString());
                    print("Switch 2: " + _switch2.toString());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
