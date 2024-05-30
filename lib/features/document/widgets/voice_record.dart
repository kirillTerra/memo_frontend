import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class VoiceRecord extends StatefulWidget {
  @override
  _VoiceRecordState createState() => _VoiceRecordState();
}

class _VoiceRecordState extends State<VoiceRecord> {
  static const platform = MethodChannel('com.example.audio/record');
  bool isRecording = false;
  Duration duration = Duration(seconds: 0);
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            onPressed: () {
              setState(() {
                isRecording = !isRecording;
                if (isRecording) {
                  startRecording();
                  startTimer();
                } else {
                  stopRecording();
                  stopTimer();
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.fiber_manual_record,
                    color: isRecording ? Colors.red : Colors.grey,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      isRecording
                          ? 'Идёт запись: ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}'
                          : 'Начать запись приёма',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (isRecording)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.stop,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startRecording() async {
    try {
      await platform.invokeMethod('startRecording');
      print('Запись начата');
    } on PlatformException catch (e) {
      print("Failed to start recording: '${e.message}'.");
    }
  }

  void stopRecording() async {
    try {
      await platform.invokeMethod('stopRecording');
      print('Запись завершена и сохранена');
    } on PlatformException catch (e) {
      print("Failed to stop recording: '${e.message}'.");
    }
  }

  void startTimer() {
    duration = Duration(seconds: 0); // Сбросить длительность
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer t) {
        setState(() {
          duration += oneSec;
        });
      },
    );
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
