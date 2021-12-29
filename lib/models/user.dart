import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String password;

  const User({
    required this.username,
    required this.email,
    required this.password,
  });


  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      email: snapshot["email"],
      password: snapshot["password"],
    );
  }
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
