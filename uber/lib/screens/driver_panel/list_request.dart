import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/component/widget_helper.dart';
import 'package:uber/services/enum/status_enum.dart';
import 'package:uber/services/model/request_model.dart';
import 'package:uber/services/request_service.dart';

class ListRequest extends StatefulWidget {
  @override
  _ListRequestState createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  RequestService _requestService = RequestService();

  Stream<QuerySnapshot> _listenerRequest() {
    _requestService.ListenByStatus(StatusEnum.WAIT).listen((data) {
      _controller.add(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _listenerRequest();
  }

  Widget _streamBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return WidgetHelper.loading(Colors.blue);
      case ConnectionState.active:
      case ConnectionState.done:
        return _streamBuilderDone(context, snapshot);
      default:
        return WidgetHelper.loading(Colors.blue);
    }
  }

  Widget _streamBuilderDone(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return Text("Erro ao carregar os dados!");
    }

    if (snapshot.data.documents.length == 0) {
      return Text("Você não tem nenhuma requisição :(");
    }

    return _list(snapshot);
  }

  Widget _list(AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView.separated(
        itemCount: snapshot.data.documents.length,
        separatorBuilder: _separatorBuilder,
        itemBuilder: (context, index) {
          List<DocumentSnapshot> requests = snapshot.data.documents.toList();
          RequestModel requestModel =
              RequestModel.fromJson(requests[index].data);

          return _itemListRequestModel(requestModel);
        });
  }

  Widget _itemListRequestModel(RequestModel requestModel) {
    return ListTile(
      onTap: () =>
          Navigator.pushNamed(context, "/corrida", arguments: requestModel),
      title: Text(requestModel.passanger.name),
      subtitle: Text(
          "destino: ${requestModel.destiny.street}, ${requestModel.destiny.number}"),
    );
  }

  Widget _separatorBuilder(context, index) {
    return Divider(height: 2, color: Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _controller.stream, builder: _streamBuilder);
  }
}
