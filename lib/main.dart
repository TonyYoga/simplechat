import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplechat/model/User.dart';
import 'dart:developer';

import 'pages/SimpleChatMainPage.dart';

void main() async {
  log('Start App');
  WidgetsFlutterBinding.ensureInitialized();
  log('Init Firebase');
  await Firebase.initializeApp();


  log('Init Hive');
  Hive.initFlutter();

  log('Reg Adapters');
  Hive.registerAdapter(UserAdapter());

  log('Init boxes');
  await Hive.openBox<User>('users');
  runApp(SimpleChatApp());
}

class SimpleChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simple Chat demo')
    );
  }
}


