import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes/add_note.dart';
import 'package:notes/edit_note.dart';
import 'package:notes/services/note_service.dart';

import 'helper/dialog_helper.dart';
import 'main_settings.dart';
import 'model/note.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _loadValues() async {
    Response response = await NoteService().Get();
    return json.decode(response.body);
  }

  _addNote() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote()));
  }

  _removeNote(Note note) async {
    DialogHelper.yesNo(context, "Excluir", "Deseja excluir este registro?", () async {
      Response response = await NoteService().Delete(note.id);
      if (response.statusCode == 200) {
        DialogHelper.simple(
            context, "Tudo certo!", "Registro excluído com sucesso!");
        setState(() {});
      } else {
        DialogHelper.simple(context, "Erro!", "Erro ao tentar excluir o registro!");
      }
    });
  }

  Widget _loading() {
    return Center(
        child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(MainSettings.PrimatyColor)));
  }

  Widget _list(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          var note = Note.fromJson(snapshot.data[index]);
          return ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditNote(note)));
              },
              onLongPress: () => _removeNote(note),
              title: Text(note.title),
              subtitle: Text((note.content.length >= 30)
                  ? note.content.substring(0, 30) + "..."
                  : note.content));
        });
  }

  Widget _futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return _loading();
        break;
      case ConnectionState.active:
      case ConnectionState.done:
        if (snapshot.hasError) {
          DialogHelper.simple(context, "Alerta!", "lista: Erro ao carregar ");
        } else {
          return _list(context, snapshot);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloco de notas"),
        backgroundColor: MainSettings.PrimatyColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: MainSettings.PrimatyColor,
              child: Text(
                "Adicionar",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _addNote,
            ),
            Expanded(
                child: FutureBuilder(
                    future: _loadValues(), builder: _futureBuilder)),
          ],
        ),
      ),
    );
  }
}
