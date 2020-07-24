import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/store/store.dart';

class RunningOnMyWay extends StatefulWidget {
  RequestModel requestModel;

  RunningOnMyWay(this.requestModel);

  @override
  _RunningOnMyWayState createState() => _RunningOnMyWayState();
}

class _RunningOnMyWayState extends State<RunningOnMyWay> {
  ActiveRequestService _activeRequestService = ActiveRequestService();

  _cancelUber() async {
    DialogHelper.yesNo(context, "Cancelar", "Deseja cancelar a corrida?",
        () async {
      await _activeRequestService.CancelRunning(widget.requestModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Padding(
              padding: Platform.isIOS
                  ? EdgeInsets.fromLTRB(20, 10, 20, 25)
                  : EdgeInsets.all(10),
              child: RaisedButton(
                  child: Text(
                    "A caminho do passageiro",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.red,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: _cancelUber)))
    ]);
  }
}
