

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class UserData extends GetxController {
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  List<User> userData = [];

  Future getUsersData() async{
    userData.clear();
    QuerySnapshot querySnapshot = await usersCollection.orderBy('id', descending:false).limit(15).get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> datadoc = documentSnapshot.data() as Map<String, dynamic>;
      User user = User(datadoc['id'], datadoc['name'], datadoc['friends'], datadoc['interests']);
      userData.add(user);
    }
    update();
  }

  Future<bool> loadMore()async{
    int index = userData.length;
    QuerySnapshot querySnapshot = await usersCollection.orderBy('id', descending: false).where('id', isGreaterThan: userData.length).limit(15).get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> datadoc = documentSnapshot.data() as Map<String, dynamic>;
      User user = User(datadoc['id'], datadoc['name'], datadoc['friends'], datadoc['interests']);
      userData.add(user);
    }
    update();
    return index == userData.length;
  }

  filterByInterests(List intreKey, target){
    List<User> filteredUsers = userData.where((user) {
      switch (target) {
        case 'i':
          return user.interests.any((interest) => intreKey.contains(interest));
        case 'f':
          return user.friends.any((friends) => intreKey.contains(friends));
        case 'n':
          return user.name = target;
        default:
          return user.interests.any((interest) => intreKey.contains(interest));
      }
    }).toList();
    userData = filteredUsers;
    update();
  }



  @override
  void onInit() async{
    super.onInit();
    await getUsersData();
  }
}


