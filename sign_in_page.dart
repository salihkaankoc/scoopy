import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:scoopy/homepage.dart';
import 'package:scoopy/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>;
  bool isLoggedin = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  "assets/loginn.png",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 50,
                width: 300,
                child: TextFormField(
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      labelText: 'E-Mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 72,
                width: 300,
                child: TextFormField(
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    helperText: 'Şifre en az 6 karakterli olmalı.',
                    prefixIcon: const Icon(Icons.vpn_key),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    labelText: 'Şifre',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text(
                  'Hesabınız yok mu? Buradan kaydolabilirsiniz.',
                  style: TextStyle(
                    color: Color(0xFF2D365C),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              MaterialButton(
                elevation: 2,
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: 150,
                color: Color(0xFF2D365C),
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Lütfen Tüm Alanları Doldurunuz.",
                      toastLength: Toast.LENGTH_SHORT, // length
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Color(0xFF2D365C),
                    );
                  } else {
                    signInNew();
                  }
                },
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signInNew() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
