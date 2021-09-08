import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/views/HomePage.dart';
import 'package:firebase_login/views/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Provider<Auth>(
    create: (context) => Auth(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

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
                      "Welcome To Firebase",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#ff1744")),
                    ),
                    Text(
                      "Log In",
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
                    SizedBox(height: 10),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Log in"),
                        TextButton(
                          child: Text(
                            "Anonim",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          onPressed: () async {
                            final user =
                                await Provider.of<Auth>(context, listen: false)
                                    .signInAnonim();
                            print(user.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 50,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final user =
                                await Provider.of<Auth>(context, listen: false)
                                    .signInWithEmailAndPassword(
                                        inputName, inputPass);
                            print(user.uid);

                            if (!user.emailVerified) {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog();
                                  });
                              await Provider.of<Auth>(context, listen: false)
                                  .signOut();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            return null;
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
