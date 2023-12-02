

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class UserData extends GetxController {
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  List<User> userData = [];

  Future getUsersData() async{
    // userData.clear();
    QuerySnapshot querySnapshot = await usersCollection.get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> datadoc = documentSnapshot.data() as Map<String, dynamic>;
      User user = User(datadoc['id'], datadoc['name'], datadoc['friends'], datadoc['interests']);
      userData.add(user);
    }
    update();
  }

  filterByInterests(List intreKey, target){
    List<User> filteredUsers = userData.where((user) {
      // return user.interests.any((interest) => intreKey.contains(interest));
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


