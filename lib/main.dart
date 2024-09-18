import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:stopwatch/login.dart';
import 'package:stopwatch/sign_in.dart';
import 'package:stopwatch/tag.dart';
import 'package:stopwatch/test.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBlTYfFd5W0fk2ELD0oVIXOPSy9DmvHLuY",
        appId: "1:953539689403:web:4b52be341be90317b4e29e",
        messagingSenderId: "953539689403",
        projectId: "login-4471f",
        storageBucket: "login-4471f.appspot.com",
      ),
    );
  }

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        //useMaterial3: true,
      ),
      home: sign(), //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
//const MyHomePage(title: 'Stop watch'),
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, e});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isRunning = false;
  List<bool> ck = [false, false, false];
  Color g = Color.fromRGBO(214, 243, 87, 1);

  Color w = Colors.white;
  Color box = const Color.fromARGB(255, 41, 40, 40);
  Color bo = Color.fromARGB(255, 65, 64, 64);
  // Default is centimeters




  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    _stopwatch.start();
    _isRunning = true;
  }

  void _stopStopwatch() {
    _timer.cancel();
    _stopwatch.stop();
    _isRunning = false;
    setState(() {});
  }

  List<String> lap = [];
  Future addto(String lap, String intes, String target) async {
    await FirebaseFirestore.instance
        .collection('sport')
        .doc('1')
        .collection('laps')
        .add({
      'lap': lap,
      'time': DateTime.now(),
      'intensity': intes,
      'target': target
    });
  }

  void _resetStopwatch() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stop Watch'), // Optional title
          content: Text('do you want to save it ?'), // Message content
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                       String x = _formatTime(_stopwatch.elapsedMilliseconds);
                    setState(() {
                      _stopwatch.reset();
                      
                    });

                    Navigator.pop(context);
                 
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => tagpage(lap: x,),
                        ));
                  },
                ),
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    setState(() {
                      _stopwatch.reset();
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }



  String _formatTime(int milliseconds) {
    var seconds = milliseconds ~/ 1000;
    var minutes = seconds ~/ 60;
    var hours = minutes ~/ 60;
    var formattedTime =
        '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}.${(milliseconds % 1000).toString().padLeft(3, '0')}';
    return formattedTime;
  }

  //Color sec = Color.fromARGB(237, 114, 168, 27);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Padding(
      //     padding: const EdgeInsets.only(top: 10.0),
      //     child: Text(
      //       'stop watch',
      //       style: TextStyle(
      //           color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
         decoration: BoxDecoration( image: DecorationImage(
                  image: AssetImage('asset/3.jpg'),
                   fit: BoxFit.cover,
                   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                  
                  ),),
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 200),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 125),
          //  color: g,
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
              children: [
                Text(
                  _formatTime(_stopwatch.elapsedMilliseconds),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed:
                          _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                      child: Text(_stopwatch.isRunning ? 'Stop' : 'Start',style: TextStyle(color: Colors.blue)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _resetStopwatch,
                      child: const Text('Reset',style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.5)),
                        onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>history()));
                        },
                        child: const Text('History',style: TextStyle(color: Colors.blue),),
                      ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
