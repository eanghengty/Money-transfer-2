import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_verification.dart';
import 'package:truemoneyversion2/View/loading_to_home_screen.dart';
import 'package:truemoneyversion2/View/register_screen_view.dart';
import'package:truemoneyversion2/View/verify_code_screen.dart';
import'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'signupscreen.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('customer')..get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document['fullname']);

        })
    );}
  @override
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  void dipose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
    dispose();
  }
  Future signin() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => const LoadingToHome()));
    } on FirebaseAuthException catch(error) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: "Wrong email/password",
          desc: "please try again!",
          btnCancelOnPress: () {},
          btnOkOnPress: () {}
      ).show();
    }

  }
  void initState(){
    super.initState();
    getDocId();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(''),
      backgroundColor: Colors.transparent,
      bottomOpacity: 0,
      elevation: 0,),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16),
            child:Column(
              children: [
                Container(
                  child:Lottie.network('https://assets10.lottiefiles.com/packages/lf20_lgvdhvlz.json'),
                  width: double.infinity,
                  height: 200,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Sign in by email', style:
                      TextStyle(
                        fontSize: 24,

                      )),
                      SizedBox(height: 16),
                      TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),),
                      SizedBox(height: 16,),
                      TextField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'password',
                        ),),
                      SizedBox(height: 16,),
                      // Text('Tap on this "done" button to verify the code that send to your number.'),
                      SizedBox(height: 16,),
                      // GestureDetector(
                      //   onTap: signin,
                      //   child: Container(
                      //       decoration: BoxDecoration(color: Colors.blue),
                      //       width: 90,
                      //       height: 50,
                      //       child: Center(
                      //         child: Text("Done", style: TextStyle(color: Colors.white,)),
                      //       )
                      //   ),),
                      AnimatedButton(
                        text:'Sign in',
                        color: Colors.blue,
                        pressEvent: (){
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "Sign in",
                              desc: "Are you sign in your account now?",
                              btnCancelOnPress: (){},
                              btnOkOnPress: (){
                                signin();
                              }
                          ).show();
                        },
                      ),
                      // ElevatedButton(
                      //   child: Text("Done", style:
                      //   TextStyle(color: Colors.white,)),
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.lightBlue,
                      //     elevation: 0,
                      //
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const VerifyCode() ));
                      //   },
                      // ),
                      SizedBox(height: 16,),
                      // Text('Tap on this "Register" button to register new account for your starting your money transfer process.'),
                      // SizedBox(height: 16,),
                      // ElevatedButton(
                      //   child: Text("Register", style:
                      //   TextStyle(color: Colors.white,)),
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.lightBlue,
                      //     elevation: 0,
                      //
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const signup()) );
                      //   },
                      // ),
                      AnimatedButton(
                        text:'Sign up',
                        color: Colors.orange,
                        pressEvent: (){
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "Sign up",
                              desc: "Are you new to our MTA?",
                              btnCancelOnPress: (){},
                              btnOkOnPress: (){
                                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const signup()) );
                              }
                          ).show();
                        },
                      ),
                      SizedBox(height: 16,),
                      Text('Tap on this "Agent" button to sigin as agent account.'),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        child: Text("Agent", style:
                        TextStyle(color: Colors.white,)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          elevation: 0,

                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const AgentVerification() ));
                        },
                      ),
                      SizedBox(height: 16,),

                    ],
                  ),
                )
              ],
            )
        ),
      )
    );
  }
}
