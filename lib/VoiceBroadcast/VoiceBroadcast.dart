import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class VoiceBroadcast{





    static String file_path = "test.mp3";
   // static FlutterSound sound = new FlutterSound();
   // static FlutterSoundPlayer player = new FlutterSoundPlayer();
    static AudioPlayer player = new AudioPlayer();



    static Future<void> play() async {





      AudioCache cache = AudioCache();
      print("hello sound");

      var res = cache.play(file_path);

      if(res == 1 ){
        print('play success');
      }else{
        print('play X');
      }

    }

}