import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  const Cover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/cover.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Text(
            "Welcome to the World of Food",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
