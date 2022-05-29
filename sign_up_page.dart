import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:scoopy/homepage.dart';
import 'package:scoopy/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool trueEmail = false;
  final _formKey = GlobalKey<FormState>;
  final _key = GlobalKey;
  validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Lütfen Geçerli Bir Mail Adresi Girin.';
    } else {
      if (trueEmail = false) {
        setState(() {
          trueEmail = true;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    const String email = 'salihkaaankoc@gmail.com';
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
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
                  "assets/signup.png",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 50,
                width: 300,
                child: TextFormField(
                  onSaved: (value) {
                    nameController.text = user!.displayName.toString();
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'İsim',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: 300,
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    strutStyle: StrutStyle.disabled,
                    validator: (value) => validateEmail(value),
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      labelText: 'E-Mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 300,
                child: TextFormField(
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.vpn_key),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
                child: Text(
                  'Hesabınız var mı? Giriş yapın.',
                  style: TextStyle(
                    color: Color(0xFF2D365C),
                  ),
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: 150,
                color: Color(0xFF2D365C),
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      trueEmail == true) {
                    Fluttertoast.showToast(
                      msg: "Lütfen Tüm Alanları Doldurunuz.",
                      toastLength: Toast.LENGTH_SHORT, // length
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Color(0xFF2D365C),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Kayıt Başarılı!",
                      toastLength: Toast.LENGTH_SHORT, // length
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Color(0xFF2D365C),
                    );
                    signUp();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  }
                },
                child: const Text(
                  'Kaydol',
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

  Future signUp() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((kullanici) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(emailController.text)
            .update({
          "KullaniciAdi": nameController.text,
          "KullaniciEPosta": emailController.text
        });
      });
    }
  }
}
