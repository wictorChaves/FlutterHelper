import 'package:flutter/material.dart';
import 'package:learning_english/configs.dart';
import 'package:learning_english/tabs/animal.dart';
import 'package:learning_english/tabs/number.dart';
import 'package:learning_english/tabs/vowel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _choices = ["Bichos", "Números", "Vogais"];
  List<Widget> _tabsContent = [Animal(), Number(), Vowel()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _choices.length,
        child: Scaffold(
            appBar: AppBar(
                title: Text(APP_TITLE),
                bottom: TabBar(
                  indicatorWeight: 4,
                  labelStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  tabs: _choices.map((choice) {
                    return Tab(text: choice);
                  }).toList(),
                )),
            body: TabBarView(children: _tabsContent)));
  }
}
