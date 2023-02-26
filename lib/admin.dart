import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

// final FirebaseAuth auth = FirebaseAuth.instance;

final user = FirebaseAuth.instance.currentUser;
final TextEditingController myTextController = new TextEditingController();

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(30.0),
        //     bottomLeft: Radius.circular(30.0)),
        image: const DecorationImage(
          image: AssetImage('assets/BG.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Center(child: Text('Admin Profile')),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: AssetImage('assets/Admin.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              )),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'Admin ID: ${FirebaseAuth.instance.currentUser?.uid}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              Center(
                  child: Text(
                'Admin Mobile Number : ${FirebaseAuth.instance.currentUser?.phoneNumber}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
              SizedBox(height: 15),
              // TextFormField(
              //   //keybord numbers wala display ho ga

              //   style: TextStyle(color: Colors.white),
              //   controller: myTextController,
              //   maxLength: 20,
              //   decoration: InputDecoration(
              //       hintText: 'Enter your Email Address',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(20.0))),
              // ),
            ]),
      ),
    );
  }
}
