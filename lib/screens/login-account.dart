import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/screens/create-account.dart';
import 'package:notes/screens/home-page.dart';
import 'package:notes/widget/themes.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({super.key});

  @override
  State<LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {
  TextEditingController eemail = TextEditingController();
  TextEditingController epassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.mainColor,
      appBar: AppBar(
        title: Text(
          "Login",
        ),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: eemail,
                keyboardType: TextInputType.emailAddress,
                style: Themes.mainContent.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                  hintStyle: Themes.mainContent.copyWith(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white,width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Themes.accentColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: epassword,
                keyboardType: TextInputType.text,
                style: Themes.mainContent.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter your Password",
                  hintStyle: Themes.mainContent.copyWith(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white,width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Themes.accentColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (eemail.text.isNotEmpty && epassword.text.isNotEmpty) {
                    try {
                      UserCredential userData = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: eemail.text.trim(),
                              password: epassword.text.trim());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Login Successfully.',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                      if (userData.user != null) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    } on FirebaseAuthException catch (e) {
                      print(
                          "#########Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${e.message.toString()}',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please fill in all fields.',
                          style: TextStyle(color: Colors.white),
                        ),
                        duration: Duration(
                            seconds: 2), // Adjust the duration as needed
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text("Login")),
            SizedBox(
              height: 12,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CreateAccount()));
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
