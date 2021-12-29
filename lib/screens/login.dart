import 'package:contackflutter/screens/home.dart';
import 'package:contackflutter/screens/signup.dart';
import 'package:contackflutter/services/auth.dart';
import 'package:contackflutter/utils/utils.dart';
import 'package:contackflutter/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Text("Kontakt",
              style: GoogleFonts.lobster(
                fontSize: 40,
              )),
          SizedBox(
            height: 64,
          ),
          TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress),
          SizedBox(
            height: 24,
          ),
          TextFieldInput(
            textEditingController: _passwordController,
            hintText: "Enter your password",
            textInputType: TextInputType.text,
            isPass: true,
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: const Text("Don't have an account? "),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                onTap: navigateToSignUp,
                child: Container(
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: loginUser,
            child: Container(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    )));
  }
}
