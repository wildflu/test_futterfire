

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testn/model/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../components/user_comp.dart';
import '../get_controller/data_user.dart';

final _firebasestore = FirebaseFirestore.instance;


class HomePage extends StatelessWidget {
  HomePage({super.key});
  UserData userDB = Get.put(UserData());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void onRefresh() async{
    userDB.getUsersData();
    _refreshController.refreshCompleted();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Test"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => userDB.filterByInterests(['travel']),
        label: const Text('sorted Users')
      ),
      body: GetBuilder<UserData>(
          init: UserData(),
          builder: (controller) {
          return SmartRefresher(
            onRefresh: onRefresh,
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            header: WaterDropHeader(),
            child: ListView.builder(
              itemCount: userDB.userData.length,
              itemBuilder: (context, index) {
                return UserComp(user: userDB.userData[index]);
              },
            ),
          );
      }
    ));
  }
}

class StremOnUsers extends StatelessWidget {
  const StremOnUsers({super.key});
  @override
  Widget build(BuildContext context) {
    List userIntrast = [];
    List<User> listUsers = [];
    return StreamBuilder<QuerySnapshot>(
              stream: _firebasestore.collection('users').snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const CircularProgressIndicator();
                }
                final usersDocs = snapshot.data!.docs;
                for (var userdoc in usersDocs) {
                  final id = userdoc.get('id');
                  final name = userdoc.get('name');
                  final friends = userdoc.get('friends');
                  final interests = userdoc.get('interests');
                  User user =  User(id, name, friends, interests );
                  listUsers.add(user);
                }
                return ListView.builder(
                  itemBuilder: (context, index) => UserComp(user: listUsers[index]),
                );
              }
          );
  }
}