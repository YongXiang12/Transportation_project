import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:transport/VoiceBroadcast/VoiceBroadcast.dart';
import '../DB_Sqlite/controller.dart';
import '../DB_Sqlite/UserSelectEntity.dart';

class sound_player {
  static final playmodule = FlutterSoundPlayer();
 static List<UserSelectEntity> UserSelectEntity_tmp = [];
  static void getSelectlsit() async {
    //print("得到陣列");
    final lists = Controller.getUserSelectList();

    UserSelectEntity_tmp = await lists;
  }

  static Future playAudio(String s) async {
    final map = Map();
    map['違規超車'] = 1;
    map['爭搶道行駛'] = 2;
    map['逆向行駛'] = 3;
    map['蛇行方向不定'] = 4;
    map['未靠右行駛'] = 5;
    map['未依規定讓車'] = 6;
    map['變換車道或方向不定'] = 7;
    map['左轉彎未依規定'] = 8;
    map['右轉彎未依規定'] = 9;
    map['迴轉未依規定'] = 10;
    map['未保持行車安全距離'] = 11;
    map['未注意車前狀態'] = 12;
    map['違反號誌管制或指揮'] = 13;
    map['行人未注意左右車道路'] = 14;
    map['開啟車門不當而肇事'] = 15;
    map['動物竄出'] = 16;
    map['不明原因肇事'] = 17;
    int Audio = 0;
    getSelectlsit();
    for (int i = 0; i < UserSelectEntity_tmp.length; i++) {
      if (UserSelectEntity_tmp[i].id == map[s]) {
        await playmodule.openPlayer();
        await playmodule.startPlayer(
            fromURI: UserSelectEntity_tmp[i].audioPath);
        print("找到選項");
        Audio = 1;
        break;
      }
    }
    if (Audio == 0) {
      VoiceBroadcast.play(s);
      print("沒找到");
    }
  }
}