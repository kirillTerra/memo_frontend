// lib/components/audio_player/audio_slider.dart
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/material.dart';

class AudioSlider extends StatelessWidget {
  final ap.AudioPlayer audioPlayer;
  final Duration? position;
  final Duration? duration;

  const AudioSlider({
    Key? key,
    required this.audioPlayer,
    this.position,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sliderValue = 0.0;
    bool canSetValue = false;

    if (duration != null && position != null) {
      canSetValue = position!.inMilliseconds > 0;
      canSetValue &= position!.inMilliseconds < duration!.inMilliseconds;
      sliderValue = canSetValue
          ? position!.inMilliseconds / duration!.inMilliseconds
          : 0.0;
    }

    return Slider(
      activeColor: Theme.of(context).primaryColor,
      inactiveColor: Theme.of(context).colorScheme.secondary,
      onChanged: (v) {
        if (duration != null) {
          final position = v * duration!.inMilliseconds;
          audioPlayer.seek(Duration(milliseconds: position.round()));
        }
      },
      value: sliderValue,
    );
  }
}
