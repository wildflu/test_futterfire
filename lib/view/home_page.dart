


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:testn/model/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../get_controller/data_user.dart';
import '../get_controller/pagenation_controller.dart';

final _firebasestore = FirebaseFirestore.instance;


// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  UserData userDB = Get.put(UserData());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void onRefresh() async{
    userDB.getUsersData();
    _refreshController.refreshCompleted();
  }
  // this is the functions that load more that
  void onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    bool nomoredata = await userDB.loadMore();
    if(!nomoredata) {
      _refreshController.loadComplete();
      
    } else {
      _refreshController.loadNoData();
    }
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
            onTap: (){},
            child: const Icon(Icons.nest_cam_wired_stand_outlined),
            label: "name",
          ),
          SpeedDialChild(
            // onTap: ()=>userDB.filterByInterests(['50'], 'f'),
            child: const Icon(Icons.face_retouching_natural),
            label: "freind",
          ),
          SpeedDialChild(
            // onTap: () => userDB.filterByInterests(['travel'], 'i'),
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
            onLoading: onLoading,
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            header: const WaterDropHeader(),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 3,crossAxisSpacing: 3, mainAxisExtent: 100),
              itemCount: userDB.userData.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)
                  ),
                  child: Column(
                    children: [
                      Text(userDB.userData[index].toString()),
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
  final PaginationController _paginationController = PaginationController();
    List<User> listUsers = [];
    
    return StreamBuilder<QuerySnapshot>(
              stream: _firebasestore.collection('users')
              .limit(_paginationController.pageSize)
              .startAfterDocument(_paginationController.lastDocument!)
              .snapshots(),
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
                if (usersDocs.isNotEmpty) {
                  _paginationController.nextPage(usersDocs.last);
                }
                return ListView.builder(
                  itemCount: listUsers.length,
                  itemBuilder: (context, index) => Text('ddd'),
                );
              }
          );
  }
}