import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simplechat/model/HistoryItem.dart';
import 'package:simplechat/model/User.dart';
import 'package:simplechat/model/Word.dart';
import 'package:simplechat/repo/Boxes.dart';
import 'dart:developer';

class MessageWidget extends StatefulWidget {
  final String? userName;
  const MessageWidget({Key? key, this.userName}) : super(key: key);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            onPressed: () => _addMessage(new User()..name = widget.userName ?? 'Anonim',
                DateTime.now(), messageController.text))
      ],
    );
  }

  _addMessage(User user, DateTime dateTime, String text) {
    final historyItem = HistoryItem()
      ..user = user
      ..dateTimeUts = dateTime
      ..message = text;
    final box = Boxes.getHistory();
    box.add(historyItem);
    _calculateAndAdd(text.toLowerCase());
    messageController.clear();
  }
  
  _calculateAndAdd(String text) {
    final wordArray = text.split(" ");
    final box = Boxes.getWords();
    final vocabulary = box.keys.toList();
    wordArray.forEach((element) { 
      if(vocabulary.contains(element)) {
        final word = box.get(element);
        // log('${word!.word} - ${word!.count}');
        word!.count = word.count + 1;
        // log('$inc');
        box.put(element, word);
      } else {
        box.put(element, Word()..word= element..count = 1);
      }
    });
  }
}
