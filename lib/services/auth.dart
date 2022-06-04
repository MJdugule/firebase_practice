import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/main.dart';
import 'package:firebase_practice/models/user.dart';
import 'package:firebase_practice/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// create a user obj from firebase user
  MyUser? _customUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

// stream for user auth changes
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_customUser);
  }

  // sign up
  Future registerEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create document as users sign up
      await DatabaseService().updateUsers(email, password);
      return _customUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in
  Future signInEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _customUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // google sign in
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    String userGoogle = googleUser!.email;
    String userPass = 'not used';
    await DatabaseService().updateUsers(userGoogle, userPass);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // phone number authentication
  Future signInWithPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+1 650 555 3434',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = '654321';
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        await _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
