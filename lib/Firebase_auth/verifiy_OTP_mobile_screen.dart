import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_application/home_screen.dart';

import '../Button/roundbutton.dart';
import '../mainpage.dart';


class VerifyCodeScreen extends StatefulWidget {
  //id is screen pr aay ge 
  //final private hota hai 
  final String verificatioID ;
  const VerifyCodeScreen({Key? key , required this.verificatioID}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyCodeScreen> {
 bool loading = false;

  final verifyCode = TextEditingController();
  final auth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    
    return  Container(
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
          backgroundColor: Colors.transparent,
          title: Center(child: Text('Verifiy OTP' ,style: TextStyle(fontSize:30.0 , color: Colors.white ),)),
        ),
    
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
                SizedBox(height: 50,),
    
                Text('Enter 6 digit code send on your mobile number! ' , style: TextStyle(fontSize: 15 , color: Colors.white),),

                
                 SizedBox(height: 20,), 
    
   
                TextFormField(
                  //keybord numbers wala display ho ga
                  // keyboardType: TextInputType.number,
                  controller: verifyCode,
                   style: TextStyle(fontSize: 15, color: Colors.white),
                  decoration: InputDecoration(
                     
                    hintText: 'Please Enter OTP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0) )
                  ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                    ],
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Enter 6 Digit code';
                      } else {
                        return null;
                      }
                    },
                ),
    
                SizedBox(height: 30,),
    
                RoundButton(title:'Verify', loading: loading,
                 onTap: ()async{
                  setState(() {
                    loading = true;
                  });
                  final credential =  PhoneAuthProvider.credential(
                    //widget . verificationID back screen se aa rehi hai
                    verificationId: widget.verificatioID, 
                    //verifyCode crontroller pr sms aay
                    smsCode: verifyCode.text.toString(),
                    
                  );
                  
                 
    
                        //try cache firebase exception hai
                        try{
                          await auth.signInWithCredential(credential);
                                  ///jaab auto verifiy ho jaa ga code to next screeen pr lay jaao
                                  ///
                       Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
    
                        }catch(e){
                            setState(() {
                              loading = false;
                            });
                        }
                 }
                 )
          ]),
        ),
    
    
      ),
    );
  }
  }
