import 'package:flutter/material.dart';
import 'package:learning_english/services/audio_service.dart';

class Number extends StatefulWidget {
  @override
  _NumberState createState() => _NumberState();
}

class _NumberState extends State<Number> {
  List<String> _itemList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
  ];

  AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    _audioService.loadAll(_itemList.map((item) => item + ".mp3").toList());
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
        children: _itemList.map((item) {
          return GestureDetector(
              onTap: () => _audioService.execute(item + ".mp3"),
              child: Image.asset("assets/images/" + item + ".png"));
        }).toList());
  }
}
