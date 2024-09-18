import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  Stream<QuerySnapshot>? _userStream;
  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('sport')
        .doc('1')
        .collection('laps')
        .snapshots();
    //_userStream = FirebaseFirestore.instance.collection('one').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
   
      body: Container(
        height: MediaQuery.of(context).size.height,
         decoration: BoxDecoration( image: DecorationImage(
                  image: AssetImage('asset/1.jpg'),
                   fit: BoxFit.cover,
                   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                  
                  ),), 
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        SizedBox(width: 20,),
        Center(child: Text('History',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
        SizedBox(width: 20,),
        IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_sharp,color: Colors.white,))
                ],
              ),
              StreamBuilder(
                  stream: _userStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
              
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
                    }
                    var docment = snapshot.data!.docs;
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height*0.7,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(color: Colors.white,);
                          },
                          itemBuilder: (context, index) {
                            var doc = docment[index];
                            Timestamp times = doc['time'];
                            return ListTile(
                              trailing: Text(
                                '${times.toDate().day}-${times.toDate().month}-${times.toDate().year}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            title: Text(
                                doc['lap'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:Row(children: [
                                 Container(alignment: Alignment.center,width: 50,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.grey[300] ),child: Text(
                                doc['intensity'],
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),),
                              SizedBox(width:15 ,),
                                Container(alignment: Alignment.center,width: 50,
                                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.grey[300] ),child: Text(
                                doc['target'],
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),)
                              ],) ,
                            );
              
                          },
                          itemCount: docment.length,
                        ),
                      );
                    } else {
                      return Text('No data');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
