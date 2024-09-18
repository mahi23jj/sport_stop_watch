import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/sign_in.dart';

class signs extends StatefulWidget {

  signs({super.key});

  @override
  State<signs> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<signs> {
  Color g = Color.fromRGBO(214, 243, 87, 1);
  Color w = Colors.white;
  Color box = const Color.fromARGB(255, 41, 40, 40);
  Color bo = Color.fromARGB(255, 65, 64, 64);
  TextEditingController lapcontroller = TextEditingController();
  TextEditingController laps = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String _errorMessage = '';

 Future<void> _signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Navigate to the main page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MyHomePage()));
    } catch (e) {
      setState(() {
         _errorMessage = 'Error signing in: $e';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Container(
          decoration: BoxDecoration( image: DecorationImage(
                  image: AssetImage('asset/2.jpg'),
                   fit: BoxFit.cover,
                   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                  
                  ),),
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 200),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 35),
            //color: g,
           decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Colors.white.withOpacity(0.5), // Semi-transparent white
      Color(0xFFE0E0E0).withOpacity(0.5), // Semi-transparent light gray
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Center(
                 child: Text(
                           'Stop watch',
                           style: TextStyle(
                  color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                         ),
               ), 
        
         SizedBox(height: 20,),
          TextFormField(controller:lapcontroller,decoration: InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),labelText: 'EMAIL',labelStyle: TextStyle(color: Colors.black),),),
             SizedBox(height: 20,),
             TextFormField(controller:laps,decoration: InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),labelText: 'Password',labelStyle: TextStyle(color: Colors.black),),),
             SizedBox(height: 40,),
             Center(
               child: ElevatedButton(onPressed: (){
                _signIn(lapcontroller.text,laps.text);
               }, child: Text('Log in',style: TextStyle(color: Colors.blue))),
             ),
              SizedBox(height: 15,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>sign()));
              }, 
              child: Text('Create account',style: TextStyle(color: Colors.blue),)),
                  if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),

              ],

            ),
          ),
        )),
      ),
    );
  }
}
