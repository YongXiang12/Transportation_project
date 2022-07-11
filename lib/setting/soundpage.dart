import 'package:flutter/material.dart';
import 'package:transport/setting/record.dart';

class sound_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => sound_page_state();
}

class sound_page_state extends State<sound_page> {
  List<int> groupValue = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  Widget build(BuildContext context) {
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[0],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[0] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[0],
                                onChanged: (value) =>
                                    state(() => groupValue[0] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "0")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                                child: Text("爭搶道行駛語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[1],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[1] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[1],
                                onChanged: (value) =>
                                    state(() => groupValue[1] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "1")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("2. 爭搶道行駛",
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[2],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[2] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[2],
                                onChanged: (value) =>
                                    state(() => groupValue[2] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "2")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                                child: Text("蛇行、方向不定語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[3],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[3] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[3],
                                onChanged: (value) =>
                                    state(() => groupValue[3] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "3")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("4. 蛇行、方向不定",
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[4],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[4] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[4],
                                onChanged: (value) =>
                                    state(() => groupValue[4] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "4")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[5],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[5] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[5],
                                onChanged: (value) =>
                                    state(() => groupValue[5] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "5")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                                child: Text("變換車道或方向不當語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[6],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[6] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[6],
                                onChanged: (value) =>
                                    state(() => groupValue[6] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "6")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("7. 變換車道或方向不當",
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
                                child: Text("左轉彎未依規定語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[7],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[7] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[7],
                                onChanged: (value) =>
                                    state(() => groupValue[7] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "7")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("8. 左轉彎未依規定",
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
                                child: Text("右轉彎未依語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[8],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[8] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[8],
                                onChanged: (value) =>
                                    state(() => groupValue[8] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "8")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("9. 右轉彎未依規定",
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[9],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[9] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[9],
                                onChanged: (value) =>
                                    state(() => groupValue[9] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "9")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[10],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[10] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[10],
                                onChanged: (value) =>
                                    state(() => groupValue[10] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "10")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[11],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[11] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[11],
                                onChanged: (value) =>
                                    state(() => groupValue[11] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "11")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[12],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[12] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[12],
                                onChanged: (value) =>
                                    state(() => groupValue[12] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "12")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                                child: Text("行人穿越道路未注意左右來車語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[13],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[13] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[13],
                                onChanged: (value) =>
                                    state(() => groupValue[13] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "13")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("14. 行人穿越道路未注意左右來車",
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[14],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[14] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[14],
                                onChanged: (value) =>
                                    state(() => groupValue[14] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "14")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
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
                                child: Text("暗處停車無燈光、標識語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[15],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[15] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[15],
                                onChanged: (value) =>
                                    state(() => groupValue[15] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "15")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("16. 暗處停車無燈光、標識",
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
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[16],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[16] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[16],
                                onChanged: (value) =>
                                    state(() => groupValue[16] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "16")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("17. 動物竄出",
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
                                child: Text("其他肇事原因語音",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RadioListTile<int>(
                                title: Text("預設音檔"),
                                value: 1,
                                groupValue: groupValue[17],
                                onChanged: (value) =>
                                    //groupValue[0] = value!;
                                    state(() => groupValue[17] = 1),
                              ),
                              RadioListTile<int>(
                                title: Text("自訂音檔"),
                                value: 2,
                                groupValue: groupValue[17],
                                onChanged: (value) =>
                                    state(() => groupValue[17] = 2),
                                secondary: OutlinedButton(
                                  child: Text("錄音"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                record_page(data: "17")));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("取消"),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    child: FlatButton(
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
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("18. 其他肇事原因",
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
