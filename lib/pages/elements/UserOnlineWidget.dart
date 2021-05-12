import 'package:flutter/widgets.dart';

class UserOnlineWidget extends StatelessWidget {
  const UserOnlineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text('users online: '),
          Text('user1, user2, user3'),
        ],
      ),
    );
  }
}
