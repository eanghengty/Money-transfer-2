import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoadingToHome extends StatefulWidget {
  const LoadingToHome({Key? key}) : super(key: key);

  @override
  State<LoadingToHome> createState() => _LoadingToHomeState();
}

class _LoadingToHomeState extends State<LoadingToHome> {

  // fetchdata() async{
  //   final data= await FirebaseAuth.instance.currentUser();
  //   if(data!=null){
  //       await Firestore.instance.collection('customer').document(data.uid).get().then((value){
  //
  //       });
  //     }
  //   }
  // }

  List<String> docIDs=['test'];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            docIDs.add(document['userrole']);
          });
          shift_to_home();
        })
    );
  }
  void dispose(){
    super.dispose();
  }
  @override
  void initState() {
    getDocId();
    // TODO: implement initState
    super.initState();

  }
  shift_to_home(){
    if(docIDs[1]=='agent'){
      Future.delayed(Duration(seconds: 5)).then((value) =>
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const AgentHomeScreen() )));
    }else if(docIDs[1]=='admin'){
      Future.delayed(Duration(seconds: 5)).then((value) =>
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const adminhomescreen() )));
    }
      else{
      Future.delayed(Duration(seconds: 5)).then((value) =>
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const HomeScreen() )));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_jzpjbmvd.json'),
            ),
            SizedBox(height: 16,),
            Text('Please be patience...')
          ],
        ),
      )
    );
  }
}
