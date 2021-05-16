import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';

class MessageWidget extends StatefulWidget {
  final String? userName;
  const MessageWidget({Key? key, this.userName}) : super(key: key);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
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
    CollectionReference history = FirebaseFirestore.instance.collection('chathistory');
    history.add({
      'user': user,
      'datetime':  dateTime.toUtc(),
      'message': text
    }).then((value) => log('Message added'))
    .catchError((err) => log('Failed to add message'));

    _calculateAndAdd(text.toLowerCase());
    messageController.clear();
  }

  _calculateAndAdd(String text) async {
    RegExp exp = RegExp(r"(\w+)", unicode: true);
    var matches = exp.allMatches(text);
    //Words not found;
    if(matches.isEmpty) return;
    final wordArray =matches.map((match) => match[0]).toList();
    CollectionReference words = FirebaseFirestore.instance.collection('words');

    //exists words array
    var wordsData = await words.get()
        .then((QuerySnapshot querySnapshot) =>
        querySnapshot.docs.map<String>((docs) =>
        (docs.data()as Map)['word']
        ).toList()).catchError((onError) => log('$onError'));


    //check upd or add
    wordArray.forEach((element) {
      if(wordsData.contains(element)) {
        //update word
        words.where('word', isEqualTo: element).get()
            .then((snapshot) {
          var curCount = (snapshot.docs.first.data() as Map)['count'];
          words.doc(snapshot.docs.first.id).update({
            'count': curCount + 1
          }).then((value) => log('upd word: $element success'))
              .catchError((onError) => log('upd error')
          );
        })
            .catchError((e) {
          log(e);
        });
      }else {
        //add word
        words.add({'word': element, 'count': 1})
            .then((value) => log('word $element added'))
        .catchError((e) => log(e));
      }
    });
  }
}
