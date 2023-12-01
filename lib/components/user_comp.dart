

import 'package:flutter/material.dart';

import '../model/user.dart';
import 'listview_item_viewer.dart';

class UserComp extends StatelessWidget {
  const UserComp({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black12),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            left: 10,
            child: Text(user.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2),textAlign: TextAlign.center,)
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 136, 253, 197),
                    Colors.white
                  ]
                )
              ),
            ),
          ),
          const Positioned(
            bottom: 130,
            left: 10,
            child: Text('Friends', style: TextStyle(fontWeight: FontWeight.bold),)),
          Positioned(
            bottom: 80,
            right: 0,
            left: 0,
            child: ListViewItems(items: user.friends),
          ),
          const Positioned(
            bottom: 50,
            left: 10,
            child: Text('Interests', style: TextStyle(fontWeight: FontWeight.bold),)),
          Positioned(
            bottom: 2,
            right: 0,
            left: 0,
            child: ListViewItems(items: user.interests),
          )
        ],
      ),
    );
  }
}


class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*0.0007000,size.height*0.2015600);
    path_0.quadraticBezierTo(size.width*0.4964000,size.height*0.5914800,size.width,size.height*0.2015600);
    path_0.quadraticBezierTo(size.width*1.0009000,size.height*0.4015600,size.width*1.0035500,size.height*1.0015600);
    path_0.lineTo(0,size.height*1.0015600);
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
