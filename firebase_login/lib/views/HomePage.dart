import 'package:firebase_login/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text(
                    "Home Page",
                    style: TextStyle(fontSize: 40),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout,
                      size: 30,
                    ),
                    onPressed: () async {
                      final userOut =
                          await Provider.of<Auth>(context, listen: false)
                              .signOut();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
