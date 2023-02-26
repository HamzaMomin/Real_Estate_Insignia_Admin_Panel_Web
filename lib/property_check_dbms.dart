// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_application/utils/utlis.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Button/roundbutton.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({Key? key}) : super(key: key);

  @override
  State<PropertyScreen> createState() => _HomeScreenState();
}

bool loading = false;
final postRef = FirebaseDatabase.instance.ref().child('UserApplication');

final firestore = FirebaseFirestore.instance.collection('Veri').snapshots();

DatabaseReference refence =
    FirebaseDatabase.instance.ref().child('UserApplication');
TextEditingController descricontroller = TextEditingController();

deleterecord(var key) async{

 await postRef.child('UserVeriRequest').child(key).remove();

}


class _HomeScreenState extends State<PropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: AppBar(
          title: const Center(child: Text('Property List')),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                    query: postRef.child('UserVeriRequest'),
                    itemBuilder: (context, snapshot, animation, index) {
                      {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage.assetNetwork(
                                    fit: BoxFit.fill,
                                    height: 350,
                                    width: 350,
                                    placeholder: 'assets/Logo.png',
                                    image: snapshot
                                        .child('Image Url')
                                        .value
                                        .toString()),
                              ),

                              const Divider(
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(
                                        child: Text(
                                            snapshot
                                                .child('Price')
                                                .value
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      width: 120,
                                      color: Colors.deepPurple,
                                      child: Center(

                                          // ignore: deprecated_member_use
                                          child: InkWell(
                                              child: Text(
                                                  snapshot
                                                      .child('Mobile Number')
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  )),
                                              onTap: () {
                                                launch('tel:' +
                                                    snapshot
                                                        .child('Mobile Number')
                                                        .value
                                                        .toString());
                                              }
                                              // '${FirebaseAuth.instance.currentUser?.phoneNumber}'

                                              )
                                          // child: Text(
                                          //     snapshot
                                          //         .child('Mobile Number')
                                          //         .value
                                          //         .toString(),
                                          //     style: TextStyle(
                                          //       fontSize: 18,
                                          //       color: Colors.white,
                                          //     )
                                          //     )
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Society Name : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(snapshot
                                      .child('Housing Society')
                                      .value
                                      .toString()),
                                  SizedBox(
                                    width: 90,
                                  ),
                                  Text('Purpose : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Purpose')
                                      .value
                                      .toString()),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Plot Size : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('Plot Size')
                                      .value
                                      .toString()),
                                  const SizedBox(
                                    width: 70,
                                  ),
                                  const Text('Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(snapshot
                                      .child('User Name')
                                      .value
                                      .toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // const Text('Property details : ',
                              //     style:
                              //         TextStyle(fontWeight: FontWeight.w700)),
                              // Text(snapshot
                              //     .child('Property details')
                              //     .value
                              //     .toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Email : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                  snapshot.child('User Email').value.toString(),
                                  style: TextStyle(color: Colors.blueGrey)),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Description : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              Text(snapshot
                                  .child('Description')
                                  .value
                                  .toString()),

                              // ignore: dead_code
                              const SizedBox(
                                height: 20,
                              ),

                              Text(
                                'User ID: ',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),

                              Row(
                                children: [
                                  Text(
                                    snapshot.child('User ID').value.toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red),
                                  ),
                                  PopupMenuButton(
                                      icon: Icon(Icons.more_vert),
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              onTap: () {
                                                var key = snapshot.key;
                                                    print(key.toString());
                                                  deleterecord(key);
                                              },
                                              value: 1,
                                              child: ListTile(
                                                  leading: Icon(Icons.delete),
                                                  title: Text('Delete')),
                                            )
                                          ]),
                                ],
                              ),

                              //firestore dealveri ka message idr show ho ga

                              //                    StreamBuilder<QuerySnapshot>(
                              //   stream: firestore,
                              //   builder: (BuildContext context,
                              //       AsyncSnapshot<QuerySnapshot> snapshot) {
                              //     if (snapshot.connectionState == ConnectionState.waiting)
                              //       return CircularProgressIndicator();

                              //     if (snapshot.hasError) return Text('Connection Error!!');

                              //     return Expanded(
                              //         child: ListView.builder(
                              //             itemCount: snapshot.data!.docs.length,
                              //             itemBuilder: (context, index) {
                              //               return ListTile(
                              //                 leading: Text(
                              //                   'Verification Status :',
                              //                   style: TextStyle(
                              //                       fontSize: 10, color: Colors.black),
                              //                 ),
                              //                 title: Center(
                              //                     child: Text(
                              //                   snapshot.data!.docs[index]['Message']
                              //                       .toString(),
                              //                   style: TextStyle(
                              //                       fontSize: 10, color: Colors.black),
                              //                 )),

                              //               );
                              //             }));
                              //   },
                              // ),

                              const SizedBox(
                                height: 40,
                              ),

                              // RoundButton(title: 'Delete', onTap: (){

                              //     refence.child(snapshot.child('UserApplication').value.toString()).remove();
                              // }),

                              Divider(
                                color: Colors.grey.shade800,
                              ),
                            ]);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



    // StreamBuilder<QuerySnapshot>(
    //             stream: FirebaseFirestore.instance
    //                 .collection('PropertyList')
    //                 .snapshots(),
    //             builder: (BuildContext context,
    //                 AsyncSnapshot<QuerySnapshot> snapshot) {
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return CircularProgressIndicator();
    //               }
    //               if (snapshot.hasError) {
    //                 return Text('Connection Error');
    //               }
    //               // ignore: dead_code
    //               return Expanded(
    //                   child: ListView.builder(
    //                       itemCount: snapshot.data!.docs.length,
    //                       itemBuilder: (context, index) {
    //                         return Column(children: [
    //                           Container(
    //                             child: Text(snapshot.data!.docs[index]['User Email']
    //                                 .toString()),
    //                           )
    //                         ]);
    //                       }));
    //             }),