import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'platform/audio_recorder_platform.dart';
import 'rounded_box.dart'; // Импортируем RoundedBox

class Recorder extends StatefulWidget {
  final void Function(String path) onStop;

  const Recorder({super.key, required this.onStop});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> with AudioRecorderMixin {
  int _recordDuration = 0;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  @override
  void initState() {
    _audioRecorder = AudioRecorder();

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      _updateRecordState(recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      setState(() => _amplitude = amp);
    });

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.aacLc;

        if (!await _isEncoderSupported(encoder)) {
          return;
        }

        const config = RecordConfig(encoder: encoder, numChannels: 1);

        await recordFile(_audioRecorder, config);

        _recordDuration = 0;
        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();

    if (path != null) {
      widget.onStop(path);
      downloadWebData(path);
    }
  }

  Future<void> _pause() => _audioRecorder.pause();

  Future<void> _resume() => _audioRecorder.resume();

  void _updateRecordState(RecordState recordState) {
    setState(() => _recordState = recordState);

    switch (recordState) {
      case RecordState.pause:
        _timer?.cancel();
        break;
      case RecordState.record:
        _startTimer();
        break;
      case RecordState.stop:
        _timer?.cancel();
        _recordDuration = 0;
        break;
    }
  }

  Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _audioRecorder.isEncoderSupported(encoder);

    if (!isSupported) {
      debugPrint('${encoder.name} is not supported on this platform.');
      debugPrint('Supported encoders are:');
      for (final e in AudioEncoder.values) {
        if (await _audioRecorder.isEncoderSupported(e)) {
          debugPrint('- ${e.name}'); // Исправлена ошибка вывода имени кодека
        }
      }
    }

    return isSupported;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRecordButton(),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              _recordState != RecordState.stop
                  ? 'Запись идёт'
                  : 'Начать запись приёма',
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          if (_recordState != RecordState.stop) ...[
            const SizedBox(width: 16),
            _buildPauseButton(),
            const SizedBox(width: 16),
            _buildStopButton(),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordButton() {
    return InkWell(
      onTap: () {
        if (_recordState != RecordState.stop) {
          _stop();
        } else {
          _start();
        }
      },
      child: ClipOval(
        child: Container(
          width: 40,
          height: 40,
          color: Colors.red,
          child: const Icon(Icons.fiber_manual_record, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPauseButton() {
    return InkWell(
      onTap: () {
        if (_recordState == RecordState.pause) {
          _resume();
        } else {
          _pause();
        }
      },
      child: ClipOval(
        child: Container(
          width: 40,
          height: 40,
          color: Colors.yellow,
          child: Icon(
            _recordState == RecordState.pause ? Icons.play_arrow : Icons.pause,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStopButton() {
    return InkWell(
      onTap: _stop,
      child: ClipOval(
        child: Container(
          width: 40,
          height: 40,
          color: Colors.red,
          child: const Icon(Icons.stop, color: Colors.white),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _recordDuration++;
      });
    });
  }
}
