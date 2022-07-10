import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class record_page extends StatefulWidget {
  @override
  State<record_page> createState() => record_page_state();
}

class record_page_state extends State<record_page> {
  final recorder = FlutterSoundRecorder();
  final playmodule = FlutterSoundPlayer();
  static String file_path = "audio";

  @override
  void initState() {
    super.initState();

    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();

    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'not Granted';
    }

    await recorder.openRecorder();
    await playmodule.openPlayer();

    recorder.setSubscriptionDuration(
      Duration(milliseconds: 500),
    );
  }

  // This widget is the root of your application.
  Future record() async {
    await recorder.startRecorder(toFile: file_path);
  }

  Future stop() async {
    await recorder.stopRecorder();
    play(); //想一停止錄音直接播放
  }

  Future play() async {
    await playmodule.startPlayer(fromURI: file_path);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                String twoDigits(int n) => n.toString().padLeft(2, '0');
                final twoDigitsMinutes =
                    twoDigits(duration.inMinutes.remainder(60));
                final twoDigitsSeconds =
                    twoDigits(duration.inSeconds.remainder(60));
                return Text(
                  '$twoDigitsMinutes:$twoDigitsSeconds',
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                );
              }),
          ElevatedButton(
              child: Icon(
                recorder.isRecording ? Icons.stop : Icons.mic,
                size: 80,
              ),
              onPressed: () async {
                if (recorder.isRecording) {
                  await stop();
                } else {
                  await record();
                }
                setState(() {});
              }),
        ],
      )));
}
