import 'package:flutter/material.dart';
import 'package:uber/screens/running/running_accept.dart';
import 'package:uber/screens/running/running_map.dart';
import 'package:uber/screens/running/running_on_my_way.dart';
import 'package:uber/screens/running/running_traveling.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/store/store.dart';

class Running extends StatefulWidget {
  RequestModel requestModel;

  Running(this.requestModel);

  @override
  _RunningState createState() => _RunningState();
}

class _RunningState extends State<Running> {
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
        appBar: AppBar(title: Text("Painel corrida")),
        body: Container(
            child:
                Stack(children: [RunningMap(widget.requestModel), _view()])));
    ;
  }

  Widget _view() {
    if (_activeRequestModel == null) {
      return RunningAccept(widget.requestModel);
    }
    switch (_activeRequestModel.status) {
      case StatusEnum.WAIT:
        return RunningAccept(widget.requestModel);
      case StatusEnum.ON_MY_WAY:
        return RunningOnMyWay(widget.requestModel);
      case StatusEnum.TRAVELING:
        return RunningTraveling(widget.requestModel);
      case StatusEnum.FINISHED:
        return RunningAccept(widget.requestModel);
      case StatusEnum.CONFIRMED:
        return RunningAccept(widget.requestModel);
      case StatusEnum.CANCELED:
        return RunningAccept(widget.requestModel);
    }
    return RunningAccept(widget.requestModel);
  }
}
