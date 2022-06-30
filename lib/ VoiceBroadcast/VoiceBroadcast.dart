import 'package:flutter_sound/flutter_sound.dart';
import 'package:audioplayers/audioplayers.dart';

class VoiceBroadcast{

    static String file_path = "test.mp3";
   // static FlutterSound sound = new FlutterSound();
   // static FlutterSoundPlayer player = new FlutterSoundPlayer();
    static AudioPlayer player = new AudioPlayer();



    static Future<void> play() async {
      AudioCache cache = new AudioCache(fixedPlayer: player);
      print("hello sound");
      var res = cache.play(file_path);

      if(res == 1 ){
        print('play success');
      }else{
        print('play X');
      }

    }

}