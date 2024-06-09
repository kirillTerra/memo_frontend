// lib/components/audio_player/audio_player.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../rounded_box.dart'; // Импортируем класс RoundedBox
import 'audio_controls.dart';
import 'audio_slider.dart';

class AudioPlayer extends StatefulWidget {
  final String source;
  final VoidCallback onDelete;

  const AudioPlayer({
    super.key,
    required this.source,
    required this.onDelete,
  });

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

// lib/components/audio_player/audio_player_state.dart

class AudioPlayerState extends State<AudioPlayer> {
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer()..setReleaseMode(ap.ReleaseMode.stop);
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
    });
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) => setState(() {
        _position = position;
      }),
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) => setState(() {
        _duration = duration;
      }),
    );

    _audioPlayer.setSource(_source);

    super.initState();
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedBox(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AudioControls(
              audioPlayer: _audioPlayer,
              onPlay: play,
              onPause: pause,
            ),
            Expanded(
              child: AudioSlider(
                audioPlayer: _audioPlayer,
                position: _position,
                duration: _duration,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete,
                  color: Color(0xFF73748D), size: _deleteBtnSize),
              onPressed: () {
                if (_audioPlayer.state == ap.PlayerState.playing) {
                  stop().then((value) => widget.onDelete());
                } else {
                  widget.onDelete();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> play() => _audioPlayer.play(_source);

  Future<void> pause() async {
    await _audioPlayer.pause();
    setState(() {});
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    setState(() {});
  }

  ap.Source get _source =>
      kIsWeb ? ap.UrlSource(widget.source) : ap.DeviceFileSource(widget.source);
}
