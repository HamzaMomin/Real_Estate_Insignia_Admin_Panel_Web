import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_application/Button/roundbutton.dart';
import 'package:flutter_web_application/property_check_dbms.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  final firestore =
      FirebaseFirestore.instance.collection('UserApplication').snapshots();
  //storage ref hai

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 50, 60, 65),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 136, 85, 224),
          automaticallyImplyLeading: true,
          title: const Center(
            child: Text('Allotment Letters',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         RoundButton( loading: loading,
            //           title: 'Property Info',

            //           onTap: () {

            //               setState(() {
            //                 loading = true;
            //               });
            //              Navigator.push(context,
            // MaterialPageRoute(builder: (context) =>  PropertyScreen())
            // );

            //           })],
            //     ),DocuVerfiScreen

            //   ),


              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();

                  if (snapshot.hasError) return Text('Connection Error!!');

                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text(
                                'User Email / User ID ',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              title: Center(
                                  child: Text(
                                snapshot.data!.docs[index]['User Email']
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )),
                              subtitle: Image(
                                image: NetworkImage(snapshot
                                    .data!.docs[index]['DocuImage']
                                    .toString()), // ----------- the line that should change
                                width: 300,
                                height: 300,
                              ),
                              trailing:

                                   Text(
                                snapshot.data!.docs[index]['User ID']
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),

                              ),
                              
                            );
                          })
                          );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       RoundButton(title: 'Property Check', onTap: () {}),
              //     ],
              //   ),
              // )
            ]),
      ),
    );
  }
}
