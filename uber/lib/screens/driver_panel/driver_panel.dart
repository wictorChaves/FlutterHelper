import 'package:flutter/material.dart';
import 'package:uber/screens/driver_panel/list_request.dart';
import 'package:uber/screens/shared/default_popup_menu.dart';
import 'package:uber/services/active_request_service.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/active_request_model.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/services/request_service.dart';
import 'package:uber/store/store.dart';

class DriverPanel extends StatefulWidget {
  @override
  _DriverPanelState createState() => _DriverPanelState();
}

class _DriverPanelState extends State<DriverPanel> {
  RequestService _requestService = RequestService();
  ActiveRequestService _activeRequestService = ActiveRequestService();

  _getActiveRequest() async {
    ActiveRequestModel activeRequestModel =
        await _activeRequestService.GetById(Store.userModel.uid);
    if (activeRequestModel != null) {
      if (activeRequestModel.status == StatusEnum.ON_MY_WAY) {
        RequestModel requestModel =
            await _requestService.GetById(activeRequestModel.uid_request);
        Navigator.pushReplacementNamed(context, "/corrida",
            arguments: requestModel);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getActiveRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Motorista"), actions: [DefaultPopupMenu()]),
        body: ListRequest());
  }
}
