import 'package:flutter/material.dart';
import 'package:notes/widget/themes.dart';
import 'login-account.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController ename = TextEditingController();
  TextEditingController eemail = TextEditingController();
  TextEditingController epassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.mainColor,
      appBar: AppBar(
        title: Text(
          "Create Account",
        ),
        elevation: 2.0,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginAccount()));
              },
              child: Text(
                "Login",style: TextStyle(color: Colors.black),
              ))
        ],
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
                controller: ename,
                keyboardType: TextInputType.text,
                style: Themes.mainContent.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter your Name",
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
                  if (ename.text.isNotEmpty &&
                      eemail.text.isNotEmpty &&
                      epassword.text.isNotEmpty) {
                    try {
                      UserCredential userData = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: eemail.text.trim(),
                              password: epassword.text.trim());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Account Created Successfully.',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                      if (userData.user != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginAccount()));
                      }
                    } on FirebaseAuthException catch (e) {
                      print("############${e.code.toString()}");
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
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
