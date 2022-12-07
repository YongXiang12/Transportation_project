import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/services.dart';

class VoiceBroadcast{





   // static String file_path = "test.mp3";
   // static FlutterSound sound = new FlutterSound();
   // static FlutterSoundPlayer player = new FlutterSoundPlayer();
    static AudioPlayer player = new AudioPlayer();



    static Future<void> play(String s ) async {

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



      AudioCache cache = AudioCache();
      print("hello sound");

      String file_path = "audio_"+map[s].toString()+".mp3";
      print("file_path "+file_path);
      var res = cache.play(file_path);

      if(res == 1 ){
        print('play success');
      }else{
        print('play X');
      }

    }

    static Future<void> reminderEarly(String routebehavior) async {

      AudioCache cache = AudioCache();
      print("hello sound");

      String route_file_name = "" ;

      if(routebehavior == "turn-left"){
        route_file_name = "early-turn-left.mp3" ;
      }else if(routebehavior == "turn-right") {
        route_file_name = "early-turn-right.mp3" ;
      }else if(routebehavior == "uturn-right"){
        route_file_name = "early-uturn-right.mp3" ;
      }else if(routebehavior == "uturn-left"){
        route_file_name = "early-uturn-left.mp3" ;
      }

      var res = cache.play(route_file_name);

      if(res == 1 ){
        print('play success');
      }else{
        print('play X');
      }

    }


    static Future<void> routeVoicePlay(String routebehavior ) async {

      AudioCache cache = AudioCache();
      print("hello sound");

      String route_file_name = "" ;

      if(routebehavior == "turn-left"){
        route_file_name = "turn-left.mp3" ;
      }else if(routebehavior == "turn-right") {
        route_file_name = "turn-right.mp3" ;
      }else if(routebehavior == "uturn-right"){
        route_file_name = "uturn-right.mp3" ;
      }else if(routebehavior == "uturn-left"){
        route_file_name = "uturn-left.mp3" ;
      }

      var res = cache.play(route_file_name);

      if(res == 1 ){
        print('play success');
      }else{
        print('play X');
      }


    }

}