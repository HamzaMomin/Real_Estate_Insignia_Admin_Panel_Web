import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_application/Button/roundbutton.dart';
import 'package:flutter_web_application/property_check_dbms.dart';
import 'package:flutter_web_application/utils/verification_form.dart';
import 'package:flutter_web_application/utils/utlis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Firebase_auth/mobile_number.dart';
import 'admin.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
DatabaseReference refence =
    FirebaseDatabase.instance.ref().child('UserApplication');


void delete(id)
{
  FirebaseFirestore.instance.collection('UserApplication').doc(id).delete();
  Fluttertoast.showToast(msg: 'Allotment Record Deleted!');
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 59, 122, 173),
        automaticallyImplyLeading: false,
        title: Text(
          'Dashbord',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.list),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  const Icon(
                    (Icons.admin_panel_settings_outlined),
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Center(
                    child: Text(
                      'Admin Dashboard',
                      style: TextStyle(fontSize: 25.0, color: Colors.white60),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.grey,
              ),
              Container(
                // ignore: prefer_const_constructors
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/admin.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    //idr profile aa jaay ge
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminProfile()));
                    setState(() {
                      loading = true;
                    });
                  },
                  child: Text(
                    'Admin Profile',
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  )),
              SizedBox(height: 20),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                  title: 'Allotment Letters',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    setState(() {
                      loading = true;
                    });
                  }),
              SizedBox(height: 20),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              RoundButton(
                  title: 'Property List',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PropertyScreen()));
                    setState(() {
                      loading = true;
                    });
                  }),
              SizedBox(height: 20),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              RoundButton(
                  title: 'Log Out',
                  loading: loading,
                  onTap: () {
                    auth.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MobileNumber()));
                    Icon(Icons.logout_outlined);
                  })
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
              child: Text(
            'Firestore Data List',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
          )),
          SizedBox(
            height: 5,
          ),
          const Divider(
            height: 10,
            thickness: 2,
            color: Colors.grey,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('UserApplication')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    'Connection Error',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ));
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            DataTable(
                              // border: TableBorder.all(

                              // ),
                              columns: [
                                DataColumn(
                                    label: Text('ID',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('Email',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(
                                    Text(snapshot.data!.docs[index]['User ID']
                                        .toString()),
                                  ),
                                  DataCell(
                                    Text(snapshot
                                        .data!.docs[index]['User Email']
                                        .toString()),
                                  ),
                                  DataCell(IconButton(
                                    onPressed: () async{
                                      delete(snapshot.data?.docs[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,color: Colors.red,
                                    ),
                                  )),
                                ]),
                              ],
                            ),
                          ]);
                        }));
              }),
        ],
      ),
    ));
  }
}

//  Text(snapshot.data!.docs[index]['User Email']
//                                 .toString()),
//                                 SizedBox(height: 10,),
//                              Text(snapshot.data!.docs[index]['User ID']
//                                 .toString()),
