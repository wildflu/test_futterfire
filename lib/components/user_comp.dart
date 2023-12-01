

import 'package:flutter/material.dart';

class UserComp extends StatelessWidget {
  const UserComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Name'),
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