import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class tagpage extends StatefulWidget {
  String lap;
  tagpage({super.key, required this.lap});

  @override
  State<tagpage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<tagpage> {
  late Stopwatch _stopwatch;
  List<bool> ck = [false, false, false];
  List<bool> kc = [false, false, false];
  Color g = Color.fromRGBO(214, 243, 87, 1);
  Color w = Colors.white;
  Color box = const Color.fromARGB(255, 41, 40, 40);
  Color bo = Color.fromARGB(255, 65, 64, 64);
  // Default is centimeters
  var selected = '';
  var selecte = '';
  List<String> options = ['Strong', 'midium', 'weak'];
  List<String> option = ['Yes', 'partly', 'No'];

  void v(int x) {
    for (var i = 0; i < 3; i++) {
      if (x == i) {
        ck[i] = true;
        selected = options[x];
      } else {
        ck[i] = false;
      }
    }
    setState(() {});
  }

  void u(int x) {
    for (var i = 0; i < 3; i++) {
      if (x == i) {
        kc[i] = true;
        selecte = option[x];
      } else {
        kc[i] = false;
      }
    }
    setState(() {});
  }

  Widget tag() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
            onTap: () {
              v(0);
            },
            child: Container(
              alignment: Alignment.center,
              height: 33,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ck[0] ? Colors.blue : Colors.white),
              child: Text(
                '${options[0]}',
                style: TextStyle(color: ck[0] ? w : bo),
              ),
            )),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
            onTap: () {
              v(1);
            },
            child: Container(
              alignment: Alignment.center,
              height: 33,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ck[1] ? Colors.blue : Colors.white),
              child: Text(
                '${options[1]}',
                style: TextStyle(color: ck[1] ? w : bo),
              ),
            )),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
            onTap: () {
              v(2);
            },
            child: Container(
              alignment: Alignment.center,
              height: 33,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ck[2] ? Colors.blue : Colors.white),
              child: Text(
                '${options[2]}',
                style: TextStyle(color: ck[2] ? w : bo),
              ),
            )),
      ],
    );
  }

  Widget tags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
            onTap: () {
              u(0);
            },
            child: Container(
              alignment: Alignment.center,
              height: 33,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kc[0] ? Colors.blue : Colors.white),
              child: Text(
                '${option[0]}',
                style: TextStyle(color: kc[0] ? w : bo),
              ),
            )),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
            onTap: () {
              u(1);
            },
            child: Container(
              alignment: Alignment.center,
              height: 33,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kc[1] ? Colors.blue : Colors.white),
              child: Text(
                '${option[1]}',
                style: TextStyle(color: kc[1] ? w : bo),
              ),
            )),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
            onTap: () {
              u(2);
            },
            child: Container(
              alignment: Alignment.center,
              height: 33,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kc[2] ?Colors.blue : Colors.white),
              child: Text(
                '${option[2]}',
                style: TextStyle(color: kc[2] ?  w : bo),
              ),
            )),
      ],
    );
  }

  List<String> lap = [];
  Future addto(String lap, String intes, String target) async {
    await FirebaseFirestore.instance
        .collection('sport')
        .doc('1')
        .collection('laps')
        .add({
      'lap': lap,
      'time': Timestamp.now(),
      'intensity': intes,
      'target': target
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:  AppBar(
        backgroundColor:Colors.white.withOpacity(0.5),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text('Stop Watch',style: TextStyle(color: Colors.white),),
        ),
        centerTitle: true,
      ),
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
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 35),
           // color: g,
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
                Text(
                  '${widget.lap}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Activity Intensity',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                tag(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Target Reached',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                tags(),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        addto(widget.lap, selected, selecte);
                        // setState(() {
                        //   String x = _formatTime(
                        //       _stopwatch.elapsedMilliseconds);
                        //   lap.add(x);
                        //   _stopwatch.reset();
                        Navigator.pop(context);
                        // });
                      },
                      child: Text('save')),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
