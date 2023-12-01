

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserData extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<User> userData = [];
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future getUsersData() async{
    userData.clear();
    QuerySnapshot querySnapshot = await usersCollection.get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> datadoc = documentSnapshot.data() as Map<String, dynamic>;
      User user = User(datadoc['id'], datadoc['name'], datadoc['friends'], datadoc['interests']);
      userData.add(user);
    }
    update();
  }

  filterByInterests(List<String> intreKey){
    List<User> filteredUsers = userData.where((user) {
      return user.interests.any((interest) => intreKey.contains(interest));
    }).toList();
    userData = filteredUsers;
    update();
  }



  @override
  void onInit() {
    super.onInit();
    getUsersData();
  }
}


