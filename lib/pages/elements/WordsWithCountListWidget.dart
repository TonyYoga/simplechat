import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:simplechat/model/Word.dart';
import 'package:simplechat/repo/Boxes.dart';
import 'package:simplechat/settings/Sizes.dart';

class WordsWithCountListWidget extends StatelessWidget {
  const WordsWithCountListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Word>>
      (
        valueListenable: Boxes.getWords().listenable(),
        builder: (context, box, _) {
          final wordsList = box.values.toList().cast<Word>();
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text('WordList', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),
              _buildWordsList(wordsList, context),
            ],
          );
        }
    );
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
                    SizedBox(width: 10,),
                    Text(wordItem.count.toString()),
                  ],
                ),
              );
            },),
        )
    );
  }
}
