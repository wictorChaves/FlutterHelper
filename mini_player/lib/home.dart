import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/services/audio_service.dart';

import 'configs.dart';
import 'helper/dialog_helper.dart';
import 'helper/widget_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioService _audioService = AudioService();
  String _indexBtnPlayPause = "play";
  String _indexBtnStop = "stop";
  double _volume = 1;
  double _duration = 0;
  Widget _body = Container();

  _btnPlayPause() async {
    print(_indexBtnPlayPause);
    if (_indexBtnPlayPause == "play") {
      setState(() => _indexBtnPlayPause = "loading");
      await _audioService.resume();
      setState(() => _indexBtnPlayPause = "pausar");
    } else {
      setState(() => _indexBtnPlayPause = "loading");
      await _audioService.pause();
      setState(() => _indexBtnPlayPause = "play");
    }
  }

  _btnStop() async {
    await _audioService.stop();
    setState(() => _indexBtnStop = "stop");
    setState(() => _indexBtnPlayPause = "play");
  }

  Map _imgs = {
    "play": "assets/images/executar.png",
    "pausar": "assets/images/pausar.png",
    "stop": "assets/images/parar.png",
    "loading": "assets/images/loading-mini.gif"
  };

  @override
  void initState() {
    super.initState();
    _audioService.loadSong("musica.mp3").then((int success) {
      if (success != 1)
        DialogHelper.simple(context, "Erro", "Falha ao carregar a musica.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(APPNAME)),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Slider(
                  value: _volume,
                  min: 0,
                  max: 1,
                  onChanged: (newValue) {
                    _audioService.setVolume(newValue);
                    setState(() => _volume = newValue);
                  }),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                GestureDetector(
                    child: Image.asset(_imgs[_indexBtnPlayPause]),
                    onTap: _btnPlayPause),
                GestureDetector(
                    child: Image.asset(_imgs[_indexBtnStop]), onTap: _btnStop)
              ])
            ])));
  }
}
