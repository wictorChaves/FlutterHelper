import 'package:flutter/material.dart';
import 'package:playvideo/configs/app_config.dart';
import 'package:video_player/video_player.dart';

import 'helper/widget_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://video.openedu.tw/Examples/big_buck_bunny_720p_10mb.mp4')
      ..initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller))
              : WidgetHelper.loading(PRYMARY_COLOR)),
      floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              }),
          child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow)),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
