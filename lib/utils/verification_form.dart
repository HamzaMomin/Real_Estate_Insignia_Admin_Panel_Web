import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_application/utils/utlis.dart';

import 'package:image_picker/image_picker.dart';

import '../Button/roundbutton.dart';


class DealForm extends StatefulWidget {
  const DealForm({Key? key}) : super(key: key);

  @override
  State<DealForm> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<DealForm> {
  //text ko hold krty


  bool loading = false;
 



  //firebase firestore

  final firestore = FirebaseFirestore.instance.collection('Veri');

  //storage ref hai
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  
TextEditingController messagecontroller = TextEditingController();

//firestore mai image save ho serf document verification wali


  //future function to pick single image
  




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
         
          title: Center(
              child: Text(
            'Document Verification Form',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(
              height: 20,
            ),
            
            SizedBox(
              height: 10,
            ),
           
      const SizedBox(height: 50,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60 , vertical: 60),
                      child: TextFormField(
                      minLines: 5,
                      maxLines: 20,
                      controller: messagecontroller,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Enter Status : ',
                             
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Something';
                        }
                        return null;
                      },
                  ),
                    ),

              SizedBox(height: 50,),


            RoundButton(
                title: 'Upload',
                loading: loading,
                onTap: () async {
                 setState(() {
                   loading = true;
                 });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  firestore.doc(id).set({

                      'Message' : messagecontroller.text.toString()

                  }).then((value){
                        Utils().toastMessage('Message Uploaded');
                        setState(() {
                   loading = false;
                 });
                  }).onError((error, stackTrace) {
                     Utils().toastMessage(error.toString());
                      setState(() {
                   loading = false;
                 });
                  });
                 


              
                               


                }),

          
          ]),
     ]   )
     ),
    );
  }
}
