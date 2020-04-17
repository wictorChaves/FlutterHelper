class Video {
  String id;
  String title;
  String description;
  String image;
  String channelTitle;

  Video({this.id, this.title, this.description, this.image, this.channelTitle});

  factory Video.fromJson(Map<String, dynamic> item) => Video(
      id: item["id"]["videoId"],
      title: item["snippet"]["title"],
      description: item["snippet"]["description"],
      image: item["snippet"]["thumbnails"]["high"]["url"],
      channelTitle: item["snippet"]["channelTitle"]);
}
