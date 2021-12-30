import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contackflutter/screens/login.dart';
import 'package:contackflutter/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  List contacts = [];

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigationTapped(int page) {
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)["username"];
      contacts = (snap.data() as Map<String, dynamic>)["contacts"];
      print(contacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Kontakt",
          ),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          actions: [
            Text(
              username,
              style: TextStyle(color: Colors.blue.shade400),
            ),
            TextButton(
                onPressed: () async {
                  await AuthMethods().signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text(
                  "logout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ))
          ],
        ),
        body: Row(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(username)
              ],
            )
          ],
        ));
  }
}
