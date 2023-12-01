

import 'package:flutter/material.dart';

import '../model/user.dart';

class UserComp extends StatelessWidget {
  const UserComp({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black12),
      ),

      child: Stack(
        children: [
          Positioned(
            top: 10,
            child: Text(user.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2, ),)
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.greenAccent,
                    Colors.white
                  ]
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*-0.0016500,size.height*0.4002000);
    path_0.quadraticBezierTo(size.width*0.4974500,size.height*0.6510400,size.width*1.0016500,size.height*0.4000400);
    path_0.quadraticBezierTo(size.width*1.0020750,size.height*0.5503700,size.width*1.0033500,size.height*1.0013600);
    path_0.lineTo(size.width*-0.0016500,size.height*1.0013600);

    return path_0;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}



