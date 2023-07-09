import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/loading_to_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:truemoneyversion2/View/register_screen_view.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
class ConfirmLock extends StatefulWidget {
  const ConfirmLock({Key? key}) : super(key: key);

  @override
  State<ConfirmLock> createState() => _ConfirmLockState();
}

class _ConfirmLockState extends State<ConfirmLock> {
  String passwordlockcontroller1 = "";
  String passwordlockcontroller2 = "";
  String passwordlockcontroller3 = "";
  String passwordlockcontroller4 = "";
  String isitnext1="no";
  String isitnext2="no";
  String isitnext3="no";
  String isitnext4="no";
  final currentuser=FirebaseAuth.instance;
  List<String> docIDs=['test'];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('passlock').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            docIDs.add(document['passlock1']);
            docIDs.add(document['passlock2']);
            docIDs.add(document['passlock3']);
            docIDs.add(document['passlock4']);
            print(docIDs.length);
          });
        })
    );
  }
  List<dynamic> getcustomerinfo=[];
  Future getcustomer() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: '').get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {

            getcustomerinfo.add(document['uid']);
            print('customer uid: '+getcustomerinfo[0]);

            if(FirebaseAuth.instance.currentUser!.uid != getcustomerinfo[0]){

              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: "Your account info is valid, please fill in to register",
                  desc:"Please try again",
                  btnOkOnPress: () {
                    FirebaseFirestore.instance.collection('customer').doc(document.reference.id).delete();
                    print("document: "+ document.reference.id + " deleted");
                    // FirebaseFirestore.instance.collection('passlock').doc(document.reference.id).delete();
                    // print("document: "+ document.reference.id + " deleted");
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const RegisterString() ));
                  }
              ).show();
            }else{
              print(FirebaseAuth.instance.currentUser!.uid);
            }

          });
        })
    );
  }
  List<dynamic> getcustomeractivatestatus=[];
  Future getstatus() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {

            getcustomeractivatestatus.add(document['accountactivated']);
            print('customer uid: '+getcustomeractivatestatus[0]);

            if(getcustomeractivatestatus[0]=='no'){

              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: "activating issue",
                  desc:"Your account is disacivated, please check with agent.",
                  btnOkOnPress: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const SignInScreen() ));
                  }
              ).show();
            }else{
              print(FirebaseAuth.instance.currentUser!.uid);
            }

          });
        })
    );
  }


  void initState(){
    super.initState();
    getDocId();
    getstatus();
    getcustomer();
  }
  @override
  Widget num_button({required String text, Icon icon_data=const Icon(Icons.done_rounded,size:16,color: Colors.white,)}){
    if(text=='10'){
      return ElevatedButton(
        onPressed: (){
          if(isitnext4=="next5"){
            setState(() {
              passwordlockcontroller4=text;
              isitnext4="no";

            });
          }else if(isitnext3=="next4"){
            setState(() {
              passwordlockcontroller3=text;
              isitnext3="no";
              isitnext4="no";
            });
          }else if(isitnext2=="next3"){
            setState(() {
              passwordlockcontroller2=text;
              isitnext2="no";
              isitnext3="no";
            });
          }else if(isitnext1=="next1")
            setState(() {
              passwordlockcontroller1=text;
              isitnext1="no";
              isitnext2="no";
            });
        },
        child: icon_data,
        style: ElevatedButton.styleFrom(
            elevation:2,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(30),
            side: BorderSide(color: Colors.blue),
            shape: CircleBorder(),
            maximumSize: Size.square(100)
        ),);
    }
    else if(text=='11'){
      return ElevatedButton(
        onPressed: (){
          if(docIDs[1]==passwordlockcontroller1 && docIDs[2]==passwordlockcontroller2 && docIDs[3]==passwordlockcontroller3 && docIDs[4]==passwordlockcontroller4){
            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const LoadingToHome() ));

          }
          else{
            AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                title: "Password not match",
                desc:"Please try again",
                btnOkOnPress: () {

                }
            ).show();
          }
        },
        child: icon_data,
        style: ElevatedButton.styleFrom(
            elevation:2,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(30),
            side: BorderSide(color: Colors.blue),
            shape: CircleBorder(),
            maximumSize: Size.square(100)
        ),);
    }
    else{
      return ElevatedButton(
        onPressed: (){
          if(isitnext4=="next4"){
            setState(() {
              passwordlockcontroller4=text;
              isitnext4="next5";

            });
          }else if(isitnext3=="next3"){
            setState(() {
              passwordlockcontroller3=text;
              isitnext3="next4";
              isitnext4="next4";
            });
          }else if(isitnext2=="next2"){
            setState(() {
              passwordlockcontroller2=text;
              isitnext2="next3";
              isitnext3="next3";
            });
          }else if(isitnext1=="no")
            setState(() {
              passwordlockcontroller1=text;
              isitnext1="next1";
              isitnext2="next2";
            });
        },
        child: Text(text,
          style: TextStyle(color: Colors.white,
              fontSize: 24),),
        style: ElevatedButton.styleFrom(
            elevation:2,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(30),
            side: BorderSide(color: Colors.blue),
            shape: CircleBorder(),
            maximumSize: Size.square(100)
        ),);
    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(title: Center(child: Text('Confirm Password',
          style: TextStyle(
              color: Colors.white
          ),),),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          elevation: 0,),
        body:
        docIDs.length==5? SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child:Column(
              children: [
                Center(
                    child:Container(
                      width: 150,
                      height: 150,
                      child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_cfcpu6nf.json'),
                    )
                ),
                Center(
                  child: Text('Enter passcode',
                      style:TextStyle(
                          color:Colors.white,
                          fontSize: 16
                      )),
                ),
                SizedBox(height: 16,),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isitnext1=="next1"?Icon(Icons.circle,color: Colors.white,): Icon(Icons.circle_outlined,color: Colors.white,),
                    SizedBox(width: 10,),
                    isitnext2=="next3"?Icon(Icons.circle,color: Colors.white,): Icon(Icons.circle_outlined,color: Colors.white,),
                    SizedBox(width: 10,),
                    isitnext3=="next4"?Icon(Icons.circle,color: Colors.white,): Icon(Icons.circle_outlined,color: Colors.white,),
                    SizedBox(width: 10,),
                    isitnext4=="next5"?Icon(Icons.circle,color: Colors.white,): Icon(Icons.circle_outlined,color: Colors.white,)
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    num_button(text:'1'),
                    SizedBox(width: 30,),
                    num_button(text:'2'),
                    SizedBox(width: 30,),
                    num_button(text:'3'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    num_button(text:'4'),
                    SizedBox(width: 30,),
                    num_button(text:'5'),
                    SizedBox(width: 30,),
                    num_button(text:'6'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    num_button(text:'7'),
                    SizedBox(width: 30,),
                    num_button(text:'8'),
                    SizedBox(width: 30,),
                    num_button(text:'9'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    num_button(text:'10',icon_data: Icon(Icons.cancel_outlined,size:16,color: Colors.white,)),
                    SizedBox(width: 30,),
                    num_button(text:'0'),
                    SizedBox(width: 30,),
                    num_button(text:'11'),
                  ],
                )
              ],
            ),
          ),
        ) :
        Container(
            padding: EdgeInsets.all(16),
            child:Column(
              children: [
            Center(
            child:Container(
            width: 150,
              height: 150,
              child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_cfcpu6nf.json'),
            )
        ),]))
    );
  }
}
