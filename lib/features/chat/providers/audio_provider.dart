import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider with ChangeNotifier {
  AudioProvider() {
    initialize();
  }
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void initialize() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
      notifyListeners();
    });
  }

  void changePosition(Duration newPosition) {
    position = newPosition;
    audioPlayer.seek(newPosition);
    notifyListeners();
  }
}
