import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simplechat/model/HistoryItem.dart';
import 'package:simplechat/pages/elements/ChatWidget.dart';
import 'package:simplechat/pages/elements/MessageWidget.dart';
import 'package:simplechat/pages/elements/UserLoginWiget.dart';
import 'package:simplechat/pages/elements/UserOnlineWidget.dart';
import 'package:simplechat/pages/elements/WordsWithCountListWidget.dart';
import 'package:simplechat/settings/Sizes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userName;
  // bool? isNameSet = false;
  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  void _setUserName(String name) {
    setState(() {
      userName = name;
      dev.log('$userName is set');
      // isNameSet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          height: context.appHeight,
          // height: MediaQuery.of(context).size.height * 0.9,
          width: context.appWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserLoginWidget(setUserName: _setUserName, userName: userName,),
                  // UserOnlineWidget(),

                  Flexible(child: ChatWidget()),
                  MessageWidget(userName: userName,),
                ],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child: WordsWithCountListWidget()),
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    Hive.close();
    // log('hive dispose');
    super.dispose();
  }
}
