import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

/**
 *
 * Audio files must is assest/ path
 * IOS plataform needs url https
 *
 */
class AudioService {
  AudioPlayer _audioPlayer;
  AudioCache _audioCache;

  AudioService() {
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(prefix: "songs/");
  }

  Future<int> loadSong(String song) async {
    String path = await _audioCache.getAbsoluteUrl(song);
    return _audioPlayer.setUrl(path);
  }

  Future<int> resume() => _audioPlayer.resume();

  Future<int> stop() => _audioPlayer.stop();

  Future<int> pause() => _audioPlayer.pause();

  Future<int> setVolume(double volume) => _audioPlayer.setVolume(volume);

  AudioPlayer get audioPlayer => _audioPlayer;

}
