import 'package:flutter/material.dart';
import 'package:uber/screens/passanger_panel/call_uber.dart';
import 'package:uber/screens/passanger_panel/cancel_uber.dart';
import 'package:uber/screens/passanger_panel/passager_map.dart';
import 'package:uber/screens/passanger_panel/traveling_uber.dart';
import 'package:uber/screens/passanger_panel/wait_uber.dart';
import 'package:uber/screens/shared/default_popup_menu.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/store/store.dart';

import 'finished_uber.dart';
import 'on_my_way_uber.dart';

class PassangerPanel extends StatefulWidget {
  @override
  _PassangerPanelState createState() => _PassangerPanelState();
}

class _PassangerPanelState extends State<PassangerPanel> {

  ActiveRequestService _activeRequestService = ActiveRequestService();
  ActiveRequestModel _activeRequestModel = null;

  _getActiveRequest() async {
    _activeRequestService.ListenById(Store.userModel.uid).listen((event) {
      setState(() {
        _activeRequestModel = (event.data == null)
            ? null
            : ActiveRequestModel.fromJson(event.data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getActiveRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Passageiro"), actions: [DefaultPopupMenu()]),
        body: Container(child: Stack(children: [PassagerMap(), _view()])));
  }

  Widget _view() {
    if (_activeRequestModel == null) {
      return CallUber();
    }
    switch (_activeRequestModel.status) {
      case StatusEnum.WAIT:
        return WaitUber();
      case StatusEnum.ON_MY_WAY:
        return OnMyWayUber();
      case StatusEnum.TRAVELING:
        return TravelingUber();
      case StatusEnum.FINISHED:
        return FinishedUber();
      case StatusEnum.CANCELED:
        return CancelUber();
    }
    return CallUber();
  }

}
