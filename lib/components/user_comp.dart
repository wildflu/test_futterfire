

import 'package:flutter/material.dart';

import '../model/user.dart';

class UserComp extends StatelessWidget {
  const UserComp({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('UserName :',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
              Text(user.name),
            ],
          ),
          Row(
            children: [
              Text('friends :',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
              Text('${user.friends.join(', ')}'),
            ],
          ),
          Row(
            children: [
              Text('interast :',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
              Text('${user.interests.join(', ')}'),
            ],
          ),
        ],
      ),
    );
  }
}