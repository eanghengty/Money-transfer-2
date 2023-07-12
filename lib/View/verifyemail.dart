import 'dart:async';

import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/register_screen_view.dart';
import 'package:truemoneyversion2/View/sigintohome.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import'package:truemoneyversion2/View/transfer_success.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
class verifyemail extends StatefulWidget {
  const verifyemail({Key? key}) : super(key: key);

  @override
  State<verifyemail> createState() => _verifyemailState();
}

class _verifyemailState extends State<verifyemail> {
  bool isemailverify=false;
  Timer? timer;
  void initState(){
    super.initState();
    isemailverify=FirebaseAuth.instance.currentUser!.emailVerified;
    print(isemailverify);
    if(!isemailverify){
      sendverificationemail();
      timer=Timer.periodic(Duration(seconds: 10),
              (timer) => checkemailverify());
    }
  }
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  Future checkemailverify() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isemailverify=FirebaseAuth.instance.currentUser!.emailVerified;
      print("check: "+ isemailverify.toString());
    });
  }
  Future sendverificationemail() async{
    try{
      final user=FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      print('sent email');
      print(FirebaseAuth.instance.currentUser!.uid);
    } catch (e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
            content:Text(e.toString())
        );
      });
    }
  }

  final changeemailcontroller=TextEditingController();


  shift_to_make_transfer(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const SignInScreen() )));
  }
  Future passwordreset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: changeemailcontroller.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
            content:Text('Reset link sent!')
        );


      });
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const SignInScreen() ));
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
            content:Text(e.message.toString())
        );
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(child:Container(
            height: 500,
            child:Column(
                children: [
                  Text('Please verify your email in mail box',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.black
                    ),),
                  SizedBox(height: 16,),

                  ElevatedButton(
                    child: Text("already verify", style:
                    TextStyle(color: Colors.white,)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      elevation: 0,

                    ),
                    onPressed: () {
                      isemailverify==true?AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "email verified",
                          desc: "",
                          btnOkOnPress: () {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const RegisterString() ));
                          },
                          btnCancelOnPress: (){

                          }


                      ).show(): Text('');

                    },)


                ])
        ))
    );
  }
}
