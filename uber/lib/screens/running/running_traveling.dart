import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/model/request_model.dart';

class RunningTraveling extends StatefulWidget {
  RequestModel requestModel;

  RunningTraveling(this.requestModel);

  @override
  _RunningTravelingState createState() => _RunningTravelingState();
}

class _RunningTravelingState extends State<RunningTraveling> {
  ActiveRequestService _activeRequestService = ActiveRequestService();

  _cancelUber() async {
    DialogHelper.yesNo(context, "Finalizar", "Deseja finalizar Corrida?",
        () async {
      await _activeRequestService.FinishedRunning(widget.requestModel);
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
                    "Finalizar Corrida",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color(0xff1ebbd8),
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: _cancelUber)))
    ]);
  }
}
