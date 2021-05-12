import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:simplechat/model/Word.dart';
import 'package:simplechat/settings/Sizes.dart';

class WordsWithCountListWidget extends StatelessWidget {
  const WordsWithCountListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference words = FirebaseFirestore.instance.collection('words');

    return StreamBuilder<QuerySnapshot>(
        stream: words.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (snapshot.hasData) {
            List<Word> wordsList = snapshot.data!.docs
                .map((document) => new Word(
                      word: (document.data() as Map)['word'],
                      count: (document.data() as Map)['count'],
                    ))
                .toList();
            log('wordlist');
            wordsList.sort((a, b) => -a.count.compareTo(b.count));
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'WordList',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildWordsList(wordsList, context),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget _buildWordsList(List<Word> wordsList, BuildContext context) {
    if (wordsList.isEmpty) {
      return Container(
        child: Text("Empty"),
      );
    }
    return Flexible(
        child: Container(
      width: context.appWidth / 4,
      child: ListView.builder(
        itemCount: wordsList.length,
        itemBuilder: (context, index) {
          final wordItem = wordsList[index];
          return Container(
            child: Row(
              children: [
                Text(wordItem.word),
                SizedBox(
                  width: 10,
                ),
                Text(wordItem.count.toString()),
              ],
            ),
          );
        },
      ),
    ));
  }
}
