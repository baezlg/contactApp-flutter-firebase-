import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contackflutter/providers/user_provider.dart';
import 'package:contackflutter/screens/add_contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contackflutter/models/user.dart' as model;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    getUsername();
    addData();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
    print("add");
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)["username"];
    });
    print("get");
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: [Text("Home"), AddContact()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "", backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: "",
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
