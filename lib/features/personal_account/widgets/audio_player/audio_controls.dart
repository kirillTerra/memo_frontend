// lib/components/audio_player/audio_controls.dart
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/material.dart';

class AudioControls extends StatelessWidget {
  final ap.AudioPlayer audioPlayer;
  final VoidCallback onPlay;
  final VoidCallback onPause;

  static const double _controlSize = 32; // Уменьшенный размер кнопок и ClipOval

  const AudioControls({
    Key? key,
    required this.audioPlayer,
    required this.onPlay,
    required this.onPause,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon icon;
    Color color;

    if (audioPlayer.state == ap.PlayerState.playing) {
      icon = const Icon(Icons.pause,
          color: Colors.red, size: 20); // Уменьшенный размер иконок
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow,
          color: theme.primaryColor, size: 20); // Уменьшенный размер иконок
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
              SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () {
            if (audioPlayer.state == ap.PlayerState.playing) {
              onPause();
            } else {
              onPlay();
            }
          },
        ),
      ),
    );
  }
}
