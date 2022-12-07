import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import '../DB_Sqlite/UserEntity.dart';
import '../DB_Sqlite/UserSelectEntity.dart';
import '../DB_Sqlite/controller.dart';


class record_page extends StatefulWidget {
  record_page({Key? key, required this.data}) : super(key: key);
  final int data;
  @override
  State<record_page> createState() => record_page_state();
}

class record_page_state extends State<record_page> {
  final recorder = FlutterSoundRecorder();
  final playmodule = FlutterSoundPlayer();
  static String file_path = "audio_";
  String datatime = DateTime.now().millisecondsSinceEpoch.toString();
  List<UserEntity> UserEntity_tmp = [];

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

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  // This widget is the root of your application.
  Future record() async {
    await recorder.startRecorder(
        toFile: file_path + "${widget.data}" + datatime);
  }

  Future stop() async {
    final path = await recorder.stopRecorder();

    print("新增了一個音檔" + UserEntity_tmp.length.toString());
    print(File(path!));
    print("567");

    //play(); //想一停止錄音直接播放
  }

  Future play() async {
    await playmodule.startPlayer(
        fromURI: file_path + "${widget.data}" + datatime);
  }

  Future playAudio(String URI) async {
    await playmodule.startPlayer(fromURI: URI);
  }

  void getAudioList() async {
    final list = await Controller.getAudiosList();
    UserEntity_tmp = list;
  }

  void addAudio() {
    final newAudio = UserEntity(
        id: new DateTime.now().millisecondsSinceEpoch,
        audioPath: file_path + "${widget.data}" + datatime,
        audioIndentity: "${widget.data}",
        fileName: myController.text);
    Controller.createAudioContentDB;
    Controller.insertAudioData(newAudio);
    getAudioList();
  }

  final myController = TextEditingController()..text = "自訂";
  static const snackBar = SnackBar(
    content: Text('音檔錄製完畢'),
  );
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop("0123");
          },
        ),
      ),
      backgroundColor: Colors.grey.shade900,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  controller: myController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(215, 255, 255, 255)),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Text(
                '.wav',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(215, 255, 255, 255)),
              )
            ],
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "錄製  ",
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
              ElevatedButton(
                  child: Icon(
                    recorder.isRecording ? Icons.stop : Icons.mic,
                    size: 80,
                  ),
                  onPressed: () async {
                    if (recorder.isRecording) {
                      await stop();
                      //controller.createAudioContentDB();
                      print("音檔名稱:");
                      print(myController.text);
                      print("新增");
                      addAudio();
                      getAudioList();
                      print("目前幾首" + UserEntity_tmp.length.toString());
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      await record();
                    }
                    setState(() {});
                  }),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "播放  ",
              style: TextStyle(color: Colors.white, fontSize: 48),
            ),
            ElevatedButton(
                child: Icon(
                  Icons.play_arrow,
                  size: 80,
                ),
                onPressed: () async {
                  await play();
                  setState(() {});
                }),
          ])
        ],
      )));
}
