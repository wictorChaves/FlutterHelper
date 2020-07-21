import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uber/component/dialog_helper.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/store/store.dart';

class WaitUber extends StatefulWidget {
  @override
  _WaitUberState createState() => _WaitUberState();
}

class _WaitUberState extends State<WaitUber> {
  ActiveRequestService _activeRequestService = ActiveRequestService();

  _cancelUber() async {
    DialogHelper.yesNo(context, "Cancelar", "Deseja cancelar a corrida?",
        () async {
      ActiveRequestModel activeRequestModel =
          await _activeRequestService.GetById(Store.userModel.uid);
      activeRequestModel.status = StatusEnum.CANCELED;
      await _activeRequestService.CreateOrUpdate(activeRequestModel);
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
                    "Cancelar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.red,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: _cancelUber)))
    ]);
  }
}
