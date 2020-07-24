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

  _getPassager() async {
    DialogHelper.yesNo(context, "Viajar", "Você está com o passageiro?",
        () async {
      await _activeRequestService.TrevilingRunning(widget.requestModel);
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
                    "Pegar passageiro",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color(0xff1ebbd8),
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: _getPassager)))
    ]);
  }
}
