import 'package:flutter/material.dart';
import 'package:tasklist/services/task_service.dart';

import 'configs/colors.dart';
import 'model/task.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> _taskList = [];
  TaskService _taskService;
  TextEditingController taskController = TextEditingController();

  _HomeState() {
    _taskService = TaskService();
  }

  _add() {
    setState(() => _taskList.add(Task(taskController.text, false)));
    _save();
    Navigator.pop(context);
  }

  _check(index, value) {
    _taskList[index].done = value;
    _save();
  }

  _save() {
    _taskService.Save(_taskList);
  }

  Widget _itemList(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        var deletedItem = _taskList[index];
        _taskList.removeAt(index);
        _save();

        final snackBar = SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Tarefa removida!"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() => _taskList.insert(index, deletedItem));
              _save();
            },
          ),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      background: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.delete, color: Colors.white)])),
      child: CheckboxListTile(
          activeColor: PRIMARY_COLOR,
          value: _taskList[index].done,
          title: Text(_taskList[index].title),
          onChanged: (value) => setState(() => _check(index, value))),
    );
  }

  @override
  Future<void> initState() {
    super.initState();
    _taskService.GetAll().then((taskList) => _taskList = taskList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Lista de tarefas"), backgroundColor: PRIMARY_COLOR),
        body: Container(
            child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _taskList.length, itemBuilder: _itemList))
        ])),
        floatingActionButton: FloatingActionButton(
            backgroundColor: PRIMARY_COLOR,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text("Adicionar Tarefa"),
                        content: TextField(
                            decoration:
                                InputDecoration(labelText: "Digite sua tarefa"),
                            onChanged: (text) {},
                            controller: taskController),
                        actions: [
                          FlatButton(
                              child: Text("Cancelar"),
                              onPressed: () => Navigator.pop(context)),
                          FlatButton(child: Text("salvar"), onPressed: _add)
                        ]);
                  });
            },
            child: Icon(Icons.add)));
  }
}
