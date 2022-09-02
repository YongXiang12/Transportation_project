import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/setting/AppTheme.dart';
import 'package:transport/setting/NewPage.dart';
import 'package:transport/setting/SharedPreferencesUtil.dart';




class color_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => color_page_state();
}

class color_page_state extends State<color_page> {
  double SimpleDialogOptionHeight = 20.00;
  AppTheme?appTheme;

  List item = [
    {"text": "更换系统主题", "toPage": ""},
    {"text": "更换自定义主题", "toPage": ""},
    {"text": "打开新界面", "toPage": ""}
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AppTheme())],
        child: Consumer<AppTheme>(builder: (context, appTheme, _) {
          this.appTheme = appTheme;
          SharedPreferencesUtil.instance.getString("theme").then(
                  (value) => {this.appTheme?.setTheme(value)});
          return MaterialApp(
            title: 'First Flutter Project',
            theme: this.appTheme?.getTheme(),
            home: Scaffold(
              appBar: AppBar(
                title: Text("首页"),
              ),
              body: Container(
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    String text = item[index]["text"];
                    return InkWell(
                      onTap: () {
                        // 列表点击事件
                        clickListItem(context, index);
                      },
                      child: ListTile(
                        title: Text(
                          text,
                        ),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }));
  }

  void clickListItem(BuildContext context, int index) {
    if (index == 0) {
      showCustomThemeDialog(context);
    } else if (index == 1) {
      showSystemThemeDialog(context);
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewPage()));
    }
  }

  void showSystemThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("选择自定义主题"),
          children: [
            SimpleDialogOption(
              child: Container(
                child: Text(""),
                color: Colors.blue,
                height: SimpleDialogOptionHeight,
              ),
              onPressed: () => selectTheme(context, AppTheme.blue),
            ),
            SimpleDialogOption(
              child: Container(
                child: Text(""),
                color: Colors.red,
                height: SimpleDialogOptionHeight,
              ),
              onPressed: () => selectTheme(context, AppTheme.red),
            ),
            SimpleDialogOption(
              child: Container(
                child: Text(""),
                color: Colors.yellow,
                height: SimpleDialogOptionHeight,
              ),
              onPressed: () => selectTheme(context, AppTheme.yellow),
            ),
          ],
        );
      },
    );
  }

  void showCustomThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("选择系统主题"),
          children: [
            SimpleDialogOption(
              child: Container(
                child: Text(""),
                color: Colors.white,
                height: SimpleDialogOptionHeight,
              ),
              onPressed: () => selectTheme(context, AppTheme.white),
            ),
            SimpleDialogOption(
              child: Container(
                child: Text(""),
                color: Colors.black,
                height: SimpleDialogOptionHeight,
              ),
              onPressed: () => selectTheme(context, AppTheme.black),
            ),
          ],
        );
      },
    );
  }

  /// 主题的选择事件
  selectTheme(context, color) {
    SharedPreferencesUtil.getInstance().setString("theme", color);
    appTheme?.setTheme(color);
    // 隐藏对话框
    Navigator.pop(context);
  }
}
