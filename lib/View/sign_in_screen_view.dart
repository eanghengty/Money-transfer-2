import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_verification.dart';
import 'package:truemoneyversion2/View/confirm_lock.dart';
import 'package:truemoneyversion2/View/loading_to_home_screen.dart';
import 'package:truemoneyversion2/View/register_screen_view.dart';
import 'package:truemoneyversion2/View/showforgetpassword.dart';
import 'package:truemoneyversion2/View/sigintohome.dart';
import'package:truemoneyversion2/View/verify_code_screen.dart';
import'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'signupscreen.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formfield = GlobalKey<FormState>();
  // Future getDocId() async{
  //   await FirebaseFirestore.instance.collection('customer').get().then(
  //           (snapshot)=>snapshot.docs.forEach((document) {
  //         print(document['fullname']);
  //
  //       })
  //   );}
  @override
  final changeemailcontroller=TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  void dipose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
    dispose();
  }
  void showt(){
    Fluttertoast.showToast(msg: 'Authenticating, please wait',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.grey,
        fontSize: 15);
  }
  bool enabled=true;
  Future signin() async{
    setState(() {
      enabled=false;
      showt();
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());

      Future.delayed(Duration(seconds: 7)).then((value) =>
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (ctx) => const signintohome())));


    } on FirebaseAuthException catch(error) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: "Wrong email/password",
          desc: "please try again!",
          btnCancelOnPress: () {
            setState(() {
              enabled=true;

            });
          },
          btnOkOnPress: () {
            setState(() {
              enabled=true;

            });
          }
      ).show();
    }


  }
  void initState(){
    super.initState();
    // getDocId();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(''),
      backgroundColor: Colors.transparent,
      bottomOpacity: 0,
      elevation: 0,),
      backgroundColor: Colors.grey[100],
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
                  child: Form(
                      child:Column(
                    key: formfield,
                    children: [
                      Text('Sign in by email', style:
                      TextStyle(
                        fontSize: 24,

                      )),
                      SizedBox(height: 16),

                      TextFormField(
                        enabled: enabled,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',

                        ),
                        validator: (value){
                          bool emailvalid= RegExp(r"^/^\S+@\S+\.\S+$/").hasMatch(value!);
                          if(value.isEmpty){
                            return "Enter the email";
                          }

                          if(!emailvalid){
                            return "Enter the valid email";
                          }


                        },

                      ),
                      SizedBox(height: 16,),
                      TextFormField(
                        enabled: enabled,
                        validator: (value){
                          bool passwordvalid= RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$").hasMatch(value!);
                          if(value.isEmpty){
                            return "Enter the password";
                          }

                          if(!passwordvalid){
                            return "invalid";
                          }
                        },
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'password must be longer than 6',
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
                      enabled==true? AnimatedButton(

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
                      ): Text(''),
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
                      //     elevation: 0,
                      //
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const signup()) );
                      //   },
                      // ),
                      enabled==true?AnimatedButton(
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
                              btnOkOnPress: (){
                                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const signup()) );
                              }
                          ).show();
                        },
                      ):Text(''),
                      SizedBox(height: 16,),
                      InkWell(
                        onTap:(){

                          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const showforgetpassword()));

                        },
                        child: Text('You forgot your password?', style:TextStyle(fontSize: 16,color: Colors.blue),textAlign: TextAlign.center,),
                      )


                    ],
                  )),
                )
              ],
            )
        ),

      )
    );
  }
}
