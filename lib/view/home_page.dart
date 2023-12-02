


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:testn/model/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.ellipsis_search,
        animationDuration: const Duration(milliseconds: 700),
        spacing: 15,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            onTap: ()=>userDB.filterByInterests(['Diana'], 'f'),
            child: const Icon(Icons.nest_cam_wired_stand_outlined),
            label: "name",
          ),
          SpeedDialChild(
            onTap: ()=>userDB.filterByInterests([50], 'f'),
            child: const Icon(Icons.face_retouching_natural),
            label: "freind",
          ),
          SpeedDialChild(
            onTap: () => userDB.filterByInterests(['travel'], 'i'),
            child: const Icon(Icons.interests_outlined),
            label: "Interests",
          )
        ],
        child: FloatingActionButton(
          onPressed: () => {},
          child: const Icon(Icons.sort),
        ),
      ),
      body: GetBuilder<UserData>(
          init: UserData(),
          builder: (controller) {
          return SmartRefresher(
            onRefresh: onRefresh,
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            header: const WaterDropHeader(),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 3,crossAxisSpacing: 3, mainAxisExtent: 300),
              itemCount: userDB.userData.length,
              itemBuilder: (context, inde) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        right: 10,
                        left: 10,
                        child: Text(userDB.userData[inde].name, textAlign: TextAlign.center,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                      Positioned(
                        bottom: 70,
                        left: 5,
                        right: 0,
                        child: Container(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: userDB.userData[inde].friends.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${userDB.userData[inde].friends[index]}'),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 5,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: userDB.userData[inde].interests.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${userDB.userData[inde].interests[index]}'),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
      }
    )
    );
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
                  itemBuilder: (context, index) => Text('d'),
                );
              }
          );
  }
}