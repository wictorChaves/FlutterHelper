import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes/helper/dialog_helper.dart';
import 'package:notes/main_settings.dart';
import 'package:notes/services/note_service.dart';

import 'model/note.dart';

class EditNote extends StatefulWidget {
  Note note;

  EditNote(this.note);

  @override
  _EditNoteState createState() => _EditNoteState(note);
}

class _EditNoteState extends State<EditNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  _EditNoteState(Note note) {
    _titleController.text = note.title;
    _contentController.text = note.content;
  }

  _saveItem() async {
    widget.note.title = _titleController.text;
    widget.note.content = _contentController.text;

    Response response = await NoteService().Put(widget.note);
    if (response.statusCode == 200) {
      DialogHelper.simple(
              context, "Tudo certo!", "Registro atualizado com sucesso!")
          .then((value) {
        _titleController.clear();
        _contentController.clear();
        Navigator.pop(context);
      });
    } else {
      DialogHelper.simple(context, "Erro!", "Erro tentar atualizar o registro!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar nota"),
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
