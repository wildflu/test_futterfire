

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../get_controller/data_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    UserData userDb = Get.put(UserData());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Test"),
      ),
      body: Container(
        child: GetBuilder<UserData>(
          init: UserData(),
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.userData.length,
              itemBuilder: (context, index) {
                return Container(child: Text('name'));
              },
            );
          },
        ),
      ),
    );
  }
}