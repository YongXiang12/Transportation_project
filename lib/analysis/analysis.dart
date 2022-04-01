import 'package:flutter/material.dart';
import 'package:transport/TabBarResource/TabBarInterface.dart';
import 'package:transport/SearchResource/Search_listview.dart';

class analysis_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title bar'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        color: Color.fromARGB(255, 243, 242, 242),
        constraints: BoxConstraints(
            maxWidth: 500, maxHeight: 500, minWidth: 100, minHeight: 100),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );
  }
}
