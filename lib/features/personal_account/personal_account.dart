import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:my_app/features/personal_account/audio_player.dart';
import 'package:my_app/features/personal_account/audio_recorder.dart';

class PersonalAccountScreen extends StatefulWidget {
  const PersonalAccountScreen({super.key});

  @override
  State<PersonalAccountScreen> createState() => _PersonalAccountScreenState();
}

class _PersonalAccountScreenState extends State<PersonalAccountScreen> {
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment:
                Alignment.topCenter, // Размещение виджета вверху по центру
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 50), // Отступы для размещения сверху
              child: showPlayer
                  ? AudioPlayer(
                      source: audioPath!,
                      onDelete: () {
                        setState(() => showPlayer = false);
                      },
                    )
                  : Recorder(
                      onStop: (path) {
                        if (kDebugMode) print('Recorded file path: $path');
                        setState(() {
                          audioPath = path;
                          showPlayer = true;
                        });
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
