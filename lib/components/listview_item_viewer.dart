


import 'package:flutter/material.dart';

class ListViewItems extends StatelessWidget {
  const ListViewItems({
    super.key,
    required this.items,
  });
  final List items;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 100,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 188, 250, 220)
            ),
            alignment: Alignment.center,
            child: Text('${items[index]}'));
        },
      ),
    );
  }
}