import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube/model/video.dart';

import '../config.dart';

class YoutubeService {
  Future<List<Video>> search(String query) async {
    http.Response response = await http.get(ROOT_URL +
        "search/"
            "?key=$YOUTUBE_API_KEY"
            "&channelId=$ID_CHANNEL"
            "&part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&q=$query");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<Video> videos =
          jsonData["items"].map<Video>((item) => Video.fromJson(item)).toList();
      return videos;
    }
  }
}
