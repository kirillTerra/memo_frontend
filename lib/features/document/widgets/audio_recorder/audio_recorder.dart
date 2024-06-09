import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderManager {
  final List<int> _audioBuffer = [];
  late final AudioRecorder _audioRecorder;

  AudioRecorderManager() {
    _audioRecorder = AudioRecorder();
  }

  Future<bool> hasPermission() {
    return _audioRecorder.hasPermission();
  }

  Future<Stream<List<int>>> startRecording() async {
    _audioBuffer.clear();
    return await _audioRecorder.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 16000,
        numChannels: 1,
      ),
    );
  }

  Future<void> stopRecording(String filePath) async {
    await _audioRecorder.stop();
    await _saveFile(filePath);
  }

  Future<void> pauseRecording() {
    return _audioRecorder.pause();
  }

  Future<void> resumeRecording() {
    return _audioRecorder.resume();
  }

  void addAudioData(List<int> data) {
    _audioBuffer.addAll(data);
  }

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$path/recording_$timestamp.wav';
  }

  Future<void> _saveFile(String filePath) async {
    final file = File(filePath);
    final wavData =
        _createWavData(_audioBuffer, sampleRate: 16000, numChannels: 1);
    await file.writeAsBytes(wavData, flush: true);
  }

  List<int> _createWavData(List<int> data,
      {required int sampleRate, required int numChannels}) {
    final byteRate = sampleRate * numChannels * 2;
    final wavHeader = <int>[
      // RIFF header
      82, 73, 70, 70, // "RIFF"
      ..._intToBytes(36 + data.length, 4), // File size - 8 bytes
      87, 65, 86, 69, // "WAVE"

      // Format chunk
      102, 109, 116, 32, // "fmt "
      16, 0, 0, 0, // Chunk size
      1, 0, // Format: PCM
      ..._intToBytes(numChannels, 2), // Number of channels
      ..._intToBytes(sampleRate, 4), // Sample rate
      ..._intToBytes(byteRate, 4), // Byte rate
      ..._intToBytes(numChannels * 2, 2), // Block align
      16, 0, // Bits per sample

      // Data chunk
      100, 97, 116, 97, // "data"
      ..._intToBytes(data.length, 4), // Data size
    ];

    return [...wavHeader, ...data];
  }

  List<int> _intToBytes(int value, int length) {
    final result = <int>[];
    for (var i = 0; i < length; i++) {
      result.add((value >> (8 * i)) & 0xFF);
    }
    return result;
  }

  void dispose() {
    _audioRecorder.dispose();
  }
}
