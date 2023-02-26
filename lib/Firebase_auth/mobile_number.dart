// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_application/Firebase_auth/verifiy_OTP_mobile_screen.dart';
import 'package:flutter_web_application/utils/utlis.dart';
import '../Button/roundbutton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  bool loading = false;
  final phonenumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  //firebase database for table
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurple,
      //   automaticallyImplyLeading: false,
      //   title: Center(child: Text('Real Estate Insigina Web Portal')),
      // ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          // SizedBox(width: 20,),

          // SizedBox(height: 25,),

          Flexible(
              flex: 35, // 15%
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                    image: const DecorationImage(
                      image: AssetImage('assets/Login.png'),
                      fit: BoxFit.fill,
                    ),
                    // shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Enter Mobile Number with +92 code :',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            //keybord numbers wala display ho ga

                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.white),
                            controller: phonenumberController,
                            maxLength: 13,
                            decoration: InputDecoration(
                                hintText:
                                    'Enter your phone Number +923335368381',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),

                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[+ 0-9]+$'))
                            ],
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[+ 0-9]+$').hasMatch(value)) {
                                return 'Enter Mobile Number with +92 Code';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        RoundButton(
                            title: 'Sign up and Login',
                            loading: loading,
                            onTap: () {
                              setState(() {
                                loading = true;
                              });

                              auth.verifyPhoneNumber(
                                  phoneNumber:
                                      phonenumberController.text.toString(),
                                  verificationCompleted: (_) {
                                    //jaab verifaction ho jaay ge
                                    setState(() {
                                      loading = true;
                                    });
                                  },
                                  //jaab verifaction failed ho jaay ge
                                  verificationFailed: (e) {
                                    setState(() {
                                      loading = false;
                                    });
                                    //execption handling incase of error
                                    Utils().toastMessage(e.toString());
                                  },
                                  //verificationId se user ko verify kia jaay ga
                                  codeSent:
                                      (String verificationID, int? token) {
                                    //agr code aa gya to us ko next screen mai send kr do
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyCodeScreen(
                                                  verificatioID: verificationID,
                                                )));
                                    setState(() {
                                      loading = true;
                                    });
                                  },
                                  codeAutoRetrievalTimeout: (e) {
                                    Utils().toastMessage(e.toString());
                                  });
                              setState(() {
                                loading = false;
                              });
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              (FontAwesomeIcons.facebook),
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              (FontAwesomeIcons.instagram),
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              (FontAwesomeIcons.google),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ]))),

          Flexible(
              flex: 60, // 60%
              child: Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/BG.png'),
                    fit: BoxFit.fill,
                  ),
                  // shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Center(
                          child: const Text(
                            'Real Estate Insignia Admin Portal',
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 20.0, height: 100.0),
                        const SizedBox(width: 20.0, height: 100.0),
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'Horizon',
                              color: Colors.white),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              RotateAnimatedText('From'),
                              RotateAnimatedText('Concept'),
                              RotateAnimatedText('To'),
                              RotateAnimatedText('Creation'),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
