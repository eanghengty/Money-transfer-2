import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/sigintohome.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import'package:truemoneyversion2/View/transfer_success.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
class showforgetpassword extends StatefulWidget {
  const showforgetpassword({Key? key}) : super(key: key);

  @override
  State<showforgetpassword> createState() => _showforgetpasswordState();
}

class _showforgetpasswordState extends State<showforgetpassword> {


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
                Text('Do you want to reset your password?',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.black
                  ),),
                SizedBox(height: 16,),
                Container(
                  width: 300,
                  height: 100,
                  child: TextField(


                      controller: changeemailcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your Email',

                      ),
                  )


                ),
                SizedBox(height: 16,),
                ElevatedButton(
                  child: Text("forget password account", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    elevation: 0,

                  ),
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "sent the email now",
                      desc: "Are you sure?",
                      btnOkOnPress: () {
                        passwordreset();
                      },
                      btnCancelOnPress: (){
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const SignInScreen() ));
                      }


                    ).show();

                  },)


              ])
        ))
    );
  }
}
