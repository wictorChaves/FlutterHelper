import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytravels/configs/main_configs.dart';
import 'package:mytravels/map_screen.dart';
import 'package:mytravels/services/model/travel_model.dart';
import 'package:mytravels/services/travel_service.dart';

import 'helper/widget_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TravelService _travelService = TravelService();
  final StreamController _streamController =
      StreamController<QuerySnapshot>.broadcast();

  _openMap(TravelModel travel) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => MapScreen(travel: travel)));
  }

  _removeTravel(TravelModel travel) {
    _travelService.Delete(travel.uid);
  }

  _addLocal() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
  }

  _addTravel() async {
    var stream = _travelService.ListenAll();
    stream.listen((data) {
      _streamController.add(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _addTravel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(APP_TITLE)),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xff0066cc),
            onPressed: _addLocal),
        body: StreamBuilder<QuerySnapshot>(
          stream: _streamController.stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return WidgetHelper.loading(PRYMARY_COLOR);
              case ConnectionState.active:
              case ConnectionState.done:
                return _list(snapshot);
                break;
            }
          },
        ));
  }

  Widget _list(AsyncSnapshot<QuerySnapshot> snapshot) {
    QuerySnapshot querySnapshot = snapshot.data;
    List<TravelModel> travelList = querySnapshot.documents.map((e) {
      var data = e.data;
      data["uid"] = e.documentID;
      return TravelModel.fromJson(data);
    }).toList();

    return Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: travelList.length,
            itemBuilder: (BuildContext context, int index) {
              TravelModel travel = travelList[index];
              return GestureDetector(
                  onTap: () => _openMap(travel),
                  child: Card(
                      child: ListTile(
                          title: Text(travel.title),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            GestureDetector(
                                onTap: () => _removeTravel(travel),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.remove_circle,
                                        color: Colors.red)))
                          ]))));
            }),
      )
    ]);
  }
}
