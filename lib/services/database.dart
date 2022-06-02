import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;
  DatabaseService({required this.uid});

  // create reference collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUsers(String name, int age, String sex) async {
    return await userCollection.doc(uid).set({
      'userName': name,
      'userAge': age,
      'userSex': sex,
    });
  }
}
