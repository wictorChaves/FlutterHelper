import 'package:annotations/model/annotation.dart';
import 'package:annotations/services/annotation_service.dart';
import 'package:flutter/material.dart';

import 'configs.dart';
import 'helper/datetime_helper.dart';
import 'helper/dialog_helper.dart';
import 'helper/listview_helper.dart';
import 'helper/widget_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AnnotationService _annotationService;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  _HomeState() {
    _annotationService = AnnotationService();
  }

  Widget _itemList(context, Annotation annotation) {
    return ListTile(
        title: Text(annotation.title),
        subtitle: Text(_formatSubtitle(annotation)),
        trailing: Wrap(spacing: 12, children: [
          GestureDetector(
              onTap: () => _saveDialog(context, annotation: annotation),
              child: Icon(Icons.edit, color: Colors.green)),
          GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text("Excluir"),
                          content: Text("Deseja exluir este registro?"),
                          actions: [
                            FlatButton(
                              child: Text("Cancelar"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                                child: Text("Excluir"),
                                onPressed: () {
                                  _annotationService.Delete(annotation.id)
                                      .then((int id) {
                                    Navigator.pop(context);
                                    setState(() {});
                                  });
                                })
                          ]);
                    });
              },
              child: Icon(Icons.remove_circle, color: Colors.red))
        ]));
  }

  String _formatSubtitle(Annotation annotation) {
    String date = annotation.getUpdateDatetimeDateBr();
    String content = ListviewHelper.limitText(annotation.content, 30);
    return date + " - " + content;
  }

  _saveDialog(context, {Annotation annotation}) {
    String title =
        (annotation == null) ? "Adicionar anotação" : "Editar anotação";
    String btnLabel = (annotation == null) ? "Salvar" : "Atualizar";
    _titleController.text = (annotation == null) ? "" : annotation.title;
    _contentController.text = (annotation == null) ? "" : annotation.content;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(title),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                    decoration: InputDecoration(labelText: "Titulo", hintText: "Digite o título"),
                    onChanged: (text) {},
                    controller: _titleController),
                TextField(
                    decoration: InputDecoration(labelText: "Descrição", hintText: "Digite a Descrição"),
                    onChanged: (text) {},
                    controller: _contentController)
              ]),
              actions: [
                FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () => Navigator.pop(context)),
                FlatButton(
                    child: Text(btnLabel),
                    onPressed: () {
                      if (annotation == null) {
                        _annotationService.Add(Annotation.New(
                                _titleController.text, _contentController.text))
                            .then((int id) {
                          setState(() {});
                          Navigator.pop(context);
                        });
                      } else {
                        annotation.title = _titleController.text;
                        annotation.content = _contentController.text;
                        _annotationService.Update(annotation).then((int id) {
                          setState(() {});
                          Navigator.pop(context);
                        });
                      }
                    })
              ]);
        });
  }

  Widget _futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return WidgetHelper.loading(PRIMARY_COLOR);
        break;
      case ConnectionState.active:
      case ConnectionState.done:
        if (snapshot.hasError) {
          DialogHelper.simple(context, "Alerta!", "lista: Erro ao carregar ");
        } else {
          return _futureBuilderDone(snapshot.data);
        }
        break;
    }
  }

  Widget _futureBuilderDone(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => _itemList(context, data[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(APPNAME), backgroundColor: PRIMARY_COLOR),
        body: FutureBuilder(
            future: _annotationService.GetAll(), builder: _futureBuilder),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _saveDialog(context),
            backgroundColor: PRIMARY_COLOR,
            child: Icon(
              Icons.add,
              color: Colors.white,
            )));
  }
}
