

import 'package:flutter/material.dart';

import '../model/user.dart';

class UserComp extends StatelessWidget {
  const UserComp({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text("friends"),
            Text("interests")
          ],)
        ],
      ),
    );
  }
}