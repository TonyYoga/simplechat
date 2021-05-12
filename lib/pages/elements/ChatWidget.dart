import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simplechat/model/HistoryItem.dart';
import 'package:simplechat/settings/Sizes.dart';
import 'package:simplechat/utils/DateTimeUtils.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    CollectionReference history =
        FirebaseFirestore.instance.collection('chathistory');

    return
      StreamBuilder<QuerySnapshot>(
      stream: history.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (snapshot.hasData) {
          List<HistoryItem> historyChat = snapshot.data!.docs
              .map((document) => new HistoryItem(
                  user: (document.data() as Map)['user'],
                  dateTimeUts:
                     (document.data() as Map)['datetime'],
                  message: (document.data() as Map)['message']))
              .toList();
          historyChat.sort((a,b) => a.dateTimeUts.compareTo(b.dateTimeUts));

          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Chat',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              //---------------
              _buildHistoryView(historyChat, context),
            ],
          );
        } else {
          return Text('Data no ready yet');
        }
      },
    );
  }
}

DateTime converterTimeStampToDateTime(Timestamp ts){
  return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch, isUtc: true);
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
                Text(historyItem.user),
                SizedBox(
                  width: 10,
                ),
                Text(historyItem.dateTimeUts.convertFrom.toUtc().toString()),
                SizedBox(
                  width: 10,
                ),
                Text(historyItem.message),
              ],
            ),
          );
        },
      ),
    ),
  );
}
