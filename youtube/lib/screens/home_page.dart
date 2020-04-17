import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube/model/video.dart';
import 'package:youtube/services/youtube_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  YoutubeService _youtubeService;

  _HomePageState() {
    _youtubeService = YoutubeService();
  }

  Widget _loading() => Center(child: CircularProgressIndicator());

  Widget _noItems() => Center(child: Text("Nenhum dado a ser exibido!"));

  Widget _list(AsyncSnapshot<List<Video>> snapshot) => ListView.separated(
      itemBuilder: (context, index) => _itemList(snapshot.data[index]),
      separatorBuilder: (context, index) =>
          Divider(height: 2, color: Colors.grey),
      itemCount: snapshot.data.length);

  Widget _itemList(Video video) {
    return Column(children: [
      Container(
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(video.image))),
      ),
      ListTile(
        title: Text(video.title),
        subtitle: Text(video.channelTitle),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _youtubeService.search(""),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _loading();
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return (snapshot.hasData) ? _list(snapshot) : _noItems();
            break;
        }
      },
    );
  }
}
