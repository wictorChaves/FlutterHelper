import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioCache _audioCache = AudioCache(prefix: "songs/");

  Future<AudioPlayer> execute(String fileName) => _audioCache.play(fileName);

  Future<List<File>> loadAll(List<String> fileNames) =>
      _audioCache.loadAll(fileNames);
}
