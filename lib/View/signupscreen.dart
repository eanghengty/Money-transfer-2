import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_verification.dart';
import 'package:truemoneyversion2/View/register_screen_view.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import'package:truemoneyversion2/View/verify_code_screen.dart';
import'package:flutter/cupertino.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmedpasswordcontroller=TextEditingController();
  void dipose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmedpasswordcontroller.dispose();
    dispose();
  }
  Future signup() async{
    if(passwordconfirmed()){
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim());

          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (ctx) => const RegisterString()));

      } on FirebaseAuthException catch(error){
        AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Error",
            desc: error.toString(),
            btnCancelOnPress: () {},
            btnOkOnPress: () {}
        ).show();
      }
    }
  }
  bool passwordconfirmed(){
    // if(passwordcontroller.toString().length<=10 && confirmedpasswordcontroller.toString().length<=10){
    //   AwesomeDialog(
    //       context: context,
    //       dialogType: DialogType.error,
    //       animType: AnimType.topSlide,
    //       showCloseIcon: true,
    //       title: "password not secure",
    //       desc: "please use more than 10 characters, and mix with number and symbol",
    //       btnOkOnPress: () {}
    //   ).show();
    //   return false;
    // }
    if(passwordcontroller.text.trim()==confirmedpasswordcontroller.text.trim()){
      return true;
    }else{
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: "password not match",
          desc: "please try again!",
          btnOkOnPress: () {}
      ).show();
      return false;
    }
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
                        Text('Sign up by email', style:
                        TextStyle(
                          fontSize: 24,

                        )),
                        SizedBox(height: 16),
                        TextField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'email',
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
                        TextField(
                          controller: confirmedpasswordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'confirm password',
                          ),),
                        SizedBox(height: 16,),
                        Text('Tap on this "done" button to signup.'),
                        SizedBox(height: 16,),
                        GestureDetector(
                          onTap: signup,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.blue),
                            width: 90,
                            height: 50,
                            child: Center(
                              child: Text("Sign up", style: TextStyle(color: Colors.white,)),
                            )
                          )

                        ),
                        // ElevatedButton(
                        //   child: Text("Confirm Register",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       )),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.lightBlue,
                        //     elevation: 0,
                        //   ),
                        //   onPressed: signup
                        // ),
                        SizedBox(height: 16,),
                        Text('Tap on this "Register" button to register new account for your starting your money transfer process.'),
                        SizedBox(height: 16,),
                        ElevatedButton(
                          child: Text("sign in", style:
                          TextStyle(color: Colors.white,)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            elevation: 0,

                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const SignInScreen() ));
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
