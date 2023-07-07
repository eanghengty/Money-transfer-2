import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/confirm_lock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FirstLock extends StatefulWidget {
  const FirstLock({Key? key}) : super(key: key);

  @override
  State<FirstLock> createState() => _FirstLockState();
}

class _FirstLockState extends State<FirstLock> {

  String passwordlockcontroller1 = "";
  String passwordlockcontroller2 = "";
  String passwordlockcontroller3 = "";
  String passwordlockcontroller4 = "";
  String isitnext1="no";
  String isitnext2="no";
  String isitnext3="no";
  String isitnext4="no";
  final currentuser=FirebaseAuth.instance;

  Future adduserdetail() async{
    await FirebaseFirestore.instance.collection('passlock').add({
      'passlock1':passwordlockcontroller1,
      'passlock2':passwordlockcontroller2,
      'passlock3':passwordlockcontroller3,
      'passlock4':passwordlockcontroller4,
      'uid':currentuser.currentUser!.uid,
    });
  }
  void initState(){
    super.initState();
  }

  Widget num_button({required String text, Icon icon_data=const Icon(Icons.done_rounded,size:16,color: Colors.white,)}){
    if(text=='10'){
      return ElevatedButton(
        onPressed: (){

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
          adduserdetail();
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const ConfirmLock() ));
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
        appBar: AppBar(title: Center(child: Text('Set Up Password',
          style: TextStyle(
              color: Colors.white
          ),),),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          elevation: 0,),
        body: SingleChildScrollView(
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
                    isitnext4=="next5"?Icon(Icons.circle,color: Colors.white,): Icon(Icons.circle_outlined,color: Colors.white,),
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
                    num_button(text:'2'),
                    SizedBox(width: 30,),
                    num_button(text:'11'),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}

