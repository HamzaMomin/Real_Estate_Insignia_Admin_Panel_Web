import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_application/Button/roundbutton.dart';
import 'package:flutter_web_application/home_screen.dart';
import 'package:flutter_web_application/property_check_dbms.dart';
import 'package:flutter_web_application/utils/utlis.dart';

import 'Firebase_auth/mobile_number.dart';
import 'Firebase_auth/verifiy_OTP_mobile_screen.dart';
import 'mainpage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}


  

class _LoginState extends State<Login> {
 
 bool isLoading = false;
  final auth = FirebaseAuth.instance;
   //dispose function
  @override
 



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            
             title: const Center(
              child: Text(
            'Real Estate Insignia Portal',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white)
              ),
        ),
        ),

      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                flex: 35, // 15%
                child: Container(
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
    
                //keybord numbers wala display ho ga
                
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                // controller: phonenumberController,
                maxLength:13,
                decoration: InputDecoration(
                  
                  hintText: 'Enter your phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0) 
                   
                    )
                    
                ),
              ),
                   
                    RoundButton(title:'Sign up and Login',  loading: loading,
               onTap: (){
                
                  setState(() {
                      loading = true;
                  });
                  
                  auth.verifyPhoneNumber(
                    
                  // phoneNumber:  phonenumberController.text.toString(),
                  
                  verificationCompleted: (_){
    
                    
                      //jaab verifaction ho jaay ge
                      setState(() {
                    loading = true;
                  });
                  }, 
                  //jaab verifaction failed ho jaay ge
                  verificationFailed: (e){
                     setState(() {
                    loading = false;
                  });
                    //execption handling incase of error
                    Utils().toastMessage(e.toString());
                  }, 
                  //verificationId se user ko verify kia jaay ga
                  codeSent: (String verificationID , int? token)
                  {
                    //agr code aa gya to us ko next screen mai send kr do
                      Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>  VerifyCodeScreen(verificatioID: verificationID,)));
                      setState(() {
                    loading = true;
                  });
                  }, 
                  codeAutoRetrievalTimeout: (e){
                     Utils().toastMessage(e.toString());
                  });
                   setState(() {
                    loading = false;
                  });
    
               })
                   
                    ],
                    
                  ),
                )),
            Flexible(
                flex: 60, // 60%
                child: Container(
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: Column(),
                )),
            
          ],
        ),
      ),
    );
    
    
  }
}