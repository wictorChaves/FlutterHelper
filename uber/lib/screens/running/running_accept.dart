import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/store/store.dart';

class RunningAccept extends StatefulWidget {
  RequestModel requestModel;

  RunningAccept(this.requestModel);

  @override
  _RunningAcceptState createState() => _RunningAcceptState();
}

class _RunningAcceptState extends State<RunningAccept> {
  ActiveRequestService _activeRequestService = ActiveRequestService();

  _cancelUber() async {
    DialogHelper.yesNo(context, "Aceitar", "Deseja aceitar a corrida?",
        () async {
      await _activeRequestService.AcceptRunning(widget.requestModel);
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
                    "Aceitar corrida",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color(0xff1ebbd8),
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: _cancelUber)))
    ]);
  }
}
