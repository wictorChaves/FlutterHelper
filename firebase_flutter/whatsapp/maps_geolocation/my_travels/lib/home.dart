import 'package:flutter/material.dart';
import 'package:mytravels/configs/main_configs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _travelsList = ["dfgsdfs1", "dfgsdfs2", "dfgsdfs3", "dfgsdfs4"];

  _openMap() {}

  _removeTravel() {}

  _adicionarLocal() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(APP_TITLE)),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xff0066cc),
            onPressed: _adicionarLocal),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: _travelsList.length,
                itemBuilder: (BuildContext context, int index) {
                  String title = _travelsList[index];
                  return GestureDetector(
                      onTap: _openMap,
                      child: Card(
                          child: ListTile(
                              title: Text(title),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                        onTap: _removeTravel,
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Icon(Icons.remove_circle,
                                                color: Colors.red)))
                                  ]))));
                }),
          )
        ]));
  }
}
