import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transport/setting/SharedPreferencesUtil.dart';

import 'MyColors.dart';

class AppTheme with ChangeNotifier {
  ThemeData?theme;
  static String black = "black",
      blue = "blue",
      red = "red",
      yellow = "yellow",
      white = "white";

  setTheme(String themeStr) {
    if (themeStr != "" && themeStr != null) {
      if (themeStr == black) {
        theme = themeBlack;
      } else if (themeStr == blue) {
        theme = themeBlue;
      } else if (themeStr == red) {
        theme = themeRed;
      } else if (themeStr == yellow) {
        theme = themeYellow;
      } else if (themeStr == white) {
        theme = themeWhite;
      }
    } else {
      theme = themeWhite;
    }
    notifyListeners();
  }

  getTheme() {
    return theme;
  }

  ThemeData themeBlack = ThemeData(brightness: Brightness.dark);

  ThemeData themeWhite = ThemeData(brightness: Brightness.light);

  ThemeData themeBlue = ThemeData(
      primaryColor: Colors.blue,
      // 导航栏颜色
      // 如果没有指定primaryColor，并且当前主题不是深色主题，那么primaryColor就会默认为primarySwatch指定的颜色
      primarySwatch: Colors.blue,
      // Scaffold组件的背景颜色
      scaffoldBackgroundColor: Colors.blue,
      // AppBar主题（会覆盖原有主题）
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      // 字体的样式
      textTheme: TextTheme(
        // 大文本颜色
        headline1: TextStyle(color: Colors.white),
        // 文本列表
        subtitle1: TextStyle(color: Colors.white),
        // 用于强调文本
        bodyText1: TextStyle(color: Colors.white),
        // 用于设置 [ElevatedButton], [TextButton], [OutlinedButton]样式
        // button: TextStyle(),
        // 用于辅助文字与图片。
        // caption: TextStyle(),
        // 通常用于说明或引入一个(更大的)标题。
        // overline: TextStyle(),
      ),
      // 图标主题
      iconTheme: IconThemeData(opacity: 1, size: 20, color: Colors.white));

  ThemeData themeRed = ThemeData(
      primaryColor: Colors.red,
      // 导航栏颜色
      // 如果没有指定primaryColor，并且当前主题不是深色主题，那么primaryColor就会默认为primarySwatch指定的颜色
      primarySwatch: Colors.red,
      // Scaffold组件的背景颜色
      scaffoldBackgroundColor: Colors.red,
      // 字体的样式
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
      ),
      // AppBar主题（会覆盖原有主题）
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      // 图标的主题
      accentIconTheme: IconThemeData(
        // 不透明度，0.0-1.0之间
        opacity: 1,
        // 图标大小
        // size: 2,
        // 图标的颜色
        color: Color.fromARGB(255, 255, 255, 255),
      ));

  ThemeData themeYellow = ThemeData(
      primaryColor: Colors.yellow,
      // 导航栏颜色
      // 如果没有指定primaryColor，并且当前主题不是深色主题，那么primaryColor就会默认为primarySwatch指定的颜色
      primarySwatch: Colors.yellow,
      // Scaffold组件的背景颜色
      scaffoldBackgroundColor: Colors.yellow,
      // 字体的样式
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
      ),
      // AppBar主题（会覆盖原有主题）
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      // 图标的主题
      iconTheme: IconThemeData(
        // 不透明度，0.0-1.0之间
          opacity: 1,
          // 图标大小
          // size: 2,
          // 图标的颜色
          color: MyColors.white));
}
