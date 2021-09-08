import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_login/main.dart';
import 'package:firebase_login/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;

  String inputName = "";
  String inputPass = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#ff1744")),
                    ),
                    SizedBox(height: 60),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Lütfen bir Email Giriniz!";
                        } else if (!EmailValidator.validate(value)) {
                          return "Lütfen doğru bir e posta giriniz!";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String index) {
                        inputName = index;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusColor: Colors.redAccent,
                        hoverColor: Colors.redAccent,
                        icon: Icon(
                          Icons.email,
                          size: 22,
                          color: HexColor("#ff1744"),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        fillColor: HexColor("#ff8a80"),
                        filled: true,
                        labelText: "E-Mail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      maxLength: 15,
                      cursorColor: Colors.white,
                      onChanged: (String index) {
                        inputPass = index;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Lütfen Bir Şifre Giriniz!";
                        } else if (value.length < 6) {
                          return "Lütfen 5 karakterden daha uzun bir şifre giriniz";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.password,
                          size: 22,
                          color: HexColor("#ff1744"),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                        fillColor: HexColor("#ff8a80"),
                        filled: true,
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Lütfen bir Şifre Giriniz!";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusColor: Colors.redAccent,
                        hoverColor: Colors.redAccent,
                        icon: Icon(
                          Icons.pending_outlined,
                          size: 22,
                          color: HexColor("#ff1744"),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        fillColor: HexColor("#ff8a80"),
                        filled: true,
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 50,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final user =
                                await Provider.of<Auth>(context, listen: false)
                                    .createUserWithEmailAndPassword(
                                        inputName, inputPass);
                            if (!user.emailVerified) {
                              await user.sendEmailVerification();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
