import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:simplechat/utils/FireBaseLogicMixin.dart';

class MessageWidget extends StatefulWidget {
  final String? userName;
  const MessageWidget({Key? key, this.userName}) : super(key: key);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> with FireBaseLogicMixin{
  final messageController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(
                labelText: 'SendMessage', border: OutlineInputBorder()),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
            child: Text('Send'),
            onPressed: () => _addMessage(
                widget.userName ?? 'Anonim',
                DateTime.now(),
                messageController.text))
      ],
    );
  }

  _addMessage(String user, DateTime dateTime, String text) {
    addMessageToDb(user, dateTime, text);
    messageController.clear();
  }
}
