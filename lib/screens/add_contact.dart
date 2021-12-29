import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({ Key? key }) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text("Post to"),
      ),
      body: Text("add contact"),
    );
  }
}