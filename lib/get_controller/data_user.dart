

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class UserData extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<User> userData = [];
  


  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
    .collection('users')
    .get()
    .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          User user = User(doc['id'], doc['name'], doc['friends'], doc['interests']);
          userData.add(user);
        }
    });
  }
  
}


