import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contackflutter/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // SIGN UP
  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    String res = "Error ocurred";

    try {
      if (username.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user =
            model.User(username: username, email: email, password: password);

        print(cred.user!.uid);
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Not Authenticated";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "All fields required";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> signOut() async {
    var t = "signout";
    await _auth.signOut();
    return t;
  }
}
