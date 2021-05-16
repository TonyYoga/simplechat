import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'dart:developer' as dev;
import 'package:simplechat/settings/Sizes.dart';

class UserLoginWidget extends StatefulWidget {
  final Function? setUserName;

  final String? userName;

  const UserLoginWidget({
    Key? key,
    this.setUserName,
    this.userName,
  }) : super(key: key);

  @override
  _UserLoginWidgetState createState() => _UserLoginWidgetState();
}

class _UserLoginWidgetState extends State<UserLoginWidget> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: widget.userName == null || widget.userName!.isEmpty
          ? Row(
              children: [
                Container(
                  width: context.appWidth / 3,
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        labelText: 'Set username',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    child: Text('Set Name'),
                    onPressed: () => widget.setUserName!(textController.text))
              ],
            )
          : Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Text('User name: '),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      widget.userName ?? 'Anonim',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
