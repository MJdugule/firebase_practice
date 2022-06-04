import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  String? uid;
  String emails = '';
  String passwords = '';
  DocumentSnapshot? snapshot;

  // create reference collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  User? user = FirebaseAuth.instance.currentUser;

  Future updateUsers(String email, String password) async {
    return await userCollection.doc(user?.uid).set({
      'email': email,
      'password': password,
    });
  }

  getUserDetails() async {
    DocumentSnapshot result = await userCollection.doc(user?.uid).get();

    snapshot = result;
    emails = snapshot?['email'];
    passwords = snapshot?['password'];

    // print(emails);
    // print(passwords);
    //  print(result['password']);
    //this.image = snapshot?['profile_pic'];
    //saveDetail();

    return result;
  }
}
