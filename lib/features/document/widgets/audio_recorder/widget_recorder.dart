import 'package:flutter/material.dart';
import 'audio_recorder.dart';
import 'web_socket_manager.dart';
import 'package:my_app/features/personal_account/widgets/recorder/time_manager.dart';
import 'package:my_app/features/personal_account/rounded_box.dart'; // Импортируем RoundedBox

class Recorder extends StatefulWidget {
  final void Function(String path) onStop;
  final String documenntOid;

  const Recorder({super.key, required this.onStop, required this.documenntOid});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  final AudioRecorderManager _audioRecorderManager = AudioRecorderManager();
  final WebSocketManager _webSocketManager = WebSocketManager();
  final TimerManager _timerManager = TimerManager();

  bool _isRecording = false;
  String? _filePath;
  int _recordDuration = 0;

  @override
  void initState() {
    super.initState();
    _timerManager.onTick = (int seconds) {
      setState(() {
        _recordDuration = seconds;
      });
    };
  }

  Future<void> _start() async {
    if (await _audioRecorderManager.hasPermission()) {
      _filePath = await _audioRecorderManager.getFilePath();

      _webSocketManager.openConnection(widget.documenntOid);

      final stream = await _audioRecorderManager.startRecording();
      stream.listen((audioData) {
        _webSocketManager.sendData(audioData);
        _audioRecorderManager.addAudioData(audioData);
      });

      _timerManager.start();
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stop() async {
    await _audioRecorderManager.stopRecording(_filePath!);
    _webSocketManager.closeConnection();
    _timerManager.stop();
    setState(() {
      _isRecording = false;
    });
    widget.onStop(_filePath!);
  }

  Future<void> _pause() async {
    await _audioRecorderManager.pauseRecording();
    _timerManager.pause();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _resume() async {
    await _audioRecorderManager.resumeRecording();
    _timerManager.start();
    setState(() {
      _isRecording = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width *
                0.9, // Задаем ширину как 90% экрана
            maxHeight: 80, // Максимальная высота полоски
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRecordButton(),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _isRecording ? 'Запись идёт' : 'Начать запись приёма',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              if (_isRecording) ...[
                const SizedBox(width: 16),
                _buildPauseButton(),
                const SizedBox(width: 16),
                _buildStopButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerManager.stop();
    _audioRecorderManager.dispose();
    _webSocketManager.closeConnection();
    super.dispose();
  }

  Widget _buildRecordButton() {
    return InkWell(
      onTap: () {
        if (_isRecording) {
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
        if (_isRecording) {
          _pause();
        } else {
          _resume();
        }
      },
      child: ClipOval(
        child: Container(
          width: 40,
          height: 40,
          color: Colors.yellow,
          child: Icon(
            _isRecording ? Icons.pause : Icons.play_arrow,
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

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
