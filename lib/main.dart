import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplechat/model/HistoryItem.dart';
import 'package:simplechat/model/Word.dart';
import 'package:simplechat/model/User.dart';
import 'dart:developer';

import 'pages/SimpleChatMainPage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  log('Start App');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  log('Init Firebase');
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  log('Init Hive');
  // Directory? extDir = await path_provider.getExternalStorageDirectory();

  // var path = extDir!.path;
  // Hive.initFlutter(extDir!.path);
  Hive.initFlutter();

  log('Reg Adapters');
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(HistoryItemAdapter());

  log('Init boxes');
  await Hive.openBox<User>('users');
  await Hive.openBox<Word>('words');
  await Hive.openBox<HistoryItem>('history');
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


