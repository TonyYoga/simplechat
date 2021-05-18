import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

mixin FireBaseLogicMixin {
  final CollectionReference words =
      FirebaseFirestore.instance.collection('words');
  final CollectionReference history =
      FirebaseFirestore.instance.collection('chathistory');
  final RegExp expWordSlicer = RegExp(r"(\w+)", unicode: true);

  void reloadWordList() async {
    //Clear words list
    words
        .get()
        .then((querySnapshot) => querySnapshot.docs.forEach((doc) {
              doc.reference.delete().then((value) => log('${doc.id} deleted'));
            }))
        .catchError((onError) => log('$onError'));

    //Get message history
    final messageData = await history
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .map<String>((docs) => (docs.data() as Map)['message'])
            .toList())
        .catchError((onError) => log('$onError'));

    final Map<String, int> wordRecount = new Map();

    //Debug
    // RegExp exp = RegExp(r"(\w+)", unicode: true, );
    messageData.forEach((message) {
      var matches = expWordSlicer.allMatches(message);
      final wordArray = matches.map((match) => match[0]).toList();
      wordArray.forEach((word1) {

        if (word1 != null) {
          var wordLC = word1.toLowerCase();
          wordRecount.update(wordLC, (curValue) => curValue + 1,
              ifAbsent: () => 1);
        }
      });
    });

    log('done gen map');

    wordRecount.entries.forEach((element) => _addWordRequest(element.key, element.value));
  }
  _addWordRequest(String word, int count) {
    words.add({'word': word, 'count': count})
              .then((value) => log('word $word added, with count: $count'))
          .catchError((e) => log(e));
  }

  _calculateAndAdd(String text) async {
    log('add words $text');
    var matches = expWordSlicer.allMatches(text);
    //Words not found;
    if (matches.isEmpty) return;
    final wordArray = matches.map((match) => match[0]).toList();

    //exists words array
    var wordsData = await words
        .get()
        .then((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map<String>((docs) => (docs.data() as Map)['word'])
            .toList())
        .catchError((onError) => log('$onError'));

    //check upd or add
    wordArray.forEach((element) {
      if (wordsData.contains(element)) {
        //update word
        words.where('word', isEqualTo: element).get().then((snapshot) {
          var curCount = (snapshot.docs.first.data() as Map)['count'];
          words
              .doc(snapshot.docs.first.id)
              .update({'count': curCount + 1})
              .then((value) => log('upd word: $element success'))
              .catchError((onError) => log('upd error'));
        }).catchError((e) {
          log(e);
        });
      } else {
        //add word
        _addWordRequest(element!, 1);
      }
    });
  }

  addMessageToDb(String user, DateTime dateTime, String text) {
    CollectionReference history =
        FirebaseFirestore.instance.collection('chathistory');
    history
        .add({'user': user, 'datetime': dateTime.toUtc(), 'message': text})
        .then((value) => log('Message added'))
        .catchError((err) => log('Failed to add message'));

    _calculateAndAdd(text.toLowerCase());
  }
}
