import 'dart:developer';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:transport/DB_Sqlite/UserEntity.dart';
import 'package:transport/DB_Sqlite/UserSelectEntity.dart';
import 'package:transport/DB_Sqlite/controller.dart';
import 'package:transport/main.dart';
import 'package:transport/setting/record.dart';
import 'package:transport/DB_Sqlite/TodoDB.dart';

List<UserSelectEntity> UserSelectEntity_tmp = [];
List<UserEntity> UserEntity_tmp = [];
int select_music = 0;

class sound_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => sound_page_state();
}

class _LocationRadioGroup extends StatefulWidget {
  final GlobalKey<_LocationRadioGroupState> _key;

  _LocationRadioGroup(this._key) : super(key: _key);

  State<StatefulWidget> createState() => _LocationRadioGroupState();

  getSelectedItem() => _key.currentState?.getSelectedItem();
}

class _LocationRadioGroupState extends State<_LocationRadioGroup> {
  final playmodule = FlutterSoundPlayer();

  Future play(String audioPath) async {
    await playmodule.openPlayer();
    await playmodule.startPlayer(fromURI: audioPath);
  }

  var _locations = const <String>[
    '',
    '自訂音檔',
    '自訂音檔',
  ];
  var _groupValue = 0;
  //var length = 3;

  //Controller controller = new Controller();

  void getSelectlsit() async {
    //print("得到陣列");
    final lists = Controller.getUserSelectList();

    UserSelectEntity_tmp = await lists;
  }

  void addSelect(int select_music, String select, String audioPath) {
    final newSelectEntity = UserSelectEntity(
        id: select_music,
        default_select: select,
        select_indentity: "0",
        audioPath: audioPath);
    Controller.createUserSelectDB();
    Controller.insertUserSelectData(newSelectEntity);
    //print("新增了一個東西");
    getSelectlsit();
  }

  void getAudioList() async {
    //print("得到陣列UserEntity_tmp");
    final list = await Controller.getAudiosList();
    setState(() {
      UserEntity_tmp = list;
    });
  }

  void checkdelete(int i, int _groupValue, int select_music) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("確認刪除\"" + UserEntity_tmp[i - 1].fileName + "\"音檔嗎?"),
        actions: [
          TextButton(
            onPressed: () {
              getAudioList();
              print(i);
              print(UserEntity_tmp[i - 1].id);
              if (_groupValue == UserEntity_tmp[i - 1].id) {
                Controller.deleteselectData(select_music);
                addSelect(select_music, "0", "null");
              }
              print("1");
              Controller.deleteAudioData(UserEntity_tmp[i - 1].id);
              print("1");
              //getAudioList();
              Navigator.of(context).pop(true);
            },
            child: const Text('是'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('否'),
          ),
        ],
      ),
    ).then(
      (value) => {if (value == true) {}},
    );
  }

  Widget build(BuildContext context) {
    getSelectlsit();
    // print("UserSelectEntity_tmp.length: " + UserSelectEntity_tmp.length.toString());
    int select = 0;
    var radioItems = <RadioListTile>[];
    int select_music = Provider.of<MyCounter>(context).use_setting;
    //print("UserSelectEntity_tmp.length: " +UserSelectEntity_tmp.length.toString());
    // print(Provider.of<MyCounter>(context).use_setting);
    /*print("UserSelectEntity_tmp.length: " +
        UserSelectEntity_tmp.length.toString());
    for (int i = 0; i < UserSelectEntity_tmp.length; i++) {
      Controller.deleteselectData(UserSelectEntity_tmp[i].id);
    }
    print("先刪掉");*/
    //_groupValue = UserSelectEntity_tmp[0].default_select;
    for (select = 0; select < UserSelectEntity_tmp.length; select++) {
      if (UserSelectEntity_tmp[select].id == select_music) {
        // print("已經有了");
        _groupValue = int.parse(UserSelectEntity_tmp[select].default_select);
        break;
      }
    }
    if (select == UserSelectEntity_tmp.length) {
      addSelect(select_music, "0", "null");
      //print("新按了");
      _groupValue = 0;
    }
    getSelectlsit();
    // print("UserSelectEntity_tmp.length " + UserSelectEntity_tmp.length.toString());
    //if (UserSelectEntity_tmp.length != 0) print(UserSelectEntity_tmp[0].default_select);
    radioItems.add(
      RadioListTile(
        title: Text("預設音檔"),
        value: 0,
        groupValue: _groupValue,
        onChanged: (value) {
          //play("assets/違規超車.wav");

          Controller.deleteselectData(select_music);
          addSelect(select_music, value.toString(), "null");
          _updateGroupValue(value);
        },
      ),
    );
    getAudioList();
    //getvalue(select_music);
    //print(select_music);
    //print("length:");
    //print(UserEntity_tmp.length.toString());
    for (var i = 1; i <= UserEntity_tmp.length; i++) {
      if (UserEntity_tmp[i - 1].audioIndentity == select_music.toString()) {
        radioItems.add(
          RadioListTile(
            value: UserEntity_tmp[i - 1]
                .id, //UserSelectEntity_tmp[i].default_select,
            groupValue: _groupValue,
            title: Text(UserEntity_tmp[i - 1].fileName),
            onChanged: (value) {
              Controller.deleteselectData(select_music);
              addSelect(select_music, value.toString(),
                  UserEntity_tmp[i - 1].audioPath);
              play(UserEntity_tmp[i - 1].audioPath);
              _updateGroupValue(value);
            },
            secondary: OutlinedButton(
              child: Text("刪除"),
              onPressed: () {
                checkdelete(i, _groupValue, select_music);
                setState(() {
                  getAudioList();
                });
              },
            ),
          ),
        );
      }
    }

    final Widget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radioItems,
    );
    return Widget;
  }

  _updateGroupValue(int groupValue) {
    setState(() {
      _groupValue = groupValue;
    });
  }

  getSelectedItem() => _locations[_groupValue];

  getUserSelectEntity(int select_music) {}
}

class sound_page_state extends State<sound_page> {
  void _getRequests() async {
    print('这里进行操作');
  }

  List<Todo> listArr = [];
  void getAudioList() async {
    //print("得到陣列2");
    final list = await Controller.getAudiosList();
    UserEntity_tmp = list;
  }

  void getSelectlsit() async {
    //print("得到陣列2");
    final lists = Controller.getUserSelectList();
    UserSelectEntity_tmp = await lists;
  }

  List<int> groupValue = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  List<UserEntity> UserEntity_group = [];
  final LocationRadioGroup =
      _LocationRadioGroup(GlobalKey<_LocationRadioGroupState>());
  int k = 0;

  Widget build(BuildContext context) {
    Controller.createAudioContentDB();
    getAudioList();
    Controller.createUserSelectDB();
    getSelectlsit();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text("設定音檔",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(1);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("違規超車",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 1))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1. 違規超車",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(2);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("爭搶道行駛",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 2))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("2. 爭搶道行駛語音",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(3);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("逆向行駛語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 3))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("3. 逆向行駛",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(4);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("蛇行方向不定語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 4))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("4. 蛇行方向不定",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(5);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("未靠右行駛語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 5))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("5. 未靠右行駛",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(6);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("未依規定讓車語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 6))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("6. 未依規定讓車",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(7);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("變換車道或方向不定語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 7))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("7. 變換車道或方向不定",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(8);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("左轉未依規定語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 8))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("8. 左轉未依規定",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false).selectsetting(9);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("右轉未依規定語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 9))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                   backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("9. 右轉未依規定",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(10);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("迴轉未依規定語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 10))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("10. 迴轉未依規定",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(11);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("未保持行車安全距離語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 11))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("11. 未保持行車安全距離",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(12);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("未注意車前狀態語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 12))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("12. 未注意車前狀態",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(13);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("違反號誌管制或指揮語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 13))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("13. 違反號誌管制或指揮",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(14);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("行人未注意左右來車語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 14))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("14. 行人未注意左右來車道路",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(15);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("開啟車門不當而肇事語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 15))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("15. 開啟車門不當而肇事",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(16);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("動物竄出語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 16))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("16. 動物竄出",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<MyCounter>(context, listen: false)
                    .selectsetting(17);
                getAudioList();
                print(UserEntity_tmp.length);
                print(
                    Provider.of<MyCounter>(context, listen: false).use_setting);
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, state) {
                        return Dialog(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text("不明肇事原因語音",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: LocationRadioGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  record_page(data: 17))).then(
                                          (val) => val ? _getRequests() : null);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    label: Text(
                                      "新增音檔",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("確定"),
                                      ),
                                      width: 80,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ]),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("17. 不明肇事原因",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
