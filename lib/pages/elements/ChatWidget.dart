import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:simplechat/model/HistoryItem.dart';
import 'package:simplechat/pages/elements/MessageWidget.dart';
import 'package:simplechat/repo/Boxes.dart';
import 'dart:developer';
import 'package:simplechat/settings/Sizes.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<HistoryItem>>(
      valueListenable: Boxes.getHistory().listenable(),
      builder: (context, box, _) {
        final historyItems = box.values.toList().cast<HistoryItem>();
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('Chat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            _buildHistoryView(historyItems, context),
            // MessageWidget(),
          ],
        );
      },
    );
  }
}

Widget _buildHistoryView(List<HistoryItem> historyItems, BuildContext context) {
  if (historyItems.isEmpty) {
    return Container(
      child: Text('Message list empty'),
    );
  }

  return Flexible(
    child: Container(
      width: context.appWidth / 2,
      child: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final historyItem = historyItems[index];
          return Container(
            child: Row(
              children: [
                Text(historyItem.user.name),
                SizedBox(width: 10,),
                Text(historyItem.dateTimeUts.toUtc().toString()),
                SizedBox(width: 10,),
                Text(historyItem.message),
              ],
            ),
          );
        },
      ),
    ),
  );
}
