import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes/helper/dialog_helper.dart';
import 'package:notes/main_settings.dart';
import 'package:notes/services/note_service.dart';

import 'model/note.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  _saveItem() async {
    var note = Note.Simple(_titleController.text, _contentController.text);
    Response response = await NoteService().Post(note);
    if (response.statusCode == 201) {
      DialogHelper.simple(
              context, "Tudo certo!", "Registro incluído com sucesso!")
          .then((value) {
        _titleController.clear();
        _contentController.clear();
        Navigator.pop(context);
      });
    } else {
      DialogHelper.simple(context, "Erro!", "Erro ao incluir o registro!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nova nota"),
          backgroundColor: MainSettings.PrimatyColor,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Titulo"),
                controller: _titleController,
              ),
              Expanded(
                  child: Container(
                height: double.infinity,
                child: TextField(
                  decoration: InputDecoration(labelText: "Conteúdo"),
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _contentController,
                ),
              )),
              RaisedButton(
                onPressed: _saveItem,
                color: MainSettings.PrimatyColor,
                child: Text("Salvar", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ));
  }
}
