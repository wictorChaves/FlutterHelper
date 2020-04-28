import 'package:flutter/material.dart';
import 'package:learning_english/services/audio_service.dart';

class Animal extends StatefulWidget {
  @override
  _AnimalState createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  List<String> _itemList = [
    "cao",
    "gato",
    "leao",
    "macaco",
    "ovelha",
    "vaca",
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
